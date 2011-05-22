//
//  StatFilterButton.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "StatFilterButton.h"
#import "PokemonStats.h"

NSString * const StatFilterButtonSelected = @"StatFilterButtonSelected";

@implementation StatFilterButton

@synthesize statID;

- (id)initWithStat:(PokemonStatID)stat
{
	if ((self = [super initWithFrame:CGRectMake(0, 0, 44, 30)]))
	{
		statID = stat;
		
		[self setTitle:[PokemonStats nameForStat:statID length:5] forState:UIControlStateNormal];
		
		[self setStyle:
		 [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
			[TTLinearGradientFillStyle styleWithColor1:RGBCOLOR(255, 255, 255)
																					color2:RGBCOLOR(216, 221, 231) next:
			 [TTSolidBorderStyle styleWithColor:RGBACOLOR(161, 167, 178, 0) width:1 next:
				[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) next:
				 [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]  color:TTSTYLEVAR(linkTextColor)
										minimumFontSize:8 shadowColor:[UIColor colorWithWhite:1.0 alpha:0.5]
											 shadowOffset:CGSizeMake(0, -1) next:nil]
				 ]
				]
			 ]
			]
					forState:UIControlStateNormal];
		
		[self setStyle:
		 [TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:8] next:
			[TTSolidFillStyle styleWithColor:[PokemonStats colourForStat:statID] next:
			 [TTInnerShadowStyle styleWithColor:[UIColor colorWithWhite:0 alpha:0.5] blur:4 offset:CGSizeMake(0, 1) next:
			 [TTSolidBorderStyle styleWithColor:[[UIColor darkGrayColor] colorWithAlphaComponent:0.5] width:1 next:
				[TTBoxStyle styleWithPadding:UIEdgeInsetsMake(2, 2, 2, 2) next:
				 [TTTextStyle styleWithFont:[UIFont boldSystemFontOfSize:13]  color:[UIColor whiteColor]
										minimumFontSize:8 shadowColor:[UIColor colorWithWhite:0 alpha:0.4]
											 shadowOffset:CGSizeMake(0, 1) next:nil]]]]]]
					forState:UIControlStateSelected];
		
		[self addTarget:self action:@selector(touchedDown) forControlEvents:UIControlEventTouchDown];
	}
	
	return self;
}

#pragma mark - Control handler

- (void)touchedDown
{
	self.selected = !self.selected;
	[[NSNotificationCenter defaultCenter] postNotificationName:StatFilterButtonSelected object:self];
}

- (void)dealloc
{
	[super dealloc];
}

@end
