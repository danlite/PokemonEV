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
#import "EVCountViewController.h"


@class Pokemon;

@interface TrackerViewController : UITableViewController <PokemonListDelegate, HeldItemListDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	Pokemon *pokemon;
  
  NSMutableDictionary *evViewControllers;
  EVCountMode evMode;
}

@property (nonatomic, retain) Pokemon *pokemon;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (id)initWithPokemon:(Pokemon *)pkmn;

@end
