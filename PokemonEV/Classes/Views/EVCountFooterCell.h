//
//  EVCountFooterCell.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-22.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface EVCountFooterCell : UITableViewCell
{
  EVCountMode mode;
  NSInteger goal, current;
  
  UILabel *titleLabel, *evTotalLabel;
}

@property (nonatomic, assign) EVCountMode mode;
@property (nonatomic, assign) NSInteger goal, current;
@property (nonatomic, retain) IBOutlet UILabel *titleLabel, *evTotalLabel;

@end
