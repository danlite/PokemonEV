//
//  NSManagedObject+Errors.h
//  PokemonEV
//
//  Created by Dan Lichty on 10-11-04.
//  Copyright 2010 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSManagedObject (Errors)

- (NSError *)errorFromOriginalError:(NSError *)originalError error:(NSError *)secondError;

@end
