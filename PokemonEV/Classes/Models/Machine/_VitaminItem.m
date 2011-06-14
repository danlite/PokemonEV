// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to VitaminItem.m instead.

#import "_VitaminItem.h"

@implementation VitaminItemID
@end

@implementation _VitaminItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Vitamin" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Vitamin";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Vitamin" inManagedObjectContext:moc_];
}

- (VitaminItemID*)objectID {
	return (VitaminItemID*)[super objectID];
}








@end
