//
//  PokemonListDelegate.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PokemonSpecies;
@class PokemonListViewController;

@protocol PokemonListDelegate <NSObject>

- (void)pokemonList:(PokemonListViewController *)listVC chosePokemon:(PokemonSpecies *)species;

@end
