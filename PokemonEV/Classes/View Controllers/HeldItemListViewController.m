//
//  HeldItemListViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-20.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "HeldItemListViewController.h"
#import "HeldItem.h"
#import "PokemonStats.h"

@implementation HeldItemListViewController

@synthesize delegate;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
  if ((self = [super initWithStyle:UITableViewStyleGrouped]))
  {
    managedObjectContext = [context retain];
    
    allItems = [[managedObjectContext
                 fetchAllObjectsForEntityName:[HeldItem entityName]
                 withSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"trainingStat" ascending:YES]]
                 andPredicate:nil]
                retain];
  }
  return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = @"Held Item";
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (section == 0)
    return [allItems count];
  if (section == 1)
    return 1;
  
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *CellIdentifier = @"ItemCell";
  
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
  if (cell == nil)
  {
    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
  }
  
  if (indexPath.section == 0)
  {
    HeldItem *item = [allItems objectAtIndex:indexPath.row];
    cell.textLabel.text = item.name;
    NSInteger statID = item.trainingStatValue;
    cell.detailTextLabel.text = (statID == -1) ? @"" : [PokemonStats nameForStat:statID length:15];
    cell.imageView.image = [UIImage imageNamed:item.identifier];
  }
  else if (indexPath.section == 1)
  {
    cell.textLabel.text = @"No held item";
    cell.detailTextLabel.text = @"";
    cell.imageView.image = nil;
  }
  
  return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  HeldItem *item = nil;
  if (indexPath.section == 0)
  {
    item = [allItems objectAtIndex:indexPath.row];
  }
  
  [self.delegate heldItemList:self choseItem:item];
}


- (void)dealloc
{
  [managedObjectContext release];
  [allItems release];
  [super dealloc];
}

@end
