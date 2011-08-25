//
//  PokemonListViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-26.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "PokemonListViewController.h"
#import "Pokemon.h"
#import "PokemonSpecies.h"
#import "EVSpread.h"
#import "SpeciesListViewController.h"

NSString * const CacheName = @"PokemonList";

@interface PokemonListViewController()

- (void)refreshPokemonList;

@end

@implementation PokemonListViewController

@synthesize delegate;
@synthesize currentPokemon;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
	if ((self = [super initWithStyle:UITableViewStylePlain]))
	{
		managedObjectContext = [context retain];
	}
	return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = @"Your Pokémon";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeTapped)] autorelease];
	self.navigationItem.rightBarButtonItem = [self editButtonItem];
	self.navigationItem.backBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"List" style:UIBarButtonItemStyleBordered target:nil action:nil] autorelease];
	
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity:[Pokemon entityInManagedObjectContext:managedObjectContext]];
	[fetch setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastModified" ascending:NO]]];
	
	[fetchedResults release];
	fetchedResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:CacheName];
	
	[fetch release];
	
	UISegmentedControl *segments = [[[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Goal EVs", @"Current EVs", nil]] autorelease];
	segments.segmentedControlStyle = UISegmentedControlStyleBar;
	segments.frame = CGRectMake(0, 0, 220, segments.frame.size.height);
	[segments setSelectedSegmentIndex:[[NSUserDefaults standardUserDefaults] integerForKey:ShowCurrentOrGoalEVs]];
	[segments addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
	
	UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addTapped)] autorelease];
	addButton.style = UIBarButtonItemStyleBordered;
	
	self.toolbarItems = [NSArray arrayWithObjects:
											 FlexibleSpace,
											 [[[UIBarButtonItem alloc] initWithCustomView:segments] autorelease],
											 FlexibleSpace,
											 addButton,
											 FlexibleSpace,
											 nil];
	
	[self refreshPokemonList];
}

- (void)viewDidUnload
{
	[super viewDidUnload];
}

- (void)refreshPokemonList
{
	NSError *error;
	if (![fetchedResults performFetch:&error])
	{
		DLog(@"Unable to fetch Pokemon list: %@", error);
	}
}

#pragma mark - Control handlers

- (void)segmentChanged:(UISegmentedControl *)control
{
	[[NSUserDefaults standardUserDefaults] setInteger:control.selectedSegmentIndex forKey:ShowCurrentOrGoalEVs];
	[[NSUserDefaults standardUserDefaults] synchronize];
	
	[self.tableView reloadData];
}

- (void)closeTapped
{
	[self dismissModalViewControllerAnimated:YES];
}

- (void)addTapped
{
	SpeciesListViewController *listVC = [[SpeciesListViewController alloc] initWithManagedObjectContext:managedObjectContext];
	listVC.showEVYield = NO;
	listVC.delegate = self;
	
	[self.navigationController pushViewController:listVC animated:YES];
}

#pragma mark - Species list

- (void)speciesList:(SpeciesListViewController *)listVC choseSpecies:(PokemonSpecies *)species
{
	[self dismissModalViewControllerAnimated:YES];
	
	if (species == nil)
		return;
	
	Pokemon *newPokemon = [Pokemon insertFromSpecies:species inManagedObjectContext:managedObjectContext];
	
	NSError *error;
	if (![managedObjectContext save:&error])
	{
		DLog(@"Unable to create new Pokemon: %@", error);
		[managedObjectContext rollback];
		return;
	}
	
	[NSFetchedResultsController deleteCacheWithName:CacheName];
	
	[delegate pokemonList:self chosePokemon:newPokemon];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return [[fetchedResults sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return [[[fetchedResults sections] objectAtIndex:section] numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"PokemonCell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
	}
	
	Pokemon *pokemon = (Pokemon *)[fetchedResults objectAtIndexPath:indexPath];
	
	cell.imageView.image = [UIImage imageNamed:pokemon.species.iconFilename];
	
	BOOL showGoalEVs = [[NSUserDefaults standardUserDefaults] integerForKey:ShowCurrentOrGoalEVs] == ShowGoalEVs;
	
	NSMutableArray *effortValues = [NSMutableArray array];
	EVSpread *spreadToShow = (showGoalEVs) ? pokemon.goalSpread : pokemon.currentSpread;
	for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
	{
		[effortValues addObject:[NSString stringWithFormat:@"%d", [spreadToShow effortForStat:i]]];
	}
	cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@",
															 [effortValues componentsJoinedByString:@"/"],
															 pokemon.nickname ? [NSString stringWithFormat:@"(%@)", pokemon.nickname] : @""];
	
	BOOL doneTraining = ([pokemon.goalSpread totalEffort] > 0 && [pokemon.goalSpread matchesSpread:pokemon.currentSpread]);
	
	if (doneTraining)
	{
		UIImageView *checkmarkView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-green-check"]];
		cell.accessoryView = checkmarkView;
		cell.textLabel.text = [NSString stringWithFormat:@"%@ ✓", pokemon.species.name];
	}
	else
	{
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
		cell.textLabel.text = pokemon.species.name;
	}
	
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
	Pokemon *pokemon = [fetchedResults objectAtIndexPath:indexPath];
	
	if (editingStyle == UITableViewCellEditingStyleDelete)
	{
		BOOL deleteCurrentPokemon = (currentPokemon != nil && [pokemon isEqual:currentPokemon]);
		[managedObjectContext deleteObject:pokemon];
		
		NSError *error;
		if (![managedObjectContext save:&error])
		{
			DLog(@"Unable to delete Pokemon: %@", error);
			[managedObjectContext rollback];
			return;
		}
		
		[NSFetchedResultsController deleteCacheWithName:CacheName];
		
		if (deleteCurrentPokemon)
			self.currentPokemon = nil;
		
		[self refreshPokemonList];
		
		[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
		
		self.navigationItem.leftBarButtonItem.enabled = (!deleteCurrentPokemon && ([[[fetchedResults sections] objectAtIndex:0] numberOfObjects] > 0));
	}
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	Pokemon *pokemon = (Pokemon *)[fetchedResults objectAtIndexPath:indexPath];
	
	[delegate pokemonList:self chosePokemon:pokemon];
}

#pragma mark - Memory management

- (void)dealloc
{
	[currentPokemon release];
	[fetchedResults release];
	[managedObjectContext release];
	[super dealloc];
}

@end
