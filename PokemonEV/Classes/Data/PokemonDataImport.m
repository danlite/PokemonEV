//
//  PokemonDataImport.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "PokemonDataImport.h"
#import "PokemonSpecies.h"
#import "EVSpread.h"
#import "HeldItem.h"
#import "ConsumableItem.h"
#import "WingItem.h"
#import "BerryItem.h"
#import "VitaminItem.h"

@implementation PokemonDataImport

+ (BOOL)importPokemonData:(NSManagedObjectContext *)managedObjectContext
{
	NSArray *existingPokemon = [managedObjectContext fetchAllObjectsForEntityName:[PokemonSpecies entityName] withPredicate:nil];
	if ([existingPokemon count])
		return NO;
	
	NSArray *pokedexData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"pokedex" ofType:@"plist"]];
	for (NSDictionary *pokemonData in pokedexData)
	{
		PokemonSpecies *pokemon = [PokemonSpecies insertInManagedObjectContext:managedObjectContext];
		for (NSString *key in [pokemonData allKeys])
		{
			// Handle specific keys
			if ([key isEqualToString:@"yield"])
			{
				NSDictionary *evDict = [pokemonData objectForKey:key];
				EVSpread *spread = [EVSpread insertInManagedObjectContext:managedObjectContext];
				pokemon.yield = spread;
				
				for (NSString *statName in [evDict allKeys])
				{
					[spread setValue:[evDict objectForKey:statName] forKey:statName];
				}
				
				continue;
			}
			
			// Otherwise set the value for the key on the managed object
			[pokemon setValue:[pokemonData objectForKey:key] forKey:key];
		}
	}
	
	NSArray *itemData = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"items" ofType:@"plist"]];
	for (NSDictionary *itemDict in itemData)
	{
		HeldItem *item = [HeldItem insertInManagedObjectContext:managedObjectContext];
		for (NSString *key in [itemDict allKeys])
		{
			[item setValue:[itemDict objectForKey:key] forKey:key];
		}
	}
	
	NSError *error;
	if (![managedObjectContext save:&error])
	{
		DLog(@"Unable to load initial Pokemon data: %@", error);
		[managedObjectContext rollback];
		return NO;
	}
	
	return YES;
}

+ (void)importItems:(NSArray *)itemNames ofClass:(Class)ItemClass inContext:(NSManagedObjectContext *)managedObjectContext
{
	NSInteger statID = PokemonStatFirst;
	for (NSString *itemName in itemNames)
	{
		NSString *suffix = @"";
		if (ItemClass == [WingItem class])
			suffix = @" Wing";
		else if (ItemClass == [BerryItem class])
			suffix = @" Berry";
		
		ConsumableItem *item = [ItemClass insertInManagedObjectContext:managedObjectContext];
		item.statValue = statID++;
		item.name = [NSString stringWithFormat:@"%@%@", itemName, suffix];
	}
}

+ (BOOL)importConsumableItemData:(NSManagedObjectContext *)managedObjectContext
{
	NSArray *consumableItems = [managedObjectContext fetchAllObjectsForEntityName:[ConsumableItem entityName] withPredicate:nil];
	if ([consumableItems count])
		return NO;
	
	NSDictionary *consumableItemData = [NSDictionary dictionaryWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"consumable_items" ofType:@"plist"]];
	
	// Import vitamins
	NSString *keyName = @"vitamins";
	NSArray *items = [consumableItemData objectForKey:keyName];
	[self importItems:items ofClass:[VitaminItem class] inContext:managedObjectContext];
	
	// Import wings
	keyName = @"wings";
	items = [consumableItemData objectForKey:keyName];
	[self importItems:items ofClass:[WingItem class] inContext:managedObjectContext];
	
	// Import berries
	keyName = @"berries";
	items = [consumableItemData objectForKey:keyName];
	[self importItems:items ofClass:[BerryItem class] inContext:managedObjectContext];
	
	NSError *error;
	if (![managedObjectContext save:&error])
	{
		DLog(@"Unable to load consumable item data: %@", error);
		[managedObjectContext rollback];
		return NO;
	}
	
	return YES;
}

@end
