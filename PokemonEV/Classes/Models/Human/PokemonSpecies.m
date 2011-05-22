#import "PokemonSpecies.h"
#import "EVSpread.h"

@implementation PokemonSpecies

- (NSString *)fullName
{
	if (self.formName)
		return [NSString stringWithFormat:@"%@ (%@)", self.name, self.formName];
	
	return self.name;
}

- (NSString *)uppercaseNameInitial
{
	[self willAccessValueForKey:@"uppercaseNameInitial"];
	
	NSString *retString = [[[self valueForKey:@"name"] uppercaseString] substringToIndex:1];
	
	[self didAccessValueForKey:@"uppercaseNameInitial"];
	
	return retString;
}

- (NSDictionary *)effortDictionary
{
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	
	for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
	{
		NSInteger effort = [self.yield effortForStat:i];
		if (effort > 0)
			[dict setObject:[NSNumber numberWithInt:effort] forKey:[NSNumber numberWithInt:i]];
	}
		
	return dict;
}

@end
