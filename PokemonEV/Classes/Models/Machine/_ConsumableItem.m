// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to ConsumableItem.m instead.

#import "_ConsumableItem.h"

@implementation ConsumableItemID
@end

@implementation _ConsumableItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"ConsumableItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"ConsumableItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"ConsumableItem" inManagedObjectContext:moc_];
}

- (ConsumableItemID*)objectID {
	return (ConsumableItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"statValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"stat"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic name;






@dynamic stat;



- (short)statValue {
	NSNumber *result = [self stat];
	return [result shortValue];
}

- (void)setStatValue:(short)value_ {
	[self setStat:[NSNumber numberWithShort:value_]];
}

- (short)primitiveStatValue {
	NSNumber *result = [self primitiveStat];
	return [result shortValue];
}

- (void)setPrimitiveStatValue:(short)value_ {
	[self setPrimitiveStat:[NSNumber numberWithShort:value_]];
}









@end
