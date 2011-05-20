// DO NOT EDIT. This file is machine-generated and constantly overwritten.
// Make changes to HeldItem.h instead.

#import <CoreData/CoreData.h>


@class Pokemon;





@interface HeldItemID : NSManagedObjectID {}
@end

@interface _HeldItem : NSManagedObject {}
+ (id)insertInManagedObjectContext:(NSManagedObjectContext*)moc_;
+ (NSString*)entityName;
+ (NSEntityDescription*)entityInManagedObjectContext:(NSManagedObjectContext*)moc_;
- (HeldItemID*)objectID;



@property (nonatomic, retain) NSString *identifier;

//- (BOOL)validateIdentifier:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSNumber *trainingStat;

@property short trainingStatValue;
- (short)trainingStatValue;
- (void)setTrainingStatValue:(short)value_;

//- (BOOL)validateTrainingStat:(id*)value_ error:(NSError**)error_;



@property (nonatomic, retain) NSString *name;

//- (BOOL)validateName:(id*)value_ error:(NSError**)error_;




@property (nonatomic, retain) Pokemon* pokemon;
//- (BOOL)validatePokemon:(id*)value_ error:(NSError**)error_;



@end

@interface _HeldItem (CoreDataGeneratedAccessors)

@end

@interface _HeldItem (CoreDataGeneratedPrimitiveAccessors)

- (NSString*)primitiveIdentifier;
- (void)setPrimitiveIdentifier:(NSString*)value;


- (NSNumber*)primitiveTrainingStat;
- (void)setPrimitiveTrainingStat:(NSNumber*)value;

- (short)primitiveTrainingStatValue;
- (void)setPrimitiveTrainingStatValue:(short)value_;


- (NSString*)primitiveName;
- (void)setPrimitiveName:(NSString*)value;




- (Pokemon*)primitivePokemon;
- (void)setPrimitivePokemon:(Pokemon*)value;


@end
