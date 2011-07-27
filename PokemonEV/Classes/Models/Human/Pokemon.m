#import "Pokemon.h"
#import "PokemonSpecies.h"
#import "HeldItem.h"
#import "EVSpread.h"
#import "ConsumableItem.h"
#import "BerryItem.h"
#import "VitaminItem.h"
#import "WingItem.h"

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

- (BOOL)canConsumeItem:(ConsumableItem *)item
{
	PokemonStatID statID = item.statValue;
	NSInteger currentEV = [self.currentSpread effortForStat:statID];
	NSInteger currentTotalEVs = [self.currentSpread totalEffort];
	
	if ([item isKindOfClass:[BerryItem class]])
	{
		return currentEV > 0;
	}
	else if ([item isKindOfClass:[VitaminItem class]])
	{
		return (currentEV + VitaminEVChange) <= MaximumVitaminEVAllotment && currentTotalEVs < MaximumTotalEVCount;
	}
	else if ([item isKindOfClass:[WingItem class]])
	{
		return (currentEV + WingEVChange) <= MaximumStatEVCount && currentTotalEVs < MaximumTotalEVCount;
	}
	
	return NO;
}

- (NSInteger)useItem:(ConsumableItem *)item
{
	PokemonStatID statID = item.statValue;
	EVSpread *currentSpread = self.currentSpread;
	NSInteger currentEV = [currentSpread effortForStat:statID];
	
	if (![self canConsumeItem:item])
		return 0;
	
	if ([item isKindOfClass:[BerryItem class]])
	{
		if (currentEV > BerryEVCutoffAmount && true) // true = Gen 4/5 berries
		{
			NSInteger newValue = BerryEVCutoffAmount;
			[currentSpread setEffort:newValue forStat:statID];
			return newValue - currentEV;
		}
		else
		{
			NSInteger change = MIN(BerryEVChange, currentEV);
			[currentSpread setEffort:currentEV - change forStat:statID];
			return -change;
		}
	}
	else if ([item isKindOfClass:[VitaminItem class]])
	{
		NSInteger currentTotal = [currentSpread totalEffort];
		NSInteger newTotal = MIN(currentTotal + VitaminEVChange, MaximumTotalEVCount);
		NSInteger difference = newTotal - currentTotal;
		
		[currentSpread setEffort:currentEV + difference forStat:statID];
		return difference;
	}
	else if ([item isKindOfClass:[WingItem class]])
	{
		[currentSpread setEffort:currentEV + WingEVChange forStat:statID];
		return WingEVChange;
	}
	
	return 0;
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

- (void)setModified
{
	self.lastModified = [NSDate date];
}

@end
