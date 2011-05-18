//
//  EVYieldView.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVYieldView.h"


@implementation EVYieldView

- (id)initWithStat:(PokemonStatID)stat value:(NSInteger)value
{
	if (self = [super initWithFrame:CGRectMake(0, 0, 32, 40)])
	{
		statID = stat;
		effortValue = value;
	}
	
	self.style =
		[TTShapeStyle styleWithShape:[TTRoundedRectangleShape shapeWithRadius:5] next:
		 [TTSolidFillStyle styleWithColor:[PokemonStats colourForStat:statID] next:
			[TTInnerShadowStyle styleWithColor:RGBACOLOR(0,0,0, 0.5) blur:4 offset:CGSizeMake(0, 1) next:
			 [TTSolidBorderStyle styleWithColor:[UIColor darkGrayColor] width:1 next:nil]]]];
	
	self.opaque = NO;
	self.backgroundColor = [UIColor clearColor];
	
	return self;
}

- (void)drawContent:(CGRect)rect
{
	CGContextRef context = UIGraphicsGetCurrentContext();	
	CGContextSetFillColorWithColor(context, [[UIColor whiteColor] CGColor]);
	
	CGRect textRect = CGRectOffset(rect, 0, 2);
	
	NSString *title = [PokemonStats nameForStat:statID length:3];	
	[title drawInRect:textRect withFont:[UIFont boldSystemFontOfSize:11] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
	
	CGFloat titleHeight = 8;
	
	NSString *evString = [NSString stringWithFormat:@"%d", effortValue];
	CGRect evRect = CGRectOffset(CGRectInset(textRect, 0, titleHeight / 2), 0, titleHeight);
	[evString drawInRect:evRect withFont:[UIFont boldSystemFontOfSize:22] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
}

- (void)dealloc
{
	[super dealloc];
}


@end
