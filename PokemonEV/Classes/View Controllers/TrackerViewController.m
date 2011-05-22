//
//  TrackerViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-05-17.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "TrackerViewController.h"
#import "PokemonListViewController.h"
#import "Pokemon.h"
#import "PokemonSpecies.h"
#import "PokemonStats.h"
#import "EVSpread.h"
#import "EVCountView.h"
#import "HeldItem.h"
#import "HeldItemListViewController.h"
#import "EVCountViewController.h"
#import "EVCountFooterCell.h"

@interface TrackerViewController()

- (void)presentPokemonListWithEVs:(BOOL)showEVYield;
- (void)refreshView;
- (void)updateEVCountViews;

@end

@implementation TrackerViewController

@synthesize pokemon;
@synthesize evCountFooterCell;

- (id)initWithManagedObjectContext:(NSManagedObjectContext *)context
{
	if ((self = [super initWithStyle:UITableViewStyleGrouped]))
	{
		managedObjectContext = [context retain];
    evViewControllers = [[NSMutableDictionary alloc] init];
    evMode = EVCountModeView;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(evCountInputChanged:) name:EVCountInputChanged object:nil];
	}
	
	return self;
}

- (id)initWithPokemon:(Pokemon *)pkmn
{
	if ((self = [self initWithManagedObjectContext:[pkmn managedObjectContext]]))
	{
		self.pokemon = pkmn;
	}
	
	return self;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	if (pokemon == nil)
	{
		[self presentPokemonListWithEVs:NO];
	}
  
  [self refreshView];
}

#pragma mark - Updating views

- (EVSpread *)activeEVSpread
{
  return (evMode == EVCountModeEditGoal) ? pokemon.goalSpread : pokemon.currentSpread;
}

- (void)updateEVCountViews
{
  for (NSNumber *statNumber in evViewControllers)
  {
    EVCountViewController *vc = [evViewControllers objectForKey:statNumber];
    vc.mode = evMode;
    
    PokemonStatID statID = [statNumber intValue];
    vc.current = [pokemon.currentSpread effortForStat:statID];
    vc.goal = [pokemon.goalSpread effortForStat:statID];
  }
  
  evCountFooterCell.goal = [pokemon.goalSpread totalEffort];
  evCountFooterCell.current = [pokemon.currentSpread totalEffort];
}

- (void)refreshView
{
	if (pokemon)
	{
		UIButton *titleButton = [UIButton buttonWithType:UIButtonTypeCustom];
		titleButton.frame = CGRectMake(0, 0, 160, 40);
		titleButton.imageEdgeInsets = UIEdgeInsetsMake(0, 0, 8, 8);
		
		titleButton.titleLabel.font = [UIFont boldSystemFontOfSize:20];
		titleButton.titleLabel.shadowColor = [UIColor colorWithWhite:0 alpha:0.5];
		titleButton.titleLabel.shadowOffset = CGSizeMake(0, 1);
		titleButton.titleLabel.textColor = [UIColor whiteColor];
		titleButton.titleLabel.highlightedTextColor = [UIColor darkGrayColor];
		titleButton.reversesTitleShadowWhenHighlighted = YES;
		
		[titleButton setImage:[UIImage imageNamed:pokemon.species.iconFilename] forState:UIControlStateNormal];
		[titleButton setTitle:pokemon.species.name forState:UIControlStateNormal];
		self.navigationItem.titleView = titleButton;
    
    HeldItem *item = pokemon.heldItem;
    
    TTButton *heldItemButton = [[[TTButton alloc] initWithFrame:CGRectMake(0, 0, 130, 33)] autorelease];
    [heldItemButton setStylesWithSelector:@"imageTitleToolbarButton:"];
    [heldItemButton addTarget:self action:@selector(heldItemButtonTapped) forControlEvents:UIControlEventTouchUpInside];
    
    if (item)
    {
      [heldItemButton setImage:[NSString stringWithFormat:@"bundle://%@.png", item.identifier] forState:UIControlStateNormal];
      [heldItemButton setTitle:item.name forState:UIControlStateNormal];
    }
    else
    {
      [heldItemButton setTitle:@"No held item" forState:UIControlStateNormal];
    }
    
    UIBarButtonItem *heldItemButtonItem = [[[UIBarButtonItem alloc] initWithCustomView:heldItemButton] autorelease];
    self.toolbarItems = [NSArray arrayWithObject:heldItemButtonItem];
	}
	else
	{
		self.navigationItem.titleView = nil;
	}
}

#pragma mark - Event handlers

- (void)heldItemButtonTapped
{
  HeldItemListViewController *listVC = [[HeldItemListViewController alloc] initWithManagedObjectContext:managedObjectContext];
  listVC.delegate = self;
  UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:listVC];
  [self.navigationController presentModalViewController:navController animated:YES];
  [navController release];
  [listVC release];
}

