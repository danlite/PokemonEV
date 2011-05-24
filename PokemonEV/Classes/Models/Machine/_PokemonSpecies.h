// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PokemonSpecies.h instead.

#import <CoreData/CoreData.h>


@class Pokemon;
@class PokemonEncounter;
@class EVSpread;








@interface PokemonSpeciesID : NSManagedObjectID {}
@end

@interface _PokemonSpecies : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PokemonSpeciesID*)objectID;



@property (nonatomic, retain) NSString *uppercaseNameInitial;

//- (BOOL)validateUppercaseNameInitial:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *iconFilename;

//- (BOOL)validateIconFilename:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *dexNumber;

@property short dexNumberValue;
- (short)dexNumberValue;
- (void)setDexNumberValue:(short)value_;

//- (BOOL)validateDexNumber:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *formName;

//- (BOOL)validateFormName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *formOrder;

@property short formOrderValue;
- (short)formOrderValue;
- (void)setFormOrderValue:(short)value_;

//- (BOOL)validateFormOrder:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Pokemon* pokemon;
//- (BOOL)validatePokemon:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSSet* encounters;
- (NSMutableSet*)encountersSet;



@property (nonatomic, retain) EVSpread* yield;
//- (BOOL)validateYield:(id*)value_ error:(NSError**)error_;




@end

@interface _PokemonSpecies (CoreDataGeneratedAccessors)

- (void)addEncounters:(NSSet*)value_;
- (void)removeEncounters:(NSSet*)value_;
- (void)addEncountersObject:(PokemonEncounter*)value_;
- (void)removeEncountersObject:(PokemonEncounter*)value_;

@end

@interface _PokemonSpecies (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveUppercaseNameInitial;
- (void)setPrimitiveUppercaseNameInitial:(NSString*)value;


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSString*)primitiveIconFilename;
- (void)setPrimitiveIconFilename:(NSString*)value;


- (NSNumber*)primitiveDexNumber;
- (void)setPrimitiveDexNumber:(NSNumber*)value;

- (short)primitiveDexNumberValue;
- (void)setPrimitiveDexNumberValue:(short)value_;


- (NSString*)primitiveFormName;
- (void)setPrimitiveFormName:(NSString*)value;


- (NSNumber*)primitiveFormOrder;
- (void)setPrimitiveFormOrder:(NSNumber*)value;

- (short)primitiveFormOrderValue;
- (void)setPrimitiveFormOrderValue:(short)value_;




- (Pokemon*)primitivePokemon;
- (void)setPrimitivePokemon:(Pokemon*)value;



- (NSMutableSet*)primitiveEncounters;
- (void)setPrimitiveEncounters:(NSMutableSet*)value;



- (EVSpread*)primitiveYield;
- (void)setPrimitiveYield:(EVSpread*)value;


@end
