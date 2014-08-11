//
//  STMainViewController.h
//  SaveTweets
//
//  Created by Rose on 8/8/14.
//  Copyright (c) 2014 LadyMartel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STMainViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *searchQuery;
- (IBAction)handleSearch:(id)sender;
- (IBAction)handleViewSavedTweets:(id)sender;
- (IBAction)handleConnectTwitter:(id)sender;

@end
