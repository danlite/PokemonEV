//
//  PokemonDataImport.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PokemonDataImport : NSObject

+ (BOOL)importPokemonData:(NSManagedObjectContext *)managedObjectContext;

@end
