//
//  EVStyleSheet.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-20.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVStyleSheet.h"
#import "Three20Style/UIColorAdditions.h"

@implementation EVStyleSheet

- (TTStyle*)midGrayToolbarButton:(UIControlState)state
{
  return
  [self toolbarButtonForState:state
                        shape:[TTRoundedRectangleShape shapeWithRadius:4.5]
                    tintColor:RGBCOLOR(80, 80, 80)
                         font:nil];
}

- (TTStyle *)imageTitleToolbarButton:(UIControlState)state
{
	TTShape *shape = [TTRoundedRectangleShape shapeWithRadius:4.5];
	
	UIColor *tintColor = TTSTYLEVAR(toolbarTintColor);
	
	UIColor* stateTintColor = state == UIControlStateHighlighted ? [tintColor multiplyHue:1 saturation:2 value:0.7] : [tintColor multiplyHue:1 saturation:1.6 value:0.97];
  UIColor* stateTextColor = [UIColor whiteColor];//[self toolbarButtonTextColorForState:state];
	
	return
		[TTShapeStyle styleWithShape:shape next:
		[TTInsetStyle styleWithInset:UIEdgeInsetsMake(2, 0, 1, 0) next:
		[TTShadowStyle styleWithColor:RGBACOLOR(255,255,255,0.18) blur:0 offset:CGSizeMake(0, 1) next:
		[TTReflectiveFillStyle styleWithColor:stateTintColor next:
		[TTBevelBorderStyle styleWithHighlight:[stateTintColor multiplyHue:1 saturation:0.9 value:0.7]
																		shadow:[stateTintColor multiplyHue:1 saturation:0.5 value:0.6]
																		 width:1 lightSource:270 next:
		[TTInsetStyle styleWithInset:UIEdgeInsetsMake(0, -1, 0, -1) next:
		[TTBevelBorderStyle styleWithHighlight:nil shadow:RGBACOLOR(0,0,0,0.15)
																		 width:1 lightSource:270 next:
		[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(8, 8, 8, 8) next:
		[TTPartStyle styleWithName:@"image" style:TTSTYLESTATE(imageTitleToolbarButtonImage:, state) next:
		[TTTextStyle styleWithFont:nil
												 color:stateTextColor shadowColor:[UIColor colorWithWhite:0 alpha:0.4]
									shadowOffset:CGSizeMake(0, 1) next:nil]]]]]]]]]];
}

- (TTStyle*)imageTitleToolbarButtonImage:(UIControlState)state
{
  TTStyle* style =
	[TTBoxStyle styleWithMargin:UIEdgeInsetsMake(3, 2, 0, -2) next:
	 [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
    [TTImageStyle styleWithImageURL:nil defaultImage:nil contentMode:UIViewContentModeCenter
															 size:CGSizeZero next:nil]]];
	
  if (state == UIControlStateHighlighted || state == UIControlStateSelected)
	{
  }
	
  return style;
}


@end
