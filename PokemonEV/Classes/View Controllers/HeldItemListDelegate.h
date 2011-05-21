//
//  HeldItemListDelegate.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-20.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <Foundation/Foundation.h>

@class HeldItemListViewController;
@class HeldItem;

@protocol HeldItemListDelegate <NSObject>

- (void)heldItemList:(HeldItemListViewController *)listVC choseItem:(HeldItem *)item;

@end
