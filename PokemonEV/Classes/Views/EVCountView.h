//
//  EVCountView.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokemonStats.h"

@interface EVCountView : TTView
{
	PokemonStatID statID;
	NSInteger goal;
	NSInteger current;
}

@property (nonatomic, assign) NSInteger goal, current;

- (id)initWithStat:(PokemonStatID)stat;

@end
