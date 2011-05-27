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




@dynamic pokerus;



- (BOOL)pokerusValue {
	NSNumber *result = [self pokerus];
	return [result boolValue];
}

- (void)setPokerusValue:(BOOL)value_ {
	[self setPokerus:[NSNumber numberWithBool:value_]];
}

- (BOOL)primitivePokerusValue {
	NSNumber *result = [self primitivePokerus];
	return [result boolValue];
}

- (void)setPrimitivePokerusValue:(BOOL)value_ {
	[self setPrimitivePokerus:[NSNumber numberWithBool:value_]];
}





@dynamic lastModified;






@dynamic encounters;

	
- (NSMutableSet*)encountersSet {
	[self willAccessValueForKey:@"encounters"];
	NSMutableSet *result = [self mutableSetValueForKey:@"encounters"];
	[self didAccessValueForKey:@"encounters"];
	return result;
}
	

@dynamic goalSpread;

	

@dynamic species;

	

@dynamic currentSpread;

	

@dynamic heldItem;

	



@end
