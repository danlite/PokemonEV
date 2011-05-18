// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to PokemonSpecies.h instead.

#import <CoreData/CoreData.h>
















@interface PokemonSpeciesID : NSManagedObjectID {}
@end

@interface _PokemonSpecies : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (PokemonSpeciesID*)objectID;



@property (nonatomic, retain) NSString *formName;

//- (BOOL)validateFormName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *spDefenseEffort;

@property short spDefenseEffortValue;
- (short)spDefenseEffortValue;
- (void)setSpDefenseEffortValue:(short)value_;

//- (BOOL)validateSpDefenseEffort:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *formOrder;

@property short formOrderValue;
- (short)formOrderValue;
- (void)setFormOrderValue:(short)value_;

//- (BOOL)validateFormOrder:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *attackEffort;

@property short attackEffortValue;
- (short)attackEffortValue;
- (void)setAttackEffortValue:(short)value_;

//- (BOOL)validateAttackEffort:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *defenseEffort;

@property short defenseEffortValue;
- (short)defenseEffortValue;
- (void)setDefenseEffortValue:(short)value_;

//- (BOOL)validateDefenseEffort:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *speedEffort;

@property short speedEffortValue;
- (short)speedEffortValue;
- (void)setSpeedEffortValue:(short)value_;

//- (BOOL)validateSpeedEffort:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hpEffort;

@property short hpEffortValue;
- (short)hpEffortValue;
- (void)setHpEffortValue:(short)value_;

//- (BOOL)validateHpEffort:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *iconFilename;

//- (BOOL)validateIconFilename:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *spAttackEffort;

@property short spAttackEffortValue;
- (short)spAttackEffortValue;
- (void)setSpAttackEffortValue:(short)value_;

//- (BOOL)validateSpAttackEffort:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *uppercaseNameInitial;

//- (BOOL)validateUppercaseNameInitial:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *dexNumber;

@property short dexNumberValue;
- (short)dexNumberValue;
- (void)setDexNumberValue:(short)value_;

//- (BOOL)validateDexNumber:(id*)value_ error:(NSError**)error_;




@end

@interface _PokemonSpecies (CoreDataGeneratedAccessors)

@end

@interface _PokemonSpecies (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveFormName;
- (void)setPrimitiveFormName:(NSString*)value;


- (NSNumber*)primitiveSpDefenseEffort;
- (void)setPrimitiveSpDefenseEffort:(NSNumber*)value;

- (short)primitiveSpDefenseEffortValue;
- (void)setPrimitiveSpDefenseEffortValue:(short)value_;


- (NSNumber*)primitiveFormOrder;
- (void)setPrimitiveFormOrder:(NSNumber*)value;

- (short)primitiveFormOrderValue;
- (void)setPrimitiveFormOrderValue:(short)value_;


- (NSNumber*)primitiveAttackEffort;
- (void)setPrimitiveAttackEffort:(NSNumber*)value;

- (short)primitiveAttackEffortValue;
- (void)setPrimitiveAttackEffortValue:(short)value_;


- (NSNumber*)primitiveDefenseEffort;
- (void)setPrimitiveDefenseEffort:(NSNumber*)value;

- (short)primitiveDefenseEffortValue;
- (void)setPrimitiveDefenseEffortValue:(short)value_;


- (NSNumber*)primitiveSpeedEffort;
- (void)setPrimitiveSpeedEffort:(NSNumber*)value;

- (short)primitiveSpeedEffortValue;
- (void)setPrimitiveSpeedEffortValue:(short)value_;


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;


- (NSNumber*)primitiveHpEffort;
- (void)setPrimitiveHpEffort:(NSNumber*)value;

- (short)primitiveHpEffortValue;
- (void)setPrimitiveHpEffortValue:(short)value_;


- (NSString*)primitiveIconFilename;
- (void)setPrimitiveIconFilename:(NSString*)value;


- (NSNumber*)primitiveSpAttackEffort;
- (void)setPrimitiveSpAttackEffort:(NSNumber*)value;

- (short)primitiveSpAttackEffortValue;
- (void)setPrimitiveSpAttackEffortValue:(short)value_;


- (NSString*)primitiveUppercaseNameInitial;
- (void)setPrimitiveUppercaseNameInitial:(NSString*)value;


- (NSNumber*)primitiveDexNumber;
- (void)setPrimitiveDexNumber:(NSNumber*)value;

- (short)primitiveDexNumberValue;
- (void)setPrimitiveDexNumberValue:(short)value_;



@end
