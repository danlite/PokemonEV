//
//  PokemonStats.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>


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

@interface PokemonStats : NSObject

+ (NSString *)nameForStat:(PokemonStatID)statID length:(NSInteger)length;
+ (NSString *)nameForStat:(PokemonStatID)statID;
+ (UIColor *)colourForStat:(PokemonStatID)statID;

@end
