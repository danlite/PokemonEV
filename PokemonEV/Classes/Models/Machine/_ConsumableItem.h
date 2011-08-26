// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ConsumableItem.h instead.

#import <CoreData/CoreData.h>






@interface ConsumableItemID : NSManagedObjectID {}
@end

@interface _ConsumableItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (ConsumableItemID*)objectID;




@property (nonatomic, retain) NSString *name;


//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSNumber *stat;


@property short statValue;
- (short)statValue;
- (void)setStatValue:(short)value_;

//- (BOOL)validateStat:(id*)value_ error:(NSError**)error_;





@end

@interface _ConsumableItem (CoreDataGeneratedAccessors)

@end

@interface _ConsumableItem (CoreDataGeneratedPrimitiveAccessors)


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (NSNumber*)primitiveStat;
- (void)setPrimitiveStat:(NSNumber*)value;

- (short)primitiveStatValue;
- (void)setPrimitiveStatValue:(short)value_;




@end
