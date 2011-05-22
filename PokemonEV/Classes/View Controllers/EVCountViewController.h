//
//  EVCountViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-21.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PokemonStats.h"

@class EVCountView;

typedef enum EVCountMode
{
  EVCountModeView,
  EVCountModeEditGoal,
  EVCountModeEditCurrent
} EVCountMode;

@interface EVCountViewController : NSObject
{
  EVCountView *view;
  
  PokemonStatID statID;
	NSInteger goal;
	NSInteger current;
  
  EVCountMode mode;
  
  CALayer *containerLayer;
  CALayer *textLayer;
  CALayer *maskLayer;
  CALayer *editLayer;
  
  UITextField *textField;
}

@property (nonatomic, readonly) EVCountView *view;
@property (nonatomic, assign) NSInteger goal, current;
@property (nonatomic, assign) EVCountMode mode;
@property (nonatomic, readonly) UITextField *textField;

- (id)initWithStatID:(PokemonStatID)stat;

@end
