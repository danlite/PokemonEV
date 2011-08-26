// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PokemonEncounter.h instead.

#import <CoreData/CoreData.h>


@class Pokemon;
@class PokemonSpecies;




@interface PokemonEncounterID : NSManagedObjectID {}
@end

@interface _PokemonEncounter : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PokemonEncounterID*)objectID;




@property (nonatomic, retain) NSNumber *count;


@property short countValue;
- (short)countValue;
- (void)setCountValue:(short)value_;

//- (BOOL)validateCount:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) NSDate *date;


//- (BOOL)validateDate:(id*)value_ error:(NSError**)error_;





@property (nonatomic, retain) Pokemon* pokemon;

//- (BOOL)validatePokemon:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) PokemonSpecies* species;

//- (BOOL)validateSpecies:(id*)value_ error:(NSError**)error_;




@end

@interface _PokemonEncounter (CoreDataGeneratedAccessors)

@end

@interface _PokemonEncounter (CoreDataGeneratedPrimitiveAccessors)


- (NSNumber*)primitiveCount;
- (void)setPrimitiveCount:(NSNumber*)value;

- (short)primitiveCountValue;
- (void)setPrimitiveCountValue:(short)value_;




- (NSDate*)primitiveDate;
- (void)setPrimitiveDate:(NSDate*)value;





- (Pokemon*)primitivePokemon;
- (void)setPrimitivePokemon:(Pokemon*)value;



- (PokemonSpecies*)primitiveSpecies;
- (void)setPrimitiveSpecies:(PokemonSpecies*)value;


@end
