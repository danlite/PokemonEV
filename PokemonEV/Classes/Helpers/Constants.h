//
//  Constants.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-22.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum EVCountMode
{
  EVCountModeView,
  EVCountModeEditGoal,
  EVCountModeEditCurrent
} EVCountMode;


typedef enum PokemonStatID
{
	PokemonStatFirst     = 0,
	PokemonStatHP        = PokemonStatFirst,
	PokemonStatAttack,
	PokemonStatDefense,
	PokemonStatSpAttack,
	PokemonStatSpDefense,
	PokemonStatSpeed,
	PokemonStatLast      = PokemonStatSpeed
} PokemonStatID;


@interface Constants : NSObject {
    
}

@end
