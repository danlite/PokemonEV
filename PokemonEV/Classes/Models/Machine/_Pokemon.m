// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pokemon.m instead.

#import "_Pokemon.h"

@implementation PokemonID
@end

@implementation _Pokemon

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Pokemon" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Pokemon";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Pokemon" inManagedObjectContext:moc_];
}

- (PokemonID*)objectID {
	return (PokemonID*)[super objectID];
}




@dynamic goalSpread;

	

@dynamic species;

	

@dynamic currentSpread;

	

@dynamic heldItem;

	



@end
