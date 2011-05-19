//
//  PokemonListViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "PokemonListViewController.h"
#import "PokemonSpecies.h"
#import "EVYieldView.h"
#import "StatFilterButton.h"

@interface PokemonListViewController()

- (void)fetchFilteredResults;

@end

@implementation PokemonListViewController

@synthesize fetchedSearchResults;
@synthesize showEVYield;
@synthesize statFilterButtons;

#pragma mark -
#pragma mark Initialization

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
	if ((self = [super initWithStyle:UITableViewStylePlain]))
	{
		managedObjectContext = [context retain];
		selectedStatFilter = [[[NSUserDefaults standardUserDefaults] objectForKey:SelectedStatFilter] copy];
		filterByStat = (selectedStatFilter != nil);
	}
	return self;
}


#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationController.toolbarHidden = !showEVYield;
  
  self.title = @"Pokémon";
	
	NSMutableArray *toolbarItems = [NSMutableArray arrayWithObject:FlexibleSpace];
	NSMutableArray *buttons = [NSMutableArray array];
  for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
  {
		StatFilterButton *button = [[StatFilterButton alloc] initWithStat:i];
		[buttons addObject:button];
		
		if (filterByStat && [selectedStatFilter intValue] == i)
			button.selected = YES;
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(statButtonSelection:) name:StatFilterButtonSelected object:button];
		
		[toolbarItems addObject:[[[UIBarButtonItem alloc] initWithCustomView:button] autorelease]];
		[toolbarItems addObject:FlexibleSpace];
  }
	self.statFilterButtons = buttons;
	
	self.toolbarItems = toolbarItems;
	
	[self fetchFilteredResults];
	
	UISearchBar *searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, -44, self.view.frame.size.width, 44)];
	self.tableView.tableHeaderView = searchBar;
	searchBar.delegate = self;
	[searchBar release];
	
	UISearchDisplayController *searchDisplayController = [[UISearchDisplayController alloc] initWithSearchBar:searchBar contentsController:self];
	searchDisplayController.delegate = self;
	searchDisplayController.searchResultsDelegate = self;
	searchDisplayController.searchResultsDataSource = self;
}

- (void)viewWillDisappear:(BOOL)animated
{
}

#pragma mark - Fetching and filtering

