//
//  PokemonSpeciesCell.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-24.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "PokemonSpeciesCell.h"
#import "PokemonStats.h"
#import "PokemonSpecies.h"
#import "EVYieldView.h"

@implementation TimerLayerController

@synthesize spriteImage;
@synthesize completionPercent;

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
	CGRect rect = CGContextGetClipBoundingBox(ctx);
	CGFloat spriteWidth = spriteImage.size.width;
	CGFloat spriteHeight = spriteImage.size.height;
	CGRect spriteRect = CGRectMake(rect.size.width / 2 - spriteWidth / 2, rect.size.height / 2 - spriteHeight / 2 - 2, spriteWidth, spriteHeight);
	CGSize size = rect.size;
	
	CGContextClearRect(ctx, rect);
	
	// Start sector at top of circle
	CGFloat radius = size.width / 2;
	CGFloat circleStart = -0.5 * M_PI;
	CGFloat fullCircle = 2 * M_PI;
	
	// Draw sprite
	UIGraphicsPushContext(ctx);
	[spriteImage drawInRect:spriteRect];
	UIGraphicsPopContext();
	
	if (completionPercent != 1.0)
	{
		// Draw translucent white circle sector
		CGMutablePathRef path = CGPathCreateMutable();
		CGPathMoveToPoint(path, NULL, size.width / 2, size.height / 2);
		CGPathAddArc(path, NULL, size.width / 2, size.height / 2, radius, circleStart, circleStart + completionPercent * fullCircle, true);
		CGPathCloseSubpath(path);
		
		CGContextSetBlendMode(ctx, kCGBlendModeSourceAtop);
		
		CGContextSetFillColorWithColor(ctx, [[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor]);
		CGContextAddPath(ctx, path);
		CGContextDrawPath(ctx, kCGPathFill);
		
		CGPathRelease(path);
	}
	
	// Draw blue circle sector underneath sprite
	CGContextSetBlendMode(ctx, kCGBlendModeDestinationOver);
	
	CGMutablePathRef inversePath = CGPathCreateMutable();
	CGPathMoveToPoint(inversePath, NULL, size.width / 2, size.height / 2);
	CGPathAddArc(inversePath, NULL, size.width / 2, size.height / 2, radius, circleStart, circleStart + completionPercent * fullCircle, false);
	CGPathCloseSubpath(inversePath);
	
	CGContextSetFillColorWithColor(ctx, [[[UIColor blueColor] colorWithAlphaComponent:0.1] CGColor]);
	CGContextAddPath(ctx, inversePath);
	CGContextFillPath(ctx);
	CGPathRelease(inversePath);
}

- (void)dealloc
{
	[spriteImage release];
	[super dealloc];
}

@end

@implementation PokemonSpeciesCell

@synthesize showEVYield;
@synthesize inBattledList;

- (UIImage *)preparedSpriteImage:(PokemonSpecies *)species
{
	UIImage *sourceImage = [UIImage imageNamed:species.iconFilename];
	if (inBattledList && sourceImage.scale != [[UIScreen mainScreen] scale])
	{
		CGFloat factor = [[UIScreen mainScreen] scale] / sourceImage.scale;
		CGImageRef imageRef = sourceImage.CGImage;
		
		// Need to do this for indexed 8-bit PNGs ( http://stackoverflow.com/questions/2457116/iphone-changing-cgimagealphainfo-of-cgimage )
		CGColorSpaceRef genericCS = CGColorSpaceCreateDeviceRGB();
		CGContextRef genericContext = CGBitmapContextCreate(NULL, sourceImage.size.width, sourceImage.size.height, CGImageGetBitsPerComponent(imageRef), sourceImage.size.width * CGImageGetBitsPerPixel(imageRef) * 8, genericCS, kCGImageAlphaPremultipliedFirst);
		CGColorSpaceRelease(genericCS);
		CGRect destRect = CGRectMake(0, 0, sourceImage.size.width, sourceImage.size.height);
		CGContextDrawImage(genericContext, destRect, imageRef);
		CGImageRef genericImageRef = CGBitmapContextCreateImage(genericContext);
		CGContextRelease(genericContext);
		
		// Scale standard-res image 2x to prevent antialiasing
		CGSize newSize = CGSizeApplyAffineTransform(sourceImage.size, CGAffineTransformMakeScale(factor, factor));
		CGRect newRect = CGRectIntegral(CGRectMake(0, 0, newSize.width, newSize.height));
		
		CGContextRef ctx = CGBitmapContextCreate(NULL, newRect.size.width, newRect.size.height, CGImageGetBitsPerComponent(genericImageRef), CGImageGetBytesPerRow(genericImageRef), CGImageGetColorSpace(genericImageRef), CGImageGetBitmapInfo(genericImageRef));
		CGContextSetInterpolationQuality(ctx, kCGInterpolationNone);
		CGContextDrawImage(ctx, newRect, genericImageRef);
		CGImageRelease(genericImageRef);
		
		CGImageRef newImageRef = CGBitmapContextCreateImage(ctx);
		
		UIImage *retImage = [UIImage imageWithCGImage:newImageRef scale:[[UIScreen mainScreen] scale] orientation:UIImageOrientationUp];
		
		CGContextRelease(ctx);
		CGImageRelease(newImageRef);
		
		return retImage;
	}
	else
	{
		return sourceImage;
	}
}

