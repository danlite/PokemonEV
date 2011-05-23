#import "_Pokemon.h"

@class PokemonSpecies;

@interface Pokemon : _Pokemon {}

- (NSDictionary *)addEffortFromPokemon:(PokemonSpecies *)species;

@end