- (void)fetchFilteredResults
{
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[PokemonSpecies entityInManagedObjectContext:managedObjectContext]];
	
	filterByStat = (selectedStatFilter != nil);
	
	NSString *sectionNameKeyPath = nil;
	
	if (filterByStat && showEVYield)
	{
		NSString *filterKey = [NSString stringWithFormat:@"%@Effort", [PokemonStats methodPrefixForStat:[selectedStatFilter intValue]]];
		[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:
																			[NSSortDescriptor sortDescriptorWithKey:filterKey ascending:NO],
																			[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES],
																			nil]];
		
		[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"%K > 0", filterKey]];
		
		sectionNameKeyPath = filterKey;
	}
	else
	{
		[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:
																			[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES],
																			[NSSortDescriptor sortDescriptorWithKey:@"formOrder" ascending:YES],
																			nil]];
		
		sectionNameKeyPath = @"uppercaseNameInitial";
	}
	
	[fetchedResults release];
	fetchedResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:managedObjectContext sectionNameKeyPath:sectionNameKeyPath cacheName:nil];
	[fetchedResults performFetch:nil];
}


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
		return [[fetchedSearchResults sections] count];
	if (tableView == self.tableView)
    return [[fetchedResults sections] count];
	
	return 0;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
    return [[[fetchedSearchResults sections] objectAtIndex:section] numberOfObjects];
	if (tableView == self.tableView)
		return [[[fetchedResults sections] objectAtIndex:section] numberOfObjects];
	
	return 0;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"PokemonListCell";
	
	PokemonSpecies *species = nil;
	if (tableView == self.searchDisplayController.searchResultsTableView)
		species = [fetchedSearchResults objectAtIndexPath:indexPath];
	else
		species = [fetchedResults objectAtIndexPath:indexPath];
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	for (UIView *subview in [cell.contentView subviews])
	{
		[subview removeFromSuperview];
	}
  
	cell.imageView.image = [UIImage imageNamed:species.iconFilename];
	cell.textLabel.text = species.name;
	cell.detailTextLabel.text = species.formName;
	
  if (showEVYield)
  {
    CGFloat xOffset = 180;
    CGFloat yOffset = 1;
    CGFloat evViewSpacing = 4;
    NSDictionary *effortDict = [species effortDictionary];
		
		NSArray *sortedEVYields = [[effortDict allKeys] sortedArrayUsingComparator:^NSComparisonResult(id obj1, id obj2) {
			int statID1 = [(NSNumber *)obj1 intValue];
			int statID2 = [(NSNumber *)obj2 intValue];
			
			if (filterByStat)
			{
				if (statID1 == [selectedStatFilter intValue])
					return NSOrderedAscending;
				if (statID2 == [selectedStatFilter intValue])
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
      
      [cell.contentView addSubview:evView];
      [evView release];
    }
	}
  
	return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
		return nil;
	
	return [[[fetchedResults sections] objectAtIndex:section] indexTitle];
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
	if ([title isEqualToString:UITableViewIndexSearch])
	{
		[tableView setContentOffset:CGPointZero];
		return NSNotFound;
	}
	
	return [fetchedResults sectionForSectionIndexTitle:title atIndex:index - 1];
}

- (NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
	if (tableView == self.searchDisplayController.searchResultsTableView)
		return nil;
	
	NSMutableArray *titles = [NSMutableArray arrayWithObject:UITableViewIndexSearch];
	[titles addObjectsFromArray:[fetchedResults sectionIndexTitles]];
	return titles;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark -
#pragma mark Search display delegate

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
	if ([searchString length] == 0)
		return NO;
	
	NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	[fetchRequest setEntity:[PokemonSpecies entityInManagedObjectContext:managedObjectContext]];
	[fetchRequest setSortDescriptors:[NSArray arrayWithObjects:
																		[NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES],
																		[NSSortDescriptor sortDescriptorWithKey:@"formOrder" ascending:YES],
																		nil]];
	[fetchRequest setPredicate:[NSPredicate predicateWithFormat:@"name BEGINSWITH[cd] %@", searchString]];
	self.fetchedSearchResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
																																	managedObjectContext:managedObjectContext
																																		sectionNameKeyPath:nil
																																						 cacheName:nil];
	[fetchedSearchResults performFetch:nil];
	[fetchedSearchResults release];
	
	return YES;
}

- (void)searchDisplayControllerDidBeginSearch:(UISearchDisplayController *)controller
{
	[self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
	[self.navigationController setToolbarHidden:NO animated:YES];
}

#pragma mark -
#pragma mark Search bar delegate

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
	if ([[fetchedSearchResults sections] count])
	{
		if ([[[fetchedSearchResults sections] objectAtIndex:0] numberOfObjects] == 1)
		{
			PokemonSpecies *pokemon = [fetchedSearchResults objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
			DLog(@"%@", [pokemon fullName]);
		}
	}
}

#pragma mark - Notifications

- (void)statButtonSelection:(NSNotification *)note
{
	StatFilterButton *button = (StatFilterButton *)[note object];
	PokemonStatID statID = button.statID;
	NSNumber *statNumber = [NSNumber numberWithInt:statID];
	
	if (button.selected)
	{
		[selectedStatFilter release];
		selectedStatFilter = [statNumber copy];
		
		for (StatFilterButton *otherButton in statFilterButtons)
		{
			if (otherButton != button)
				otherButton.selected = NO;
		}
	}
	else
	{
		[selectedStatFilter release], selectedStatFilter = nil;
	}
	
	[self fetchFilteredResults];
	[self.tableView reloadData];
	[self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	
	[[NSUserDefaults standardUserDefaults] setObject:selectedStatFilter forKey:SelectedStatFilter];
	[[NSUserDefaults standardUserDefaults] synchronize];
}


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	[selectedStatFilter release];
	[fetchedResults release];
	[fetchedSearchResults release];
	[managedObjectContext release];
	[super dealloc];
}


@end

