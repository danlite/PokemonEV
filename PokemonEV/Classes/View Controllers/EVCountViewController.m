//
//  EVCountViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-21.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVCountViewController.h"
#import "EVCountView.h"
#import "PokemonStats.h"

@interface EVCountViewController()

- (void)setupView;

@end


@implementation EVCountViewController

@synthesize view;
@synthesize goal, current;
@synthesize statID;

- (id)initWithStatID:(PokemonStatID)stat
{
  if ((self = [super init]))
  {
    statID = stat;
    mode = EVCountModeView;
    
    [self setupView];
  }
  
  return self;
}

- (EVCountMode)mode
{
  return mode;
}

- (void)setMode:(EVCountMode)aMode
{
  if (aMode == mode)
    return;
  
  mode = aMode;
  BOOL edit = (mode != EVCountModeView);
  
  CATransition *transition = [CATransition animation];
  transition.duration = 0.3;
  transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
  
  transition.type = edit ? kCATransitionReveal : kCATransitionMoveIn;
  transition.subtype = edit ? kCATransitionFromRight : kCATransitionFromLeft;

  [containerLayer addAnimation:transition forKey:nil];
  textLayer.hidden = edit;
  editLayer.hidden = !edit;
  
  if (!edit)
  {
    [textField resignFirstResponder];
  }
  else if (mode == EVCountModeEditGoal)
  {
    textField.text = goal ? [NSString stringWithFormat:@"%d", goal] : @"";
  }
  else if (mode == EVCountModeEditCurrent)
  {
    textField.text = current ? [NSString stringWithFormat:@"%d", current] : @"";
  }
    
  
  [UIView animateWithDuration:transition.duration animations:^(void)
   {
     textField.alpha = edit ? 1 : 0;
   }];
}

- (UIColor *)textColour
{
	if (goal == 0 && current == 0)
		return [UIColor grayColor];
	
	return [UIColor blackColor];
}

- (UITextField *)textField
{
  if (textField == nil)
  {
    textField = [[UITextField alloc] initWithFrame:CGRectMake(45, 5, 50, 31)];
    textField.borderStyle = UITextBorderStyleRoundedRect;
    textField.keyboardType = UIKeyboardTypeNumberPad;
    textField.alpha = 0;
    textField.font = [UIFont systemFontOfSize:20];
    textField.delegate = self;
  }
  return textField;
}

- (void)setupView
{
  view = [[EVCountView alloc] initWithStat:statID];
  
  [self.view addSubview:self.textField];
  
  containerLayer = [[CALayer layer] retain];
  containerLayer.frame = CGRectMake(0, 0, view.frame.size.width, view.frame.size.height);
  
  editLayer = [[CALayer layer] retain];
  editLayer.delegate = self;
  editLayer.frame = containerLayer.frame;
  editLayer.hidden = YES;
  editLayer.contentsScale = [[UIScreen mainScreen] scale];
  editLayer.shouldRasterize = YES;
  editLayer.rasterizationScale = [[UIScreen mainScreen] scale];
  
  textLayer = [[CALayer layer] retain];
  textLayer.delegate = self;
  textLayer.frame = containerLayer.frame;
  textLayer.contentsScale = [[UIScreen mainScreen] scale];
  textLayer.shouldRasterize = YES;
  textLayer.rasterizationScale = [[UIScreen mainScreen] scale];
	
	pointLayer = [[CALayer layer] retain];
	pointLayer.delegate = self;
	pointLayer.frame = containerLayer.frame;
	pointLayer.contentsScale = [[UIScreen mainScreen] scale];
	pointLayer.shouldRasterize = NO;
	pointLayer.opacity = 0;
	pointLayer.shadowOffset = CGSizeMake(0, 1);
	pointLayer.shadowOpacity = 0.5;
	pointLayer.shadowRadius = 0.5;
	pointLayer.shadowColor = [[UIColor blackColor] CGColor];
  
  maskLayer = [[CALayer layer] retain];
  maskLayer.frame = textLayer.frame;
  
  CGRect rect = maskLayer.bounds;
  
  UIGraphicsBeginImageContext(rect.size);
  CGContextRef context = UIGraphicsGetCurrentContext();
  
  CGContextSaveGState(context);
  CGContextTranslateCTM(context, CGRectGetMinX(rect), CGRectGetMinY(rect));
  CGContextBeginPath(context);
  
  TTShape *shape = [(TTShapeStyle *)[view.style firstStyleOfClass:[TTShapeStyle class]] shape];
  [shape addToPath:rect];
  
  CGContextFillPath(context);
  
  CGImageRef shapeImage = CGBitmapContextCreateImage(context);
  
  UIGraphicsEndImageContext();
  
  maskLayer.contents = (id)shapeImage;
  CGImageRelease(shapeImage);
  
//  textLayer.mask = maskLayer;
  
  [view.layer addSublayer:containerLayer];
  [containerLayer addSublayer:textLayer];
  [containerLayer addSublayer:editLayer];
	
	[view.layer addSublayer:pointLayer];
  
  [textLayer setNeedsDisplay];
  [editLayer setNeedsDisplay];
}

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)ctx
{
  if (layer == textLayer)
  {
    CGRect rect = CGContextGetClipBoundingBox(ctx);
    rect = CGRectOffset(rect, 0, 4);
    
    UIGraphicsPushContext(ctx);
    
    CGFloat rectHeight = rect.size.height;
    CGRect topRect;
    CGRect bottomRect;
    CGRectDivide(rect, &topRect, &bottomRect, rectHeight / 2, CGRectMinYEdge);
    
		[[self textColour] set];
    
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
    
    UIGraphicsPopContext();
  }
  else if (layer == editLayer)
  {
    CGRect rect = CGContextGetClipBoundingBox(ctx);
    rect = CGRectInset(rect, 5, 12);
    
    UIGraphicsPushContext(ctx);
    
    NSString *statName = [PokemonStats nameForStat:statID length:5];
    [statName drawInRect:rect withFont:[UIFont boldSystemFontOfSize:12]];
    
    UIGraphicsPopContext();
  }
	else if (layer == pointLayer)
	{
		CGRect rect = CGContextGetClipBoundingBox(ctx);
		rect = CGRectInset(rect, 5, 0);
		
		UIGraphicsPushContext(ctx);
		
		if (pointChange == 0)
			return;
		
		UIColor *colour = (pointChange > 0) ? [UIColor greenColor] : [UIColor redColor];
		[colour set];
		NSString *text = [NSString stringWithFormat:@"%@%d", (pointChange > 0) ? @"+" : @"-", abs(pointChange)];
		[text drawInRect:rect withFont:[UIFont boldSystemFontOfSize:12] lineBreakMode:UILineBreakModeClip alignment:UITextAlignmentRight];
		
		UIGraphicsPopContext();
	}
}

