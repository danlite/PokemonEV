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

@implementation PokemonListViewController

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
	if ((self = [super initWithStyle:UITableViewStylePlain]))
	{
		managedObjectContext = [context retain];
		showGoalEVs = YES;
	}
	return self;
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.title = @"Your Pokémon";
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeTapped)] autorelease];
	
	NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
	[fetch setEntity:[Pokemon entityInManagedObjectContext:managedObjectContext]];
	[fetch setSortDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:@"lastModified" ascending:NO]]];
	
	[fetchedResults release];
	fetchedResults = [[NSFetchedResultsController alloc] initWithFetchRequest:fetch managedObjectContext:managedObjectContext sectionNameKeyPath:nil cacheName:@"PokemonList"];
	
	[fetch release];
	
	NSError *error;
	if (![fetchedResults performFetch:&error])
	{
		DLog(@"Unable to fetch Pokemon list: %@", error);
	}
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

#pragma mark - Control handlers

- (void)closeTapped
{
	[self dismissModalViewControllerAnimated:YES];
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
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	Pokemon *pokemon = (Pokemon *)[fetchedResults objectAtIndexPath:indexPath];
	
	cell.textLabel.text = pokemon.species.name;
	cell.imageView.image = [UIImage imageNamed:pokemon.species.iconFilename];
	
	NSMutableArray *effortValues = [NSMutableArray array];
	EVSpread *spreadToShow = (showGoalEVs) ? pokemon.goalSpread : pokemon.currentSpread;
	for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
	{
		[effortValues addObject:[NSString stringWithFormat:@"%d", [spreadToShow effortForStat:i]]];
	}
	cell.detailTextLabel.text = [effortValues componentsJoinedByString:@"/"];
	
	return cell;
}
#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	// Navigation logic may go here. Create and push another view controller.
	/*
	 <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
	 // ...
	 // Pass the selected object to the new view controller.
	 [self.navigationController pushViewController:detailViewController animated:YES];
	 [detailViewController release];
	 */
}

#pragma mark - Memory management

- (void)dealloc
{
	[fetchedResults release];
	[managedObjectContext release];
	[super dealloc];
}

@end
