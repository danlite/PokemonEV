//
//  PokemonSpeciesCell.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-24.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PokemonSpecies;

@interface PokemonSpeciesCell : UITableViewCell
{
	BOOL showEVYield;
}

@property (nonatomic, assign) BOOL showEVYield;

- (void)setPokemon:(PokemonSpecies *)species filteredStat:(NSNumber *)stat;

@end