- (void)evCountInputChanged:(NSNotification *)note
{
  EVCountViewController *countVC = [note object];
  EVCountMode mode = countVC.mode;
  PokemonStatID stat = countVC.statID;
  NSInteger newValue = [(NSNumber *)[[note userInfo] objectForKey:@"newValue"] intValue];
  
  if (mode == EVCountModeEditGoal)
  {
    countVC.goal = newValue;
    [pokemon.goalSpread setEffort:newValue forStat:stat];
    evCountFooterCell.goal = [pokemon.goalSpread totalEffort];
  }
  else if (mode == EVCountModeEditCurrent)
  {
    countVC.current = newValue;
    [pokemon.currentSpread setEffort:newValue forStat:stat];
    evCountFooterCell.current = [pokemon.currentSpread totalEffort];
  }
  
  [countVC updateView];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	switch (section)
	{
		case 0:
			return 2;
		case 1:
			return 1;
	}
	
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
	{
    if (indexPath.row == 0)
    {
      UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
      cell.selectionStyle = UITableViewCellSelectionStyleNone;
      
      TTGridLayout *grid = [[TTGridLayout alloc] init];
      grid.columnCount = 3;
      grid.spacing = 0;
      grid.padding = 0;
      
      TTView *evTable = [[TTView alloc] initWithFrame:CGRectMake(0, 0, 300, 80)];
      evTable.layout = grid;
      evTable.backgroundColor = [UIColor clearColor];
      
      for (int i = PokemonStatFirst; i <= PokemonStatLast; i++)
      {
        EVCountViewController *countVC = [[EVCountViewController alloc] initWithStatID:i];
        if (evMode != EVCountModeView)
          countVC.textField.alpha = 1;
        countVC.mode = evMode;
        
        [evTable addSubview:countVC.view];
        [evViewControllers setObject:countVC forKey:[NSNumber numberWithInt:i]];
        [countVC release];
      }
      
      [cell.contentView addSubview:evTable];
      
      return cell;
    }
    if (indexPath.row == 1)
    {
      if (self.evCountFooterCell == nil)
      {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:NSStringFromClass([EVCountFooterCell class]) owner:nil options:nil];
        self.evCountFooterCell = [nib objectAtIndex:0];
        
        evCountFooterCell.mode = evMode;
      }
      
      return self.evCountFooterCell;
    }
	}
	
	if (indexPath.section == 1)
	{
		if (indexPath.row == 0)
		{
			UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil] autorelease];
			cell.textLabel.text = @"Battled new Pokémon";
			cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
			
			return cell;
		}
	}
	
	return nil;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 1 && indexPath.row == 0)
	{
		[self presentPokemonListWithEVs:YES];
	}
  else if (indexPath.section == 0)
  {
    evMode = (evMode == EVCountModeView) ? EVCountModeEditGoal : EVCountModeView;
    
    [self updateEVCountViews];
    
    evCountFooterCell.mode = evMode;
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
  }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0 && indexPath.row == 0)
		return 80;
	
	return 44;
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
	if (indexPath.section == 0)
		cell.backgroundView = nil;
}

- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{
}

#pragma mark - Held item list

- (void)heldItemList:(HeldItemListViewController *)listVC choseItem:(HeldItem *)item
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
  
  self.pokemon.heldItem = item;
  
  NSError *error;
  if (![managedObjectContext save:&error])
  {
    DLog(@"Unable to set held item: %@", error);
    [managedObjectContext rollback];
  }
  
  [self refreshView];
}

#pragma mark - Pokemon list

- (void)presentPokemonListWithEVs:(BOOL)showEVYield
{
	PokemonListViewController *listVC = [[PokemonListViewController alloc] initWithManagedObjectContext:managedObjectContext];
	listVC.delegate = self;
	listVC.showEVYield = showEVYield;
	
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:listVC];
	navController.toolbarHidden = NO;
	
	[self.navigationController presentModalViewController:navController animated:YES];
	
	[navController release];
	[listVC release];
}

- (void)pokemonList:(PokemonListViewController *)listVC chosePokemon:(PokemonSpecies *)species
{
	[self.navigationController dismissModalViewControllerAnimated:YES];
	
	if (listVC.showEVYield)
	{
		
	}
	else
	{
		Pokemon *newPokemon = [Pokemon insertInManagedObjectContext:managedObjectContext];
		newPokemon.species = species;
    newPokemon.goalSpread = [EVSpread insertInManagedObjectContext:managedObjectContext];
    newPokemon.currentSpread = [EVSpread insertInManagedObjectContext:managedObjectContext];
		
		self.pokemon = newPokemon;
    
    NSError *error;
    if (![managedObjectContext save:&error])
    {
      DLog(@"Unable to create new Pokemon: %@", error);
      [managedObjectContext rollback];
    }
		
		[self refreshView];
	}
}

#pragma mark - Memory management

- (void)didReceiveMemoryWarning
{
	// Releases the view if it doesn't have a superview.
	[super didReceiveMemoryWarning];

	// Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload
{
	[super viewDidUnload];
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self];
  
  [evViewControllers release];
  [evCountFooterCell release];
  [managedObjectContext release];
  [pokemon release];
	[super dealloc];
}


@end
