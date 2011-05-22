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

@interface TrackerViewController : UITableViewController <PokemonListDelegate, HeldItemListDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	Pokemon *pokemon;
  
  NSMutableDictionary *evViewControllers;
  EVCountMode evMode;
  
  EVCountFooterCell *evCountFooterCell;
}

@property (nonatomic, retain) Pokemon *pokemon;
@property (nonatomic, retain) EVCountFooterCell *evCountFooterCell;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (id)initWithPokemon:(Pokemon *)pkmn;

@end
