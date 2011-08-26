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

+ (NSSet *)keyPathsForValuesAffectingValueForKey:(NSString *)key {
	NSSet *keyPaths = [super keyPathsForValuesAffectingValueForKey:key];
	
	if ([key isEqualToString:@"attackValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"attack"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"defenseValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"defense"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"hpValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"hp"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"spAttackValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"spAttack"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"spDefenseValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"spDefense"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}
	if ([key isEqualToString:@"speedValue"]) {
		NSSet *affectingKey = [NSSet setWithObject:@"speed"];
		keyPaths = [keyPaths setByAddingObjectsFromSet:affectingKey];
	}

	return keyPaths;
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





@dynamic currentPokemon;

	

@dynamic goalPokemon;

	

@dynamic yieldSpecies;

	





@end
