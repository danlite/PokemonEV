#import "_PokemonSpecies.h"

@interface PokemonSpecies : _PokemonSpecies {}

- (NSInteger)effortForStat:(PokemonStatID)statID;
- (NSString *)fullName;
- (NSDictionary *)effortDictionary;

@end
