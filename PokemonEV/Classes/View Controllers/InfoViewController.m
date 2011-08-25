//
//  InfoViewController.m
//  PokemonEV
//
//  Created by Dan Lichty on 11-08-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import "InfoViewController.h"
#import "Appirater.h"

typedef enum InfoViewIndex {
	InfoViewEmail = 0,
	InfoViewFAQ = 1,
	InfoViewRating = 2
} InfoViewIndex;

@interface InfoViewController(Private)

- (void)emailTapped;

@end

@implementation InfoViewController

- (id)init
{
	if ((self = [super initWithStyle:UITableViewStyleGrouped]))
	{
		self.hidesBottomBarWhenPushed = YES;
		self.title = @"Info";
	}
	return self;
}

- (void)dealloc
{
	[webViewController release];
	[super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
	[super viewDidLoad];
	
	self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(closeTapped)] autorelease];
}

- (void)closeTapped
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
	return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
	return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
	static NSString *CellIdentifier = @"Cell";
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	}
	
	NSString *iconName = @"";
	switch (indexPath.section)
	{
		case InfoViewEmail:
			cell.textLabel.text = @"Send me feedback";
			iconName = @"envelope";
			break;
		case InfoViewFAQ:
			cell.textLabel.text = @"Frequently asked questions";
			iconName = @"faq";
			break;
		case InfoViewRating:
			cell.textLabel.text = @"Leave a rating";
			iconName = @"star";
			break;
	}
	
	cell.imageView.image = [UIImage imageNamed:[NSString stringWithFormat:@"icon-%@", iconName]];
	cell.imageView.highlightedImage = [UIImage imageNamed:[NSString stringWithFormat:@"icon-%@-lit", iconName]];
	
	return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	switch (indexPath.section)
	{
		case InfoViewEmail:
			[self emailTapped];
			break;
		case InfoViewRating:
			[Appirater rateApp];
			[tableView deselectRowAtIndexPath:indexPath animated:YES];
			break;
		case InfoViewFAQ:
		{
			[webViewController release];
			webViewController = [[UIViewController alloc] init];
			webViewController.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Close" style:UIBarButtonItemStyleBordered target:self action:@selector(modalCloseTapped)] autorelease];
			
			UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:webViewController];
			[self presentModalViewController:navController animated:YES];
			
			UIWebView *webView = [[UIWebView alloc] initWithFrame:webViewController.view.bounds];
			webView.delegate = self;
			[webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://appsbydan.com/evtrack/faq.html"]]];
			[webViewController.view addSubview:webView];
			[webView release];
			
			break;
		}
	}
}

#pragma - Event handlers

- (void)modalCloseTapped
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Web view

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[webViewController setTitle:@"Loading..."];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[webViewController setTitle:[webView stringByEvaluatingJavaScriptFromString:@"document.title"]];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	[[[[UIAlertView alloc]
		 initWithTitle:@"Unable to load FAQs"
		 message:[error localizedDescription]
		 delegate:self
		 cancelButtonTitle:@"OK"
		 otherButtonTitles:nil]
		autorelease]
	 show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
	[self dismissModalViewControllerAnimated:YES];
}

#pragma mark - Email

- (void)emailTapped
{
	if (![MFMailComposeViewController canSendMail])
	{
		[[[[UIAlertView alloc] initWithTitle:@"Cannot Send Email" message:@"Email is not set up on this device." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
		return;
	}
	
	MFMailComposeViewController *composer = [[MFMailComposeViewController alloc] init];
	[composer setMailComposeDelegate:self];
	
	[composer setSubject:[NSString stringWithFormat:@"%@ Feedback", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleNameKey]]];
	[composer setToRecipients:[NSArray arrayWithObject:@"dan@appsbydan.com"]];
	
	[self.navigationController presentModalViewController:composer animated:YES];
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
	if (result == MFMailComposeResultFailed)
	{
		[[[[UIAlertView alloc] initWithTitle:@"Email Failed" message:@"There was an error sending your email. Please try again later." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] autorelease] show];
	}
	
	[self.navigationController dismissModalViewControllerAnimated:YES];
}

@end
