//
//  EVCountView.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVCountView.h"


@implementation EVCountView

- (id)initWithStat:(PokemonStatID)stat
{
	if ((self = [super initWithFrame:CGRectMake(0, 0, 100, 40)]))
	{
		statID = stat;
		
		TTShape *shape = nil;
		switch (statID)
		{
			case 0:
				shape = [TTRoundedRectangleShape shapeWithTopLeft:8 topRight:0 bottomRight:0 bottomLeft:0];
				break;
			case 2:
				shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:8 bottomRight:0 bottomLeft:0];
				break;
			case 3:
				shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:0 bottomLeft:8];
				break;
			case 5:
				shape = [TTRoundedRectangleShape shapeWithTopLeft:0 topRight:0 bottomRight:8 bottomLeft:0];
				break;
			default:
				shape = [TTRectangleShape shape];
				break;
		}
				
		self.style = [TTShapeStyle styleWithShape:shape next:
									[TTBevelBorderStyle styleWithHighlight:[UIColor whiteColor] shadow:[UIColor lightGrayColor] width:1 lightSource:305 next:
									 [TTSolidFillStyle styleWithColor:[[PokemonStats colourForStat:statID] colorWithAlphaComponent:0.5] next:nil]]];
		
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		[self setNeedsDisplay];
	}
  
	return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
  // Modified from TTView -sizeThatFits:
	TTStyleContext* context = [[[TTStyleContext alloc] init] autorelease];
	context.delegate = self;
	context.font = nil;
	return [_style addToSize:CGSizeMake(100, 40) context:context];
}

@end
