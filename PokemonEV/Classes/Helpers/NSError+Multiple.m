//
//  NSError+Multiple.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-23.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "NSError+Multiple.h"


@implementation NSError(Multiple)

- (NSArray *)allFailureReasons
{
  NSMutableArray *reasons = [NSMutableArray array];
  
  if ([self code] == NSValidationMultipleErrorsError)
  {
    NSArray *errors = [[self userInfo] objectForKey:NSDetailedErrorsKey];
    for (NSError *error in errors)
    {
      NSString *reason = [[error userInfo] objectForKey:NSLocalizedFailureReasonErrorKey];
      if (reason)
        [reasons addObject:reason];
    }
  }
  else
  {
    NSString *reason = [[self userInfo] objectForKey:NSLocalizedFailureReasonErrorKey];
    if (reason)
      [reasons addObject:reason];
  }
  
  return reasons;
}

@end
