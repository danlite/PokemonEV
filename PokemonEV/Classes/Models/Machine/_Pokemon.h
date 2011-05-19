// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to Pokemon.h instead.

#import <CoreData/CoreData.h>


@class EVSpread;
@class PokemonSpecies;
@class EVSpread;
@class HeldItem;


@interface PokemonID : NSManagedObjectID {}
@end

@interface _Pokemon : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PokemonID*)objectID;




@property (nonatomic, retain) EVSpread* goalSpread;
//- (BOOL)validateGoalSpread:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) PokemonSpecies* species;
//- (BOOL)validateSpecies:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) EVSpread* currentSpread;
//- (BOOL)validateCurrentSpread:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) HeldItem* heldItem;
//- (BOOL)validateHeldItem:(id*)value_ error:(NSError**)error_;



@end

@interface _Pokemon (CoreDataGeneratedAccessors)

@end

@interface _Pokemon (CoreDataGeneratedPrimitiveAccessors)



- (EVSpread*)primitiveGoalSpread;
- (void)setPrimitiveGoalSpread:(EVSpread*)value;



- (PokemonSpecies*)primitiveSpecies;
- (void)setPrimitiveSpecies:(PokemonSpecies*)value;



- (EVSpread*)primitiveCurrentSpread;
- (void)setPrimitiveCurrentSpread:(EVSpread*)value;



- (HeldItem*)primitiveHeldItem;
- (void)setPrimitiveHeldItem:(HeldItem*)value;


@end
