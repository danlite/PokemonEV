//
//  PokemonSpeciesCell.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-24.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class PokemonSpecies;

@interface TimerLayerController : NSObject
{
	UIImage *spriteImage;
	CGFloat completionPercent;
}

@property (nonatomic, assign) CGFloat completionPercent;
@property (nonatomic, retain) UIImage *spriteImage;

@end

@interface PokemonSpeciesCell : UITableViewCell
{
	BOOL showEVYield;
	BOOL inBattledList;
	
	// Timer layer
	CALayer *timerLayer;
	TimerLayerController *timerLayerController;
	
	CFTimeInterval startTime;
	CADisplayLink *displayLink;
}

@property (nonatomic, assign) BOOL showEVYield;
@property (nonatomic, assign) BOOL inBattledList;

- (void)setPokemon:(PokemonSpecies *)species filteredStat:(NSNumber *)stat;

- (void)start;
- (void)stop;

@end
