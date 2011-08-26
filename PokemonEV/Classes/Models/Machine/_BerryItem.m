// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to BerryItem.m instead.

#import "_BerryItem.h"

@implementation BerryItemID
@end

@implementation _BerryItem

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Berry" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Berry";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Berry" inManagedObjectContext:moc_];
}

- (BerryItemID*)objectID {
	return (BerryItemID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	

	return keyPaths;
}








@end
