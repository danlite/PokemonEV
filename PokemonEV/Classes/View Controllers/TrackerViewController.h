//
//  TrackerViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonListDelegate.h"
#import "HeldItemListDelegate.h"

@class Pokemon;
@class EVCountFooterCell;
@class EVSpread;

@interface TrackerViewController : UITableViewController <PokemonListDelegate, HeldItemListDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	Pokemon *pokemon;
  
  NSMutableDictionary *evViewControllers;
  EVCountMode evMode;
  
  EVCountFooterCell *evCountFooterCell;
  
  NSManagedObjectContext *editingContext;
  EVSpread *editingCurrentSpread, *editingGoalSpread;
}

@property (nonatomic, retain) Pokemon *pokemon;
@property (nonatomic, retain) EVCountFooterCell *evCountFooterCell;

@property (nonatomic, retain) NSManagedObjectContext *editingContext;
@property (nonatomic, retain) EVSpread *editingEVSpread;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (id)initWithPokemon:(Pokemon *)pkmn;

- (void)evGoalTapped;
- (void)evCurrentTapped;
- (void)evDoneTapped;

@end
