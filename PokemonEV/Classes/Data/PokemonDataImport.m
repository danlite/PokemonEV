//
//  PokemonDataImport.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "PokemonDataImport.h"
#import "PokemonSpecies.h"

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
			[pokemon setValue:[pokemonData objectForKey:key] forKey:key];
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

@end
