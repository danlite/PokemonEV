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

@interface PokemonListViewController : UITableViewController <SpeciesListDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	NSFetchedResultsController *fetchedResults;
	
	BOOL showGoalEVs;
	
	id<PokemonListDelegate> delegate;
}

@property (nonatomic, assign) id<PokemonListDelegate> delegate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
