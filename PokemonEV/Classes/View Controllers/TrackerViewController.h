//
//  TrackerViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SpeciesListDelegate.h"
#import "HeldItemListDelegate.h"
#import "PokemonListDelegate.h"

@class Pokemon;
@class EVCountFooterCell;
@class EVSpread;
@class UseItemListViewController;

@interface TrackerViewController : UITableViewController <PokemonListDelegate, SpeciesListDelegate, HeldItemListDelegate, UIActionSheetDelegate, UITextFieldDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	Pokemon *pokemon;
  
  NSMutableDictionary *evViewControllers;
  EVCountMode evMode;
  
  EVCountFooterCell *evCountFooterCell;
  
  NSManagedObjectContext *editingContext;
  EVSpread *editingCurrentSpread, *editingGoalSpread;
	
	TTButton *pokerusButton;
	CALayer *goalHighlight;
	
	NSArray *recentEncounters;
	
	UseItemListViewController *useItemListVC;
	BOOL changesFromConsumableItem;
	
	BOOL showingPokemonNameSection;
}

@property (nonatomic, retain) Pokemon *pokemon;
@property (nonatomic, retain) EVCountFooterCell *evCountFooterCell;

@property (nonatomic, retain) NSManagedObjectContext *editingContext;
@property (nonatomic, retain) EVSpread *editingEVSpread;

@property (nonatomic, retain) NSArray *recentEncounters;

@property (nonatomic, retain) UseItemListViewController *useItemListVC;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (id)initWithPokemon:(Pokemon *)pkmn;

- (void)evGoalTapped;
- (void)evCurrentTapped;
- (void)evDoneTapped;

@end
