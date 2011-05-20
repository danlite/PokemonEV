//
//  TrackerViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonListDelegate.h"

@class Pokemon;

@interface TrackerViewController : UITableViewController <PokemonListDelegate>
{
	NSManagedObjectContext *managedObjectContext;
	
	Pokemon *pokemon;
}

@property (nonatomic, retain) Pokemon *pokemon;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;
- (id)initWithPokemon:(Pokemon *)pkmn;

@end
