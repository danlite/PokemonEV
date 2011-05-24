// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PokemonSpecies.m instead.

#import "_PokemonSpecies.h"

@implementation PokemonSpeciesID
@end

@implementation _PokemonSpecies

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Species" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Species";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Species" inManagedObjectContext:moc_];
}

- (PokemonSpeciesID*)objectID {
	return (PokemonSpeciesID*)[super objectID];
}




@dynamic uppercaseNameInitial;






@dynamic name;






@dynamic iconFilename;






@dynamic dexNumber;



- (short)dexNumberValue {
	NSNumber *result = [self dexNumber];
	return [result shortValue];
}

- (void)setDexNumberValue:(short)value_ {
	[self setDexNumber:[NSNumber numberWithShort:value_]];
}

- (short)primitiveDexNumberValue {
	NSNumber *result = [self primitiveDexNumber];
	return [result shortValue];
}

- (void)setPrimitiveDexNumberValue:(short)value_ {
	[self setPrimitiveDexNumber:[NSNumber numberWithShort:value_]];
}





@dynamic formName;






@dynamic formOrder;



- (short)formOrderValue {
	NSNumber *result = [self formOrder];
	return [result shortValue];
}

- (void)setFormOrderValue:(short)value_ {
	[self setFormOrder:[NSNumber numberWithShort:value_]];
}

- (short)primitiveFormOrderValue {
	NSNumber *result = [self primitiveFormOrder];
	return [result shortValue];
}

- (void)setPrimitiveFormOrderValue:(short)value_ {
	[self setPrimitiveFormOrder:[NSNumber numberWithShort:value_]];
}





@dynamic pokemon;

	

@dynamic encounters;

	
- (NSMutableSet*)encountersSet {
	[self willAccessValueForKey:@"encounters"];
	NSMutableSet *result = [self mutableSetValueForKey:@"encounters"];
	[self didAccessValueForKey:@"encounters"];
	return result;
}
	

@dynamic yield;

	





@end
