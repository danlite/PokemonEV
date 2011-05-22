#import "EVSpread.h"

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

- (NSInteger)totalEffort
{
  NSInteger sum = 0;
  for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
  {
    sum += [self effortForStat:i];
  }
  return sum;
}

@end
