//
//  EVCountView.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EVCountView : TTView
{
	PokemonStatID statID;
}

- (id)initWithStat:(PokemonStatID)stat;

@end
