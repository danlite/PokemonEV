//
//  PokemonListViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface PokemonListViewController : UITableViewController <UISearchDisplayDelegate, UISearchBarDelegate>
{
  BOOL showEVYield;
	BOOL filterByStat;
  
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResults;
	NSFetchedResultsController *fetchedSearchResults;
	
	NSArray *statFilterButtons;
	NSNumber *selectedStatFilter;
}

@property (nonatomic) BOOL showEVYield;
@property (nonatomic, retain) NSFetchedResultsController *fetchedSearchResults;
@property (nonatomic, retain) NSArray *statFilterButtons;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
