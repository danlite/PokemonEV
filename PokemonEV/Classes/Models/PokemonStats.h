//
//  PokemonStats.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PokemonStats : NSObject

+ (NSString *)methodPrefixForStat:(PokemonStatID)statID;
+ (NSString *)nameForStat:(PokemonStatID)statID length:(NSInteger)length;
+ (NSString *)nameForStat:(PokemonStatID)statID;
+ (UIColor *)colourForStat:(PokemonStatID)statID;

@end
