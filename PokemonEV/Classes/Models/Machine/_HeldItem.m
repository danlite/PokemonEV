// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HeldItem.m instead.

#import "_HeldItem.h"

@implementation HeldItemID
@end

@implementation _HeldItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"HeldItem" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"HeldItem";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"HeldItem" inManagedObjectContext:moc_];
}

- (HeldItemID*)objectID {
	return (HeldItemID*)[super objectID];
}




@dynamic identifier;






@dynamic trainingStat;



- (short)trainingStatValue {
	NSNumber *result = [self trainingStat];
	return [result shortValue];
}

- (void)setTrainingStatValue:(short)value_ {
	[self setTrainingStat:[NSNumber numberWithShort:value_]];
}

- (short)primitiveTrainingStatValue {
	NSNumber *result = [self primitiveTrainingStat];
	return [result shortValue];
}

- (void)setPrimitiveTrainingStatValue:(short)value_ {
	[self setPrimitiveTrainingStat:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic pokemon;

	



@end
