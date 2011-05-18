#import "PokemonSpecies.h"

@implementation PokemonSpecies

- (NSInteger)effortForStat:(PokemonStatID)statID
{
	switch (statID)
	{
		case PokemonStatHP:
			return self.hpEffortValue;
		case PokemonStatAttack:
			return self.attackEffortValue;
		case PokemonStatDefense:
			return self.defenseEffortValue;
		case PokemonStatSpAttack:
			return self.spAttackEffortValue;
		case PokemonStatSpDefense:
			return self.spDefenseEffortValue;
		case PokemonStatSpeed:
			return self.speedEffortValue;
	}
	
	return 0;
}

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
		NSInteger effort = [self effortForStat:i];
		if (effort > 0)
			[dict setObject:[NSNumber numberWithInt:effort] forKey:[NSNumber numberWithInt:i]];
	}
		
	return dict;
}

@end
