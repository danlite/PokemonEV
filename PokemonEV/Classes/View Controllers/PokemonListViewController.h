//
//  PokemonListViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonListDelegate.h"

@interface PokemonListViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
  BOOL showEVYield;
	BOOL filterByStat;
	
	id<PokemonListDelegate> delegate;
  
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResults;
	NSFetchedResultsController *fetchedSearchResults;
	
	NSArray *statFilterButtons;
	NSNumber *selectedStatFilter;
}

@property (nonatomic) BOOL showEVYield;
@property (nonatomic, assign) id<PokemonListDelegate> delegate;
@property (nonatomic, retain) NSFetchedResultsController *fetchedSearchResults;
@property (nonatomic, retain) NSArray *statFilterButtons;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
