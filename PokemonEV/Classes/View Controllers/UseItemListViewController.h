//
//  UseItemListViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-07-15.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Pokemon;

@interface UseItemListViewController : UITableViewController
{
	ConsumableItemType itemType;
	Pokemon *pokemon;
	
	NSArray *items;
	NSMutableArray *usageCounts;
	
	IBOutlet UIView *berryFooterView;
	
	NSManagedObjectContext *managedObjectContext;
}

@property (nonatomic, readonly) NSManagedObjectContext *managedObjectContext;

- (id)initWithItemType:(ConsumableItemType)type pokemon:(Pokemon *)aPokemon;
- (IBAction)toggleBerryMechanics:(UISwitch *)control;

@end
