//
//  ConsumableItemCell.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-07-21.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "ConsumableItemCell.h"


@implementation ConsumableItemCell

@synthesize evLabel, statNameLabel, itemNameLabel;

- (void)dealloc
{
	[evLabel release];
	[statNameLabel release];
	[itemNameLabel release];
	[super dealloc];
}

@end
