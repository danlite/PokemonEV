#import "_EVSpread.h"

@interface EVSpread : _EVSpread {}

- (NSInteger)effortForStat:(PokemonStatID)statID;
- (void)setEffort:(NSInteger)value forStat:(PokemonStatID)statID;
- (NSInteger)totalEffort;
- (BOOL)isValid;

@end
