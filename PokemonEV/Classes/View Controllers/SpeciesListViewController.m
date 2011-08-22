//
//  PokemonListViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "SpeciesListViewController.h"
#import "PokemonSpecies.h"
#import "StatFilterButton.h"
#import "PokemonStats.h"
#import "PokemonSpeciesCell.h"

@interface SpeciesListViewController()

- (void)fetchFilteredResults;

@end

@implementation SpeciesListViewController

@synthesize changeSpecies;
@synthesize allowsClose;
@synthesize fetchedSearchResults;
@synthesize showEVYield;
@synthesize statFilterButtons;
@synthesize delegate;

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

- (BOOL)hidesBottomBarWhenPushed
{
	return !showEVYield;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
  
	self.title = @"Select a Pokémon";
	self.navigationItem.prompt = changeSpecies ? @"Change the species of the current Pokémon" :
	(showEVYield ? @"Record the EV gain from battling a Pokémon" : @"Begin EV training a new Pokémon");
	
	if (allowsClose)
	{
		self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeTapped)] autorelease];
	}
	
	if (showEVYield)
	{
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
	}
	
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

#pragma mark - Control handlers

- (void)closeTapped
{
	[delegate speciesList:self choseSpecies:nil];
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
		NSString *filterKey = [NSString stringWithFormat:@"yield.%@", [PokemonStats methodPrefixForStat:[selectedStatFilter intValue]]];
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
		[fetchRequest setRelationshipKeyPathsForPrefetching:[NSArray arrayWithObject:@"yield"]];
		
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
	
	PokemonSpeciesCell *cell = (PokemonSpeciesCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[PokemonSpeciesCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
		cell.showEVYield = showEVYield;
	}
	
	[cell setPokemon:species filteredStat:selectedStatFilter];
  
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
	PokemonSpecies *species = (tableView == self.searchDisplayController.searchResultsTableView) ?
	[fetchedSearchResults objectAtIndexPath:indexPath] :
	[fetchedResults objectAtIndexPath:indexPath];
	
	[[self delegate] speciesList:self choseSpecies:species];
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
	if (showEVYield)
		[self.navigationController setToolbarHidden:YES animated:YES];
}

- (void)searchDisplayControllerDidEndSearch:(UISearchDisplayController *)controller
{
	if (showEVYield)
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
			//			PokemonSpecies *pokemon = [fetchedSearchResults objectAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
			//			DLog(@"%@", [pokemon fullName]);
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

