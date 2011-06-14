// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to WingItem.m instead.

#import "_WingItem.h"

@implementation WingItemID
@end

@implementation _WingItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Wing" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Wing";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Wing" inManagedObjectContext:moc_];
}

- (WingItemID*)objectID {
	return (WingItemID*)[super objectID];
}








@end
