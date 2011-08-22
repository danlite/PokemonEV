//
//  PokemonListViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-26.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonListDelegate.h"
#import "SpeciesListDelegate.h"

@class Pokemon;

@interface PokemonListViewController : UITableViewController <SpeciesListDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	NSFetchedResultsController *fetchedResults;
	
	Pokemon *currentPokemon;
		
	id<PokemonListDelegate> delegate;
}

@property (nonatomic, assign) id<PokemonListDelegate> delegate;
@property (nonatomic, retain) Pokemon *currentPokemon;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
