//
//  UseItemListViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-07-15.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "UseItemListViewController.h"
#import "Pokemon.h"
#import "BerryItem.h"
#import "VitaminItem.h"
#import "WingItem.h"
#import "ConsumableItem.h"
#import "ConsumableItemCell.h"
#import "EVSpread.h"
#import "PokemonStats.h"

#define BerrySwitchTag 101

@implementation UseItemListViewController

- (id)initWithItemType:(ConsumableItemType)type pokemon:(Pokemon *)aPokemon
{
	if ((self = [super initWithStyle:UITableViewStyleGrouped]))
	{
		itemType = type;
		
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator:[[aPokemon managedObjectContext] persistentStoreCoordinator]];
		pokemon = [[managedObjectContext fetchSingleObjectForEntityName:[Pokemon entityName] withPredicate:[NSPredicate predicateWithFormat:@"self = %@", aPokemon]] retain];
		
		self.hidesBottomBarWhenPushed = YES;
	}
	return self;
}

- (void)dealloc
{
	[pokemon release];
	[items release];
	[managedObjectContext release];
	[super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.tableView.scrollEnabled = NO;
	
	NSString *entityName = nil;
	switch (itemType)
	{
		case BerryItemType:
			self.title = @"Berries";
			entityName = [BerryItem entityName];
			break;
		case VitaminItemType:
			self.title = @"Vitamins";
			entityName = [VitaminItem entityName];
			break;
		case WingItemType:
			self.title = @"Wings";
			entityName = [WingItem entityName];
			break;
	}
	
	items = [[managedObjectContext fetchAllObjectsForEntityName:entityName
																					withSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"stat" ascending:YES]]
																								 andPredicate:nil]
					 retain];
	
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	
	[items release];
	items = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
	[super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [items count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *CellIdentifier = NSStringFromClass([ConsumableItemCell class]);
	
	ConsumableItemCell *cell = (ConsumableItemCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	
	if (cell == nil)
	{
		NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:nil options:nil];
		cell = [nib objectAtIndex:0];
	}
	
	PokemonStatID stat = indexPath.row;
	
	cell.evLabel.text = [NSString stringWithFormat:@"%d / %d", [pokemon.currentSpread effortForStat:stat], [pokemon.goalSpread effortForStat:stat]];
	cell.statNameLabel.text = [PokemonStats nameForStat:stat];
	cell.itemNameLabel.text = [(ConsumableItem *)[items objectAtIndex:stat] name];
	
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	switch (itemType)
	{
		case WingItemType:
			return @"Add 1 EV";
		case VitaminItemType:
			return @"Add 10 EVs";
		case BerryItemType:
			return @"Subtract 10 EVs";
	}
	
	return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
	if (itemType == BerryItemType)
	{
		if (berryFooterView == nil)
		{
			[[NSBundle mainBundle] loadNibNamed:@"BerryListFooterView" owner:self options:nil];
		}
		
		return berryFooterView;
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 80;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

@end
