//
//  PokemonListDelegate.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PokemonSpecies;
@class SpeciesListViewController;

@protocol SpeciesListDelegate <NSObject>

- (void)speciesList:(SpeciesListViewController *)listVC choseSpecies:(PokemonSpecies *)species;

@end
