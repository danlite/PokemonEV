// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EVSpread.m instead.

#import "_EVSpread.h"

@implementation EVSpreadID
@end

@implementation _EVSpread

+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription insertNewObjectForEntityForName:@"EVSpread" inManagedObjectContext:moc_];
}

+ (NSString*)entityName {
	return @"EVSpread";
}

+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_ {
	NSParameterAssert(moc_);
	return [NSEntityDescription entityForName:@"EVSpread" inManagedObjectContext:moc_];
}

- (EVSpreadID*)objectID {
	return (EVSpreadID*)[super objectID];
}




@dynamic attack;



- (short)attackValue {
	NSNumber *result = [self attack];
	return [result shortValue];
}

- (void)setAttackValue:(short)value_ {
	[self setAttack:[NSNumber numberWithShort:value_]];
}

- (short)primitiveAttackValue {
	NSNumber *result = [self primitiveAttack];
	return [result shortValue];
}

- (void)setPrimitiveAttackValue:(short)value_ {
	[self setPrimitiveAttack:[NSNumber numberWithShort:value_]];
}





@dynamic hp;



- (short)hpValue {
	NSNumber *result = [self hp];
	return [result shortValue];
}

- (void)setHpValue:(short)value_ {
	[self setHp:[NSNumber numberWithShort:value_]];
}

- (short)primitiveHpValue {
	NSNumber *result = [self primitiveHp];
	return [result shortValue];
}

- (void)setPrimitiveHpValue:(short)value_ {
	[self setPrimitiveHp:[NSNumber numberWithShort:value_]];
}





@dynamic spDefense;



- (short)spDefenseValue {
	NSNumber *result = [self spDefense];
	return [result shortValue];
}

- (void)setSpDefenseValue:(short)value_ {
	[self setSpDefense:[NSNumber numberWithShort:value_]];
}

- (short)primitiveSpDefenseValue {
	NSNumber *result = [self primitiveSpDefense];
	return [result shortValue];
}

- (void)setPrimitiveSpDefenseValue:(short)value_ {
	[self setPrimitiveSpDefense:[NSNumber numberWithShort:value_]];
}





@dynamic defense;



- (short)defenseValue {
	NSNumber *result = [self defense];
	return [result shortValue];
}

- (void)setDefenseValue:(short)value_ {
	[self setDefense:[NSNumber numberWithShort:value_]];
}

- (short)primitiveDefenseValue {
	NSNumber *result = [self primitiveDefense];
	return [result shortValue];
}

- (void)setPrimitiveDefenseValue:(short)value_ {
	[self setPrimitiveDefense:[NSNumber numberWithShort:value_]];
}





@dynamic spAttack;



- (short)spAttackValue {
	NSNumber *result = [self spAttack];
	return [result shortValue];
}

- (void)setSpAttackValue:(short)value_ {
	[self setSpAttack:[NSNumber numberWithShort:value_]];
}

- (short)primitiveSpAttackValue {
	NSNumber *result = [self primitiveSpAttack];
	return [result shortValue];
}

- (void)setPrimitiveSpAttackValue:(short)value_ {
	[self setPrimitiveSpAttack:[NSNumber numberWithShort:value_]];
}





@dynamic speed;



- (short)speedValue {
	NSNumber *result = [self speed];
	return [result shortValue];
}

- (void)setSpeedValue:(short)value_ {
	[self setSpeed:[NSNumber numberWithShort:value_]];
}

- (short)primitiveSpeedValue {
	NSNumber *result = [self primitiveSpeed];
	return [result shortValue];
}

- (void)setPrimitiveSpeedValue:(short)value_ {
	[self setPrimitiveSpeed:[NSNumber numberWithShort:value_]];
}





@dynamic yieldSpecies;

	

@dynamic goalPokemon;

	

@dynamic currentPokemon;

	



@end
