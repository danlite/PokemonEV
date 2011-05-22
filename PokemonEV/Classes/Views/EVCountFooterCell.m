//
//  EVCountFooterCell.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-22.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVCountFooterCell.h"

@interface EVCountFooterCell()

- (void)updateEVTotalLabel;
- (void)updateTitleLabel;

@end


@implementation EVCountFooterCell

@synthesize mode, goal, current;
@synthesize titleLabel, evTotalLabel;

- (void)awakeFromNib
{
  mode = EVCountModeView;
  
  TTView *backgroundView = [[TTView alloc] initWithFrame:CGRectMake(0, 0, 300, 44)];
  backgroundView.style =
  [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:8 bottomLeft:8] next:
   [TTBevelBorderStyle styleWithHighlight:[UIColor lightGrayColor] shadow:[UIColor grayColor] width:1 lightSource:305 next:
    [TTSolidFillStyle styleWithColor:[UIColor whiteColor] next:nil]]];
  backgroundView.opaque = NO;
  backgroundView.backgroundColor = [UIColor clearColor];
  
  [self.contentView insertSubview:backgroundView atIndex:0];
  
  [self updateEVTotalLabel];
  [self updateTitleLabel];
}

- (void)updateEVTotalLabel
{
  if (mode == EVCountModeView)
  {
    evTotalLabel.text = [NSString stringWithFormat:@"%d / %d", current, goal];
  }
  else
  {
    NSInteger value = (mode == EVCountModeEditGoal) ? goal : current;
    evTotalLabel.text = [NSString stringWithFormat:@"%d", value];
  }
}

- (void)updateTitleLabel
{
  if (mode == EVCountModeView)
  {
    titleLabel.text = @"";
  }
  else if (mode == EVCountModeEditGoal)
  {
    titleLabel.text = @"Editing EV goals";
  }
  else if (mode == EVCountModeEditCurrent)
  {
    titleLabel.text = @"Editing current EVs";
  }
}

- (void)setMode:(EVCountMode)aMode
{
  if (aMode == mode)
    return;
  
  mode = aMode;
  
  [self updateEVTotalLabel];
  [self updateTitleLabel];
}

- (void)setGoal:(NSInteger)aGoal
{
  if (aGoal == goal)
    return;
  
  goal = aGoal;
  
  [self updateEVTotalLabel];
}

- (void)setCurrent:(NSInteger)aCurrent
{
  if (aCurrent == current)
    return;
  
  current = aCurrent;
  
  [self updateEVTotalLabel];
}

- (void)dealloc
{
  [titleLabel release];
  [evTotalLabel release];
  [super dealloc];
}

@end
