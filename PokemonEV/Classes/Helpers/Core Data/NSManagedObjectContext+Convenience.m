#import "NSManagedObjectContext+Convenience.h"

@implementation NSManagedObjectContext (Convenience)

- (id)fetchSingleObjectForEntityName:(NSString *)newEntityName
                       withPredicate:(NSPredicate *)predicate
{
  return [self fetchSingleObjectForEntityName:newEntityName withSortDescriptors:nil andPredicate:predicate];
}

- (id)fetchSingleObjectForEntityName:(NSString *)newEntityName
                 withSortDescriptors:(NSArray *)sortDescriptors
                        andPredicate:(NSPredicate *)predicate
{
  NSArray *results = [self fetchAllObjectsForEntityName:newEntityName withSortDescriptors:sortDescriptors andPredicate:predicate];
  
  if (results && [results count] > 0)
    return [results objectAtIndex:0];
  
  return nil;  
}


- (NSArray *)fetchAllObjectsForEntityName:(NSString *)newEntityName
                            withPredicate:(NSPredicate *)predicate
{
  return [self fetchAllObjectsForEntityName:newEntityName withSortDescriptors:nil andPredicate:predicate];
}

- (NSArray *)fetchAllObjectsForEntityName:(NSString *)newEntityName
                      withSortDescriptors:(NSArray *)sortDescriptors
                             andPredicate:(NSPredicate *)predicate;
{
  NSEntityDescription *entity = [NSEntityDescription
                                 entityForName:newEntityName inManagedObjectContext:self];
  
  NSFetchRequest *request = [[[NSFetchRequest alloc] init] autorelease];
  [request setEntity:entity];
  
  if (predicate)
  {
    [request setPredicate:predicate];
  }
  
  if (sortDescriptors)
  {
    [request setSortDescriptors:sortDescriptors];
  }
  
  NSError *error = nil;
  NSArray *results = [self executeFetchRequest:request error:&error];
  if (error != nil)
  {
    DLog(@"%@", error);
  }
  
  return results;
}

@end
