#import "_Pokemon.h"

@class PokemonSpecies;
@class ConsumableItem;

@interface Pokemon : _Pokemon {}

+ (Pokemon *)insertFromSpecies:(PokemonSpecies *)species inManagedObjectContext:(NSManagedObjectContext *)context;

@property (nonatomic, readonly) NSString *name;

- (NSDictionary *)addEffortFromPokemon:(PokemonSpecies *)species;
- (BOOL)canConsumeItem:(ConsumableItem *)item;
- (NSInteger)useItem:(ConsumableItem *)item;
- (void)setModified;

@end
