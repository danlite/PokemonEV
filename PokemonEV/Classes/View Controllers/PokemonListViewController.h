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
  
	NSManagedObjectContext *managedObjectContext;
	NSFetchedResultsController *fetchedResults;
	NSFetchedResultsController *fetchedSearchResults;
}

@property (nonatomic) BOOL showEVYield;

@property (nonatomic, retain) NSFetchedResultsController *fetchedSearchResults;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
