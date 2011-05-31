#import "EVSpread.h"
#import "PokemonStats.h"
#import "NSManagedObject+Errors.h"

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

- (BOOL)matchesSpread:(EVSpread *)spread
{
	for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
	{
		if ([self effortForStat:i] != [spread effortForStat:i])
			return NO;
	}
	
	return YES;
}

- (BOOL)validateForUpdate:(NSError **)error
{
  BOOL statsValid = [super validateForUpdate:NULL];
  
  BOOL totalValid = ([self totalEffort] <= MaximumTotalEVCount);
  
  if (error != NULL)
  {
    if (!statsValid)
    {
      NSError *statsError = [NSError
                             errorWithDomain:NSCocoaErrorDomain
                             code:NSManagedObjectValidationError
                             userInfo:[NSDictionary
                                       dictionaryWithObjectsAndKeys:
                                       @"There cannot be more than 255 EVs in a single stat.", NSLocalizedFailureReasonErrorKey,
                                       self, NSValidationObjectErrorKey,
                                       nil]];
      
      if (*error == nil)
        *error = statsError;
      else
        *error = [self errorFromOriginalError:*error error:statsError];
    }
    
    if (!totalValid)
    {
      NSError *totalError = [NSError
                             errorWithDomain:NSCocoaErrorDomain
                             code:NSManagedObjectValidationError
                             userInfo:[NSDictionary
                                       dictionaryWithObjectsAndKeys:
                                       @"A Pokémon cannot have more than 510 EVs in total.", NSLocalizedFailureReasonErrorKey,
                                       self, NSValidationObjectErrorKey,
                                       nil]];
      
      if (*error == nil)
        *error = totalError;
      else
        *error = [self errorFromOriginalError:*error error:totalError];
    }
  }
  
  return totalValid && statsValid;
}

@end
