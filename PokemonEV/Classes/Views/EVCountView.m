//
//  EVCountView.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVCountView.h"


@implementation EVCountView

@synthesize goal, current;

- (id)initWithStat:(PokemonStatID)stat
{
	if ((self = [super initWithFrame:CGRectZero]))
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
									 [TTSolidFillStyle styleWithColor:[UIColor colorWithWhite:1 alpha:0.5] next:nil]]];
		
		self.backgroundColor = [UIColor clearColor];
		self.opaque = NO;
		
		[self setNeedsDisplay];
	}
	return self;
}

- (CGSize)sizeThatFits:(CGSize)size
{
	TTStyleContext* context = [[[TTStyleContext alloc] init] autorelease];
	context.delegate = self;
	context.font = nil;
	return [_style addToSize:CGSizeMake(100, 40) context:context];
}

- (void)drawContent:(CGRect)rect
{
	rect = CGRectOffset(rect, 0, 4);
	
	CGFloat rectHeight = rect.size.height;
	CGRect topRect;
	CGRect bottomRect;
	CGRectDivide(rect, &topRect, &bottomRect, rectHeight / 2, CGRectMinYEdge);
	
	if (goal == 0 && current == 0)
		[[UIColor grayColor] set];
	
	NSString *statName = [PokemonStats nameForStat:statID length:12];
	[statName drawInRect:topRect withFont:[UIFont boldSystemFontOfSize:10] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
	
	bottomRect = CGRectOffset(bottomRect, 0, -6);
	
	CGFloat bottomChunkWidth = 42;
	CGRect bottomLeft, bottomMiddle, bottomRight;
	CGRectDivide(bottomRect, &bottomLeft, &bottomRight, bottomChunkWidth, CGRectMinXEdge);
	CGRectDivide(bottomRight, &bottomRight, &bottomMiddle, bottomChunkWidth, CGRectMaxXEdge);
	
	[[NSString stringWithFormat:@"%d", current] drawInRect:bottomLeft withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentRight];
	[@"/" drawInRect:bottomMiddle withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentCenter];
	[[NSString stringWithFormat:@"%d", goal] drawInRect:bottomRight withFont:[UIFont systemFontOfSize:14] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentLeft];
}

@end
