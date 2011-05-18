#import "_PokemonSpecies.h"
#import "PokemonStats.h"

@interface PokemonSpecies : _PokemonSpecies {}

- (NSInteger)effortForStat:(PokemonStatID)statID;
- (NSString *)fullName;
- (NSDictionary *)effortDictionary;

@end
