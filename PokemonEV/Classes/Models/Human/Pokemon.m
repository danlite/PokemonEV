#import "Pokemon.h"
#import "PokemonSpecies.h"
#import "HeldItem.h"
#import "EVSpread.h"

@implementation Pokemon

+ (Pokemon *)insertFromSpecies:(PokemonSpecies *)species inManagedObjectContext:(NSManagedObjectContext *)context
{
	Pokemon *p = [Pokemon insertInManagedObjectContext:context];
	
	p.species = species;
	p.goalSpread = [EVSpread insertInManagedObjectContext:context];
	p.currentSpread = [EVSpread insertInManagedObjectContext:context];
	p.lastModified = [NSDate date];
	
	return p;
}

- (NSDictionary *)addEffortFromPokemon:(PokemonSpecies *)species
{
	NSMutableDictionary *effortDict = [NSMutableDictionary dictionaryWithDictionary:[species effortDictionary]];
	HeldItem *item = [self heldItem];
	
	// Apply training item bonus
	if (item)
	{
		if ([item.name isEqualToString:@"Macho Brace"])
		{
			for (id statKey in [effortDict allKeys])
			{
				NSInteger newEV = [[effortDict objectForKey:statKey] intValue] * 2;
				[effortDict setObject:[NSNumber numberWithInt:newEV] forKey:statKey];
			}
		}
		else
		{
			NSNumber *itemStatKey = [NSNumber numberWithInt:item.trainingStatValue];
			NSNumber *evNumber = [effortDict objectForKey:itemStatKey];
			NSInteger oldEV = evNumber ? [evNumber intValue] : 0;
			NSInteger newEV = oldEV + PowerItemEVAddition;
			[effortDict setObject:[NSNumber numberWithInt:newEV] forKey:itemStatKey];
		}
	}
	
	// Apply Pokérus bonus
	if ([self pokerusValue])
	{
		for (id statKey in [effortDict allKeys])
		{
			NSInteger newEV = [[effortDict objectForKey:statKey] intValue] * 2;
			[effortDict setObject:[NSNumber numberWithInt:newEV] forKey:statKey];
		}
	}
	
	// Add new EVs to current spread
	for (NSNumber *statKey in [effortDict allKeys])
	{
		PokemonStatID statID = [statKey intValue];
		NSInteger originalValue = [self.currentSpread effortForStat:statID];
		NSInteger earnedEVs = [[effortDict objectForKey:statKey] intValue];
		NSInteger newValue = originalValue + earnedEVs;
		if (newValue > MaximumStatEVCount)
		{
			earnedEVs -= newValue - MaximumStatEVCount;
			newValue = MaximumStatEVCount;
		}
		
		if (earnedEVs == 0)
		{
			[effortDict removeObjectForKey:statKey];
		}
		else
		{
			[effortDict setObject:[NSNumber numberWithInt:earnedEVs] forKey:statKey];
		}
		
		[self.currentSpread setEffort:newValue forStat:statID];
	}
	
	if (![self.currentSpread validateForUpdate:nil])
	{
		[[self managedObjectContext] rollback];
		return [NSDictionary dictionary];
	}
	
	return effortDict;
}

@end
