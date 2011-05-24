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




@dynamic date;






@dynamic pokemon;

	

@dynamic species;

	





@end
