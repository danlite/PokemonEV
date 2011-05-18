//
//  NSManagedObject+Errors.m
//  WellpointHealth
//
//  Created by Dan Lichty on 10-11-04.
//  Copyright 2010 Daniel Lichty. All rights reserved.
//

#import "NSManagedObject+Errors.h"


@implementation NSManagedObject (Errors)

- (NSError *)errorFromOriginalError:(NSError *)originalError error:(NSError *)secondError
{
  NSMutableDictionary *userInfo = [NSMutableDictionary dictionary];
  NSMutableArray *errors = [NSMutableArray arrayWithObject:secondError];
  
  if ([originalError code] == NSValidationMultipleErrorsError)
  {
    [userInfo addEntriesFromDictionary:[originalError userInfo]];
    [errors addObjectsFromArray:[userInfo objectForKey:NSDetailedErrorsKey]];
  }
  else
  {
    [errors addObject:originalError];
  }
  
  [userInfo setObject:errors forKey:NSDetailedErrorsKey];
  
  return [NSError errorWithDomain:NSCocoaErrorDomain
                             code:NSValidationMultipleErrorsError
                         userInfo:userInfo];
}

@end
