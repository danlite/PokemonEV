#import "_Pokemon.h"

@class PokemonSpecies;

@interface Pokemon : _Pokemon {}

+ (Pokemon *)insertFromSpecies:(PokemonSpecies *)species inManagedObjectContext:(NSManagedObjectContext *)context;

- (NSDictionary *)addEffortFromPokemon:(PokemonSpecies *)species;
- (void)setModified;

@end
