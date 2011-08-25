//
//  Constants.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-22.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum EVCountMode
{
  EVCountModeView,
  EVCountModeEditGoal,
  EVCountModeEditCurrent
} EVCountMode;


typedef enum PokemonStatID
{
	PokemonStatFirst     = 0,
	PokemonStatHP        = PokemonStatFirst,
	PokemonStatAttack,
	PokemonStatDefense,
	PokemonStatSpAttack,
	PokemonStatSpDefense,
	PokemonStatSpeed,
	PokemonStatLast      = PokemonStatSpeed
} PokemonStatID;

typedef enum ConsumableItemType
{
	BerryItemType,
	VitaminItemType,
	WingItemType
} ConsumableItemType;

extern NSString * const EVCountInputChanged;

extern NSInteger const ShowCurrentEVs;
extern NSInteger const ShowGoalEVs;
extern NSInteger const MaximumStatEVCount;
extern NSInteger const MaximumTotalEVCount;
extern NSInteger const MaximumUsefulTotalEVCount;
extern NSInteger const PowerItemEVAddition;
extern NSInteger const MaximumVitaminEVAllotment;
extern NSInteger const VitaminEVChange;
extern NSInteger const WingEVChange;
extern NSInteger const BerryEVChange;
extern NSInteger const BerryEVCutoffAmount;
extern CGFloat const kRecentTimerAnimationDuration;

@interface Constants : NSObject {
    
}

@end
