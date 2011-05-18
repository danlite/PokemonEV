#import <CoreData/CoreData.h>

@interface NSManagedObjectContext (Convenience)

- (id)fetchSingleObjectForEntityName:(NSString *)newEntityName withPredicate:(NSPredicate *)predicate;
- (id)fetchSingleObjectForEntityName:(NSString *)newEntityName withSortDescriptors:(NSArray *)sortDescriptors andPredicate:(NSPredicate *)predicate;
- (NSArray *)fetchAllObjectsForEntityName:(NSString *)newEntityName withPredicate:(NSPredicate *)predicate;
- (NSArray *)fetchAllObjectsForEntityName:(NSString *)newEntityName withSortDescriptors:(NSArray *)sortDescriptors andPredicate:(NSPredicate *)predicate;

@end
