// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to EVSpread.h instead.

#import <CoreData/CoreData.h>


@class PokemonSpecies;
@class Pokemon;
@class Pokemon;








@interface EVSpreadID : NSManagedObjectID {}
@end

@interface _EVSpread : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (EVSpreadID*)objectID;



@property (nonatomic, retain) NSNumber *attack;

@property short attackValue;
- (short)attackValue;
- (void)setAttackValue:(short)value_;

//- (BOOL)validateAttack:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *hp;

@property short hpValue;
- (short)hpValue;
- (void)setHpValue:(short)value_;

//- (BOOL)validateHp:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *spDefense;

@property short spDefenseValue;
- (short)spDefenseValue;
- (void)setSpDefenseValue:(short)value_;

//- (BOOL)validateSpDefense:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *defense;

@property short defenseValue;
- (short)defenseValue;
- (void)setDefenseValue:(short)value_;

//- (BOOL)validateDefense:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *spAttack;

@property short spAttackValue;
- (short)spAttackValue;
- (void)setSpAttackValue:(short)value_;

//- (BOOL)validateSpAttack:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *speed;

@property short speedValue;
- (short)speedValue;
- (void)setSpeedValue:(short)value_;

//- (BOOL)validateSpeed:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) PokemonSpecies* yieldSpecies;
//- (BOOL)validateYieldSpecies:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Pokemon* goalPokemon;
//- (BOOL)validateGoalPokemon:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) Pokemon* currentPokemon;
//- (BOOL)validateCurrentPokemon:(id*)value_ error:(NSError**)error_;



@end

@interface _EVSpread (CoreDataGeneratedAccessors)

@end

@interface _EVSpread (CoreDataGeneratedPrimitiveAccessors)

- (NSNumber*)primitiveAttack;
- (void)setPrimitiveAttack:(NSNumber*)value;

- (short)primitiveAttackValue;
- (void)setPrimitiveAttackValue:(short)value_;


- (NSNumber*)primitiveHp;
- (void)setPrimitiveHp:(NSNumber*)value;

- (short)primitiveHpValue;
- (void)setPrimitiveHpValue:(short)value_;


- (NSNumber*)primitiveSpDefense;
- (void)setPrimitiveSpDefense:(NSNumber*)value;

- (short)primitiveSpDefenseValue;
- (void)setPrimitiveSpDefenseValue:(short)value_;


- (NSNumber*)primitiveDefense;
- (void)setPrimitiveDefense:(NSNumber*)value;

- (short)primitiveDefenseValue;
- (void)setPrimitiveDefenseValue:(short)value_;


- (NSNumber*)primitiveSpAttack;
- (void)setPrimitiveSpAttack:(NSNumber*)value;

- (short)primitiveSpAttackValue;
- (void)setPrimitiveSpAttackValue:(short)value_;


- (NSNumber*)primitiveSpeed;
- (void)setPrimitiveSpeed:(NSNumber*)value;

- (short)primitiveSpeedValue;
- (void)setPrimitiveSpeedValue:(short)value_;




- (PokemonSpecies*)primitiveYieldSpecies;
- (void)setPrimitiveYieldSpecies:(PokemonSpecies*)value;



- (Pokemon*)primitiveGoalPokemon;
- (void)setPrimitiveGoalPokemon:(Pokemon*)value;



- (Pokemon*)primitiveCurrentPokemon;
- (void)setPrimitiveCurrentPokemon:(Pokemon*)value;


@end
