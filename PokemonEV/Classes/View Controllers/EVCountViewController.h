//
//  EVCountViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-21.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@class EVCountView;

@interface EVCountViewController : NSObject <UITextFieldDelegate>
{
  EVCountView *view;
  
  PokemonStatID statID;
	NSInteger goal;
	NSInteger current;
	
	NSInteger pointChange;
  
  EVCountMode mode;
  
  CALayer *containerLayer;
  CALayer *textLayer;
  CALayer *maskLayer;
  CALayer *editLayer;
	CALayer *pointLayer;
  
  UITextField *textField;
	
	BOOL shouldPulse;
}

@property (nonatomic, readonly) EVCountView *view;
@property (nonatomic, readonly) PokemonStatID statID;
@property (nonatomic, assign) NSInteger goal, current;
@property (nonatomic, assign) EVCountMode mode;
@property (nonatomic, readonly) UITextField *textField;

- (id)initWithStatID:(PokemonStatID)stat;
- (void)animatePulseWithValue:(NSInteger)value;

@end
