//
//  PokemonStats.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "PokemonStats.h"
#import "UIColor+Hex.h"

@implementation PokemonStats

NSInteger const MAX_STAT_NAME_LENGTH = 3;

static NSArray *statArray;

+ (NSArray *)statArray
{
	@synchronized(self)
	{
		if (statArray == nil)
		{
			statArray = [[NSArray alloc] initWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"PokemonStats" ofType:@"plist"]];
		}
	}
	return statArray;
}

+ (NSString *)methodPrefixForStat:(PokemonStatID)statID
{
	switch (statID)
	{
		case PokemonStatHP:
			return @"hp";
		case PokemonStatAttack:
			return @"attack";
		case PokemonStatDefense:
			return @"defense";
		case PokemonStatSpAttack:
			return @"spAttack";
		case PokemonStatSpDefense:
			return @"spDefense";
		case PokemonStatSpeed:
			return @"speed";
	}
	
	return @"";
}

+ (NSString *)nameForStat:(PokemonStatID)statID length:(NSInteger)length
{
	if (statID < 0 || statID > [[self statArray] count])
		return @"???";
	
	length = MAX(length, MAX_STAT_NAME_LENGTH);
	
	NSArray *statNames = [[self statArray] objectAtIndex:statID];
	NSInteger index = [statNames count] - 1;
	NSString *bestFitName;
	do
	{
		bestFitName = [statNames objectAtIndex:index--];
	} while ([bestFitName length] > length && index >= 0);
	
	ZAssert([bestFitName length] <= length, @"Stat name '%@' does not fit to length %d.", bestFitName, length);
	
	return bestFitName;
}

+ (NSString *)nameForStat:(PokemonStatID)statID
{
	return [PokemonStats nameForStat:statID length:5];
}

+ (UIColor *)colourForStat:(PokemonStatID)statID
{
	switch (statID)
	{
		case PokemonStatHP: return [UIColor colorWithHex:0x62b255];
		case PokemonStatAttack: return [UIColor colorWithHex:0xe75857];
		case PokemonStatDefense: return [UIColor colorWithHex:0xe7a147];
		case PokemonStatSpAttack: return [UIColor colorWithHex:0xc3498d];
		case PokemonStatSpDefense: return [UIColor colorWithHex:0xe0cc43];
		case PokemonStatSpeed: return [UIColor colorWithHex:0x2bb7da];
	}
	
	return [UIColor lightGrayColor];
}

@end