- (void)updateView
{
  [textLayer setNeedsDisplay];
}

- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
	if ([[anim valueForKey:@"name"] isEqualToString:@"fadeIn"])
	{
		CGMutablePathRef path = CGPathCreateMutable();
		CGFloat originalX = pointLayer.position.x;
		CGFloat originalY = pointLayer.position.y;
		CGPathMoveToPoint(path, NULL, originalX, originalY);
		CGPathAddLineToPoint(path, NULL, originalX, originalY - 3);
		
		CGFloat disappearDuration = 0.3;
		CGFloat disappearDelay = 0.5;
		
		CAKeyframeAnimation *slideUpAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
		slideUpAnimation.path = path;
		slideUpAnimation.duration = disappearDuration;
		slideUpAnimation.beginTime = disappearDelay;
		
		CABasicAnimation *fadeOutAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
		fadeOutAnimation.toValue = [NSNumber numberWithFloat:0];
		fadeOutAnimation.duration = disappearDuration;
		fadeOutAnimation.beginTime = disappearDelay;
		
		CAAnimationGroup *group = [CAAnimationGroup animation];
		group.duration = disappearDelay + disappearDuration;
		group.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
		group.animations = [NSArray arrayWithObjects:slideUpAnimation, fadeOutAnimation, nil];
		group.delegate = self;
		group.removedOnCompletion = NO;
		group.fillMode = kCAFillModeForwards;
		
		[pointLayer addAnimation:group forKey:nil];
	}
	else
	{
		[pointLayer removeAllAnimations];
	}
}

- (void)animatePulseWithValue:(NSInteger)value
{
	pointChange = value;
	[pointLayer setNeedsDisplay];
	
	CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
	pulseAnimation.duration = 0.3;
	pulseAnimation.toValue = [NSNumber numberWithFloat:1.2];
	pulseAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	pulseAnimation.autoreverses = YES;
	pulseAnimation.repeatCount = 1;
	
	[textLayer addAnimation:pulseAnimation forKey:nil];
		
	CABasicAnimation *fadeInAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
	fadeInAnimation.toValue = [NSNumber numberWithFloat:1.0];
	fadeInAnimation.duration = 0.3;
	fadeInAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
	fadeInAnimation.delegate = self;
	[fadeInAnimation setValue:@"fadeIn" forKey:@"name"];
	fadeInAnimation.removedOnCompletion = NO;
	fadeInAnimation.fillMode = kCAFillModeForwards;
		
	[pointLayer addAnimation:fadeInAnimation forKey:nil];
}

#pragma mark - Text field delegate

- (BOOL)textField:(UITextField *)aTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
  NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"^\\d{0,3}$" options:0 error:NULL];
  
  NSString *newString = [aTextField.text stringByReplacingCharactersInRange:range withString:string];
  
  NSRange newRange;
  newRange.length = [newString length];
  newRange.location = 0;
  if ([regex numberOfMatchesInString:newString options:0 range:newRange] != 1)
  {
    return NO;
  }
  
  NSInteger newValue = [newString intValue];
  
  [[NSNotificationCenter defaultCenter]
   postNotificationName:EVCountInputChanged
   object:self
   userInfo:[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:newValue] forKey:@"newValue"]];
  
  return YES;
}

#pragma mark - Memory management

- (void)dealloc
{
  [view release];
  [containerLayer release];
  [textLayer release];
  [editLayer release];
  [maskLayer release];
	[pointLayer release];
  [textField release];
  
  [super dealloc];
}

@end
