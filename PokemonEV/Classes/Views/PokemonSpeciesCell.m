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

@implementation PokemonSpeciesCell

@synthesize showEVYield;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
	self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
	if (self) {
		// Initialization code
	}
	return self;
}

- (void)setPokemon:(PokemonSpecies *)species filteredStat:(NSNumber *)stat
{
	self.textLabel.text = species.name;
	self.detailTextLabel.text = species.formName;
	
	for (UIView *subview in [self.contentView subviews])
	{
		[subview removeFromSuperview];
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

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
	[super setSelected:selected animated:animated];
	
	// Configure the view for the selected state
}

- (void)dealloc
{
	[super dealloc];
}

@end
