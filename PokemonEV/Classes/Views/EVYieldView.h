//
//  EVYieldView.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EVYieldView : TTView
{
	PokemonStatID statID;
	NSInteger effortValue;
}

- (id)initWithStat:(PokemonStatID)stat value:(NSInteger)value;

@end
