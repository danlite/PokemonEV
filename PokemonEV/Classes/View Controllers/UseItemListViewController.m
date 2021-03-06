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
#import "Three20Style/UIColorAdditions.h"

#define BerrySwitchTag 101

@implementation UseItemListViewController

@synthesize managedObjectContext;

- (id)initWithItemType:(ConsumableItemType)type pokemon:(Pokemon *)aPokemon
{
	if ((self = [super initWithStyle:UITableViewStyleGrouped]))
	{
		itemType = type;
		
		managedObjectContext = [[NSManagedObjectContext alloc] init];
		[managedObjectContext setPersistentStoreCoordinator:[[aPokemon managedObjectContext] persistentStoreCoordinator]];
		pokemon = [[managedObjectContext fetchSingleObjectForEntityName:[Pokemon entityName] withPredicate:[NSPredicate predicateWithFormat:@"self = %@", aPokemon]] retain];
		
		usageCounts = [[NSMutableArray array] retain];
		for (int i = 0; i <= PokemonStatLast; i++)
		{
			[usageCounts addObject:[NSNumber numberWithInt:0]];
		}
		
		self.hidesBottomBarWhenPushed = YES;
	}
	return self;
}

- (void)dealloc
{
	[usageCounts release];
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

#pragma mark - Control handlers

- (void)toggleBerryMechanics:(UISwitch *)control
{
	[[NSUserDefaults standardUserDefaults] setBool:control.on forKey:UseGen4BerryMechanics];
	[[NSUserDefaults standardUserDefaults] synchronize];
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
	
	ConsumableItem *item = [items objectAtIndex:stat];
	BOOL valid = [pokemon canConsumeItem:item];
	
	cell.evLabel.text = [NSString stringWithFormat:@"%d / %d", [pokemon.currentSpread effortForStat:stat], [pokemon.goalSpread effortForStat:stat]];
	cell.statNameLabel.text = [PokemonStats nameForStat:stat];
	cell.itemNameLabel.text = item.name;
	
	UIColor *statColour = [PokemonStats colourForStat:stat];
	cell.backgroundColor = [UIColor colorWithHue:[statColour hue] saturation:0.15 value:0.9 alpha:1.0];
	
	NSInteger usage = [(NSNumber *)[usageCounts objectAtIndex:stat] intValue];
	if (usage == 0)
	{
		cell.usageLabel.text = @"";
	}
	else
	{
		cell.usageLabel.text = [NSString stringWithFormat:@"Used %d", usage];
	}
	
	cell.selectionStyle = valid ? UITableViewCellSelectionStyleBlue : UITableViewCellSelectionStyleNone;
	
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@-icon-%d", NSStringFromClass([item class]), indexPath.row]];
	
	for (UILabel *label in [NSArray arrayWithObjects:cell.evLabel, cell.statNameLabel, cell.itemNameLabel, nil])
	{
		label.textColor = valid ? [UIColor blackColor] : [UIColor lightGrayColor];
	}
	
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
		
		UISwitch *berrySwitch = (UISwitch *)[berryFooterView viewWithTag:BerrySwitchTag];
		[berrySwitch setOn:[[NSUserDefaults standardUserDefaults] boolForKey:UseGen4BerryMechanics]];
		
		return berryFooterView;
	}
	return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
	return 88;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	[tableView deselectRowAtIndexPath:indexPath animated:NO];
	
	ConsumableItem *item = [items objectAtIndex:indexPath.row];
	
	if (![pokemon canConsumeItem:item])
		return;
	
	NSInteger change = [pokemon useItem:item];
	DLog(@"Changed by %d", change);
	
	PokemonStatID stat = indexPath.row;
	
	NSInteger newCount = [(NSNumber *)[usageCounts objectAtIndex:stat] intValue] + 1;
	[usageCounts replaceObjectAtIndex:stat withObject:[NSNumber numberWithInt:newCount]];
	
	NSError *error;
	if (![managedObjectContext save:&error])
	{
		DLog(@"Unable to use item: %@", error);
		[managedObjectContext rollback];
	}
	
	if ([pokemon.currentSpread totalEffort] == MaximumTotalEVCount)
	{
		[tableView reloadData];
	}
	else
	{
		[tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
	}
}

@end
