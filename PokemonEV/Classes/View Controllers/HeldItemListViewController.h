//
//  HeldItemListViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-20.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HeldItemListDelegate.h"

@class HeldItem;

@interface HeldItemListViewController : UITableViewController
{
  id<HeldItemListDelegate> delegate;
  
  NSManagedObjectContext *managedObjectContext;
  
  NSArray *allItems;
	HeldItem *initialHeldItem;
}

@property (nonatomic, assign) id<HeldItemListDelegate> delegate;
@property (nonatomic, retain) HeldItem *initialHeldItem;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context;

@end
