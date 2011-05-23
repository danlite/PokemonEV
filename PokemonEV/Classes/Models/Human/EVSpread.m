#import "EVSpread.h"
#import "PokemonStats.h"

@implementation EVSpread

- (NSInteger)effortForStat:(PokemonStatID)statID
{
	switch (statID)
	{
		case PokemonStatHP:
			return self.hpValue;
		case PokemonStatAttack:
			return self.attackValue;
		case PokemonStatDefense:
			return self.defenseValue;
		case PokemonStatSpAttack:
			return self.spAttackValue;
		case PokemonStatSpDefense:
			return self.spDefenseValue;
		case PokemonStatSpeed:
			return self.speedValue;
	}
	
	return 0;
}

- (void)setEffort:(NSInteger)value forStat:(PokemonStatID)statID
{
  NSString *prefix = [PokemonStats methodPrefixForStat:statID];
  [self setValue:[NSNumber numberWithInt:value] forKey:prefix];
}

- (NSInteger)totalEffort
{
  NSInteger sum = 0;
  for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
  {
    sum += [self effortForStat:i];
  }
  return sum;
}

- (BOOL)isValid
{
  NSInteger sum = 0;
  for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
  {
    NSInteger value = [self effortForStat:i];
    
    if (value > 255)
      return NO;
    
    sum += value;
  }
  
  return sum <= 510;
}

@end
