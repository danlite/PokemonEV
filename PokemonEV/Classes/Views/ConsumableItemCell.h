//
//  ConsumableItemCell.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-07-21.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface ConsumableItemCell : UITableViewCell
{
	UILabel *evLabel;
	UILabel *statNameLabel;
	UILabel *itemNameLabel;
}

@property (nonatomic, retain) IBOutlet UILabel *evLabel, *statNameLabel, *itemNameLabel;

@end
