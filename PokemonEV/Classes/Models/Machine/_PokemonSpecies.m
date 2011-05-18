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




@dynamic formName;






@dynamic spDefenseEffort;



- (short)spDefenseEffortValue {
	NSNumber *result = [self spDefenseEffort];
	return [result shortValue];
}

- (void)setSpDefenseEffortValue:(short)value_ {
	[self setSpDefenseEffort:[NSNumber numberWithShort:value_]];
}

- (short)primitiveSpDefenseEffortValue {
	NSNumber *result = [self primitiveSpDefenseEffort];
	return [result shortValue];
}

- (void)setPrimitiveSpDefenseEffortValue:(short)value_ {
	[self setPrimitiveSpDefenseEffort:[NSNumber numberWithShort:value_]];
}





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





@dynamic attackEffort;



- (short)attackEffortValue {
	NSNumber *result = [self attackEffort];
	return [result shortValue];
}

- (void)setAttackEffortValue:(short)value_ {
	[self setAttackEffort:[NSNumber numberWithShort:value_]];
}

- (short)primitiveAttackEffortValue {
	NSNumber *result = [self primitiveAttackEffort];
	return [result shortValue];
}

- (void)setPrimitiveAttackEffortValue:(short)value_ {
	[self setPrimitiveAttackEffort:[NSNumber numberWithShort:value_]];
}





@dynamic defenseEffort;



- (short)defenseEffortValue {
	NSNumber *result = [self defenseEffort];
	return [result shortValue];
}

- (void)setDefenseEffortValue:(short)value_ {
	[self setDefenseEffort:[NSNumber numberWithShort:value_]];
}

- (short)primitiveDefenseEffortValue {
	NSNumber *result = [self primitiveDefenseEffort];
	return [result shortValue];
}

- (void)setPrimitiveDefenseEffortValue:(short)value_ {
	[self setPrimitiveDefenseEffort:[NSNumber numberWithShort:value_]];
}





@dynamic speedEffort;



- (short)speedEffortValue {
	NSNumber *result = [self speedEffort];
	return [result shortValue];
}

- (void)setSpeedEffortValue:(short)value_ {
	[self setSpeedEffort:[NSNumber numberWithShort:value_]];
}

- (short)primitiveSpeedEffortValue {
	NSNumber *result = [self primitiveSpeedEffort];
	return [result shortValue];
}

- (void)setPrimitiveSpeedEffortValue:(short)value_ {
	[self setPrimitiveSpeedEffort:[NSNumber numberWithShort:value_]];
}





@dynamic name;






@dynamic hpEffort;



- (short)hpEffortValue {
	NSNumber *result = [self hpEffort];
	return [result shortValue];
}

- (void)setHpEffortValue:(short)value_ {
	[self setHpEffort:[NSNumber numberWithShort:value_]];
}

- (short)primitiveHpEffortValue {
	NSNumber *result = [self primitiveHpEffort];
	return [result shortValue];
}

- (void)setPrimitiveHpEffortValue:(short)value_ {
	[self setPrimitiveHpEffort:[NSNumber numberWithShort:value_]];
}





@dynamic iconFilename;






@dynamic spAttackEffort;



- (short)spAttackEffortValue {
	NSNumber *result = [self spAttackEffort];
	return [result shortValue];
}

- (void)setSpAttackEffortValue:(short)value_ {
	[self setSpAttackEffort:[NSNumber numberWithShort:value_]];
}

- (short)primitiveSpAttackEffortValue {
	NSNumber *result = [self primitiveSpAttackEffort];
	return [result shortValue];
}

- (void)setPrimitiveSpAttackEffortValue:(short)value_ {
	[self setPrimitiveSpAttackEffort:[NSNumber numberWithShort:value_]];
}





@dynamic uppercaseNameInitial;






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







@end
