// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PokemonEncounter.m instead.

#import "_PokemonEncounter.h"

@implementation PokemonEncounterID
@end

@implementation _PokemonEncounter

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"Encounter" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"Encounter";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"Encounter" inManagedObjectContext:moc_];
}

- (PokemonEncounterID*)objectID {
	return (PokemonEncounterID*)[super objectID];
}

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"countValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"count"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
}




@dynamic count;



- (short)countValue {
	NSNumber *result = [self count];
	return [result shortValue];
}

- (void)setCountValue:(short)value_ {
	[self setCount:[NSNumber numberWithShort:value_]];
}

- (short)primitiveCountValue {
	NSNumber *result = [self primitiveCount];
	return [result shortValue];
}

- (void)setPrimitiveCountValue:(short)value_ {
	[self setPrimitiveCount:[NSNumber numberWithShort:value_]];
}





@dynamic date;






@dynamic pokemon;

	

@dynamic species;

	





@end
