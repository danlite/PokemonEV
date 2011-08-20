//
//  InfoViewController.h
//  PokemonEV
//
//  Created by Dan Lichty on 11-08-19.
//  Copyright 2011 Daniel Lichty. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>


@interface InfoViewController : UITableViewController <MFMailComposeViewControllerDelegate, UIWebViewDelegate, UIAlertViewDelegate> {
	UIViewController *webViewController;
}

@end
