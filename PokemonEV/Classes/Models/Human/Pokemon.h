#import "_Pokemon.h"

@class PokemonSpecies;
@class ConsumableItem;

@interface Pokemon : _Pokemon {}

+ (Pokemon *)insertFromSpecies:(PokemonSpecies *)species inManagedObjectContext:(NSManagedObjectContext *)context;

- (NSDictionary *)addEffortFromPokemon:(PokemonSpecies *)species;
- (BOOL)canConsumeItem:(ConsumableItem *)item;
- (NSInteger)useItem:(ConsumableItem *)item;
- (void)setModified;

@end
