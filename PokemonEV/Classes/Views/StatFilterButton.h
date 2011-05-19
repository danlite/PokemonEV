//
//  StatFilterButton.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PokemonStats.h"

extern NSString * const StatFilterButtonSelected; 

@interface StatFilterButton : TTButton
{
	PokemonStatID statID;
}

@property (nonatomic, readonly) PokemonStatID statID;

- (id)initWithStat:(PokemonStatID)stat;

@end