- (void)setPokemon:(PokemonSpecies *)species filteredStat:(NSNumber *)stat
{
	UIImage *spriteImage = [self preparedSpriteImage:species];
	
	self.textLabel.text = species.name;
	self.detailTextLabel.text = species.formName;
	
	for (UIView *subview in [self.contentView subviews])
	{
		[subview removeFromSuperview];
	}
	
	if (inBattledList)
	{
		if (timerLayerController == nil)
		{
			timerLayerController = [[TimerLayerController alloc] init];
			timerLayerController.spriteImage = spriteImage;
		}
		if (timerLayer == nil)
		{
			timerLayer = [CALayer layer];
			
			// Radius of circle to surround sprite
			CGFloat radius = 20;
			timerLayer.frame = CGRectIntegral(CGRectMake(2, 2, radius * 2, radius * 2));
			timerLayer.delegate = timerLayerController;
			timerLayer.contentsScale = [[UIScreen mainScreen] scale];
			
			[self.contentView.layer addSublayer:timerLayer];
			[self stop];
		}
		self.imageView.image = [UIImage imageNamed:@"blank-icon"];
	}
	else
	{
		self.imageView.image = spriteImage;
	}
	
  if (showEVYield)
  {
    CGFloat xOffset = 180;
    CGFloat yOffset = 1;
    CGFloat evViewSpacing = 4;
    NSDictionary *effortDict = [species effortDictionary];
		
		NSArray *sortedEVYields = [[effortDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			int statID1 = [(NSNumber *)obj1 intValue];
			int statID2 = [(NSNumber *)obj2 intValue];
			
			if (stat)
			{
				if (statID1 == [stat intValue])
					return NSOrderedAscending;
				if (statID2 == [stat intValue])
					return NSOrderedDescending;
			}
			
			if (statID1 < statID2)
				return NSOrderedAscending;
			if (statID1 > statID2)
				return NSOrderedDescending;
			
			return NSOrderedSame;
		}];
		
    for (NSNumber *statIDNumber in sortedEVYields)
    {
      NSNumber *evNumber = [effortDict objectForKey:statIDNumber];
      EVYieldView *evView = [[EVYieldView alloc] initWithStat:[statIDNumber intValue] value:[evNumber intValue]];
      
      CGRect evFrame = evView.frame;
      evFrame.origin = CGPointMake(xOffset, yOffset);
      evView.frame = evFrame;
      
      xOffset += evFrame.size.width + evViewSpacing;
      
      [self.contentView addSubview:evView];
      [evView release];
    }
	}
}

- (void)prepareForReuse
{
	[super prepareForReuse];
	
	timerLayer.delegate = nil, [timerLayer removeFromSuperlayer], timerLayer = nil;
	[timerLayerController release], timerLayerController = nil;
	[self stop];
}

#pragma mark - Timer layer


- (void)start
{
	if (displayLink == nil)
	{
		displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayUpdated)];
		[displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSDefaultRunLoopMode];
		displayLink.frameInterval = 2;
	}
	
	startTime = CACurrentMediaTime();
	timerLayerController.completionPercent = 0.0;
}

- (void)stop
{
	[displayLink invalidate];
	displayLink = nil;
	
	startTime = 0;
	timerLayerController.completionPercent = 1.0;
	
	[timerLayer setNeedsDisplay];
}

- (void)displayUpdated
{
	CFTimeInterval delta = displayLink.timestamp - startTime;
	
	CGFloat percent = delta / kRecentTimerAnimationDuration;
	
	if (percent >= 1)
	{
		percent = 1.0;
		[displayLink invalidate];
		displayLink = nil;
	}
	
	timerLayerController.completionPercent = percent;
	
	[timerLayer setNeedsDisplay];
}

#pragma mark - Memory management

- (void)dealloc
{
	[displayLink invalidate];
	[timerLayerController release];
	[super dealloc];
}

@end
