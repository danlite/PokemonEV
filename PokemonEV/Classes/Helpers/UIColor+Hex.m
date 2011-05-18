//
//  UIColor+Hex.m
//  WellpointHealth
//
//  Created by Dan Lichty on 10-11-25.
//  Copyright 2010 Daniel Lichty. All rights reserved.
//

#import "UIColor+Hex.h"


@implementation UIColor (Hex)

+ (UIColor *)colorWithHex:(UInt32)col {
  unsigned char r, g, b;
  b = col & 0xFF;
  g = (col >> 8) & 0xFF;
  r = (col >> 16) & 0xFF;
  return [UIColor colorWithRed:(double)r/255.0f green:(double)g/255.0f blue:(double)b/255.0f alpha:1];
}

@end
