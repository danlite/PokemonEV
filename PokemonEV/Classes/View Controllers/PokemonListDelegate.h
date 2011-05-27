//
//  PokemonListDelegate.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-26.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PokemonListViewController;
@class Pokemon;

@protocol PokemonListDelegate <NSObject>

- (void)pokemonList:(PokemonListViewController *)listVC chosePokemon:(Pokemon *)pokemon;

@end
