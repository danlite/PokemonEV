//
//  NSError+Multiple.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-23.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSError(Multiple)

- (NSArray *)allFailureReasons;

@end
