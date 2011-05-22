//
//  EVCountViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-21.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "EVCountViewController.h"
#import "EVCountView.h"

@interface EVCountViewController()

- (void)setupView;

@end


@implementation EVCountViewController

@synthesize view;
@synthesize goal, current;

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
  transition.duration = 0.4;
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
  
  [UIView animateWithDuration:transition.duration animations:^(void)
  {
    textField.alpha = edit ? 1 : 0;
  }];
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
  
//  CABasicAnimation *pulseColorAnimation = [CABasicAnimation animationWithKeyPath:@"backgroundColor"];
//  pulseColorAnimation.duration = arc4random() % 7;
//  pulseColorAnimation.fillMode = kCAFillModeForwards;
//  pulseColorAnimation.toValue = (id)[[PokemonStats colourForStat:statID] CGColor];
//  pulseColorAnimation.beginTime = arc4random() % 6;
//  pulseColorAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
//  pulseColorAnimation.autoreverses = YES;
//  pulseColorAnimation.repeatCount = FLT_MAX;
//  
//  [textLayer addAnimation:pulseColorAnimation forKey:nil];
  
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
}

- (void)animationDidStop:(CAAnimation *)animation finished:(BOOL)flag
{
//  containerLayer.shouldRasterize = NO;
}

#pragma mark - Memory management

- (void)dealloc
{
  [view release];
  [containerLayer release];
  [textLayer release];
  [editLayer release];
  [maskLayer release];
  [textField release];
  
  [super dealloc];
}

@end
