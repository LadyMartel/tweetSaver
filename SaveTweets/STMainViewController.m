//
//  STMainViewController.m
//  SaveTweets
//
//  Created by Rose on 8/8/14.
//  Copyright (c) 2014 LadyMartel. All rights reserved.
//

#import "STMainViewController.h"
#import "STTableViewController.h"
#import "STAppDelegate.h"
#import "STTweet.h"

@implementation STMainViewController{
  
  NSManagedObjectContext *context;
  NSEntityDescription *entityDesc;
  NSFetchRequest *request;
  
  ACAccountStore* _accountStore;
  ACAccountType*_accountType;
  SLRequest *slrequest;
  
  //  NSManagedObject *newTweet;
  NSMutableArray * _tweetList;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  /* sets up handling search */
  [_searchQuery setDelegate: self];
  
  /* sets up the context, entityDesc, request */
  STAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
  context = [appDelegate managedObjectContext];
  entityDesc = [NSEntityDescription entityForName:@"STTweet" inManagedObjectContext:context];
  request = [[NSFetchRequest alloc] init];
  [request setEntity:entityDesc];
  
  /* asks for permission to access twitter account */
  _accountStore = [[ACAccountStore alloc] init];
  _accountType = [_accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
  
  [self askForPermissionTwitter];
  _tweetList = [NSMutableArray array];
}

-(void)askForPermissionTwitter{
  [_accountStore requestAccessToAccountsWithType:_accountType options:nil completion:^(BOOL granted, NSError *error) {
    if (!granted) {
      NSLog(@"Access denied.");
    }
    else {
      NSLog (@"Access given");
      
      if ([[_accountStore accountsWithAccountType:_accountType] count] < 1){
        UIAlertView * errorPopup = [[UIAlertView alloc]
                                    initWithTitle:@"Error"
                                    message:@"No twitter accounts found on device. Please login through another app."
                                    delegate:nil
                                    cancelButtonTitle:@"OK"
                                    otherButtonTitles: nil];
        [errorPopup show];
      }
    }
  }];
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [_searchQuery resignFirstResponder];
  return YES;
}


- (IBAction)handleSearch:(id)sender {
  if([_searchQuery.text length] <= 0){
    UIAlertView * errorPopup = [[UIAlertView alloc]
                                initWithTitle:@"Error"
                                message:@"Please enter a term to search"
                                delegate:nil
                                cancelButtonTitle:@"OK"
                                otherButtonTitles: nil];
    [errorPopup show];
    
  }else{
    NSURL *url = [NSURL URLWithString:@"https://api.twitter.com/1.1/search/tweets.json"];
    NSDictionary *params = @{ @"q": _searchQuery.text};
    slrequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:url parameters:params];
    
    slrequest.account = [_accountStore accountsWithAccountType:_accountType].firstObject;
    
    [slrequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
      if (responseData) {
        if (urlResponse.statusCode >= 200 && urlResponse.statusCode < 300) {
          NSError *jsonError;
          NSDictionary *tweetsData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingAllowFragments error:&jsonError];
          if (tweetsData) {
            //            NSLog(@"Tweets: %@", [tweetsData objectForKey:@"statuses"]);
            for (NSDictionary *d in [tweetsData objectForKey:@"statuses"]){
              [_tweetList addObject:[STTweet tweetFromTwitterDictionary:d]];
            }
            NSLog(@"%d", [_tweetList count]);
          } else {
            NSLog(@"Error when serializing from JSON: %@", jsonError.localizedDescription);
          }
        } else {
          NSLog(@"Request not considered successful, status code: %ld, description: %@", (long)urlResponse.statusCode, urlResponse.debugDescription);
        }
      }
    }];
  }
  
}

- (IBAction)handleViewSavedTweets:(id)sender {
  
}

- (IBAction)handleConnectTwitter:(id)sender {
  
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
  STTableViewController* next;
  if([[segue identifier] isEqualToString:@"search"]){
    next = (STTableViewController *)[segue destinationViewController];
    [next setTitle: [NSString stringWithFormat: @"Searching: %@ ", _searchQuery.text]];
    NSLog(@"here?");
    // Passes the tweet list
    next.tweetsList = _tweetList;

  }else if([[segue identifier] isEqualToString:@"save"]){
    next = (STTableViewController *)[segue destinationViewController];
    //    next = (STTableViewController *)[segue destinationViewController];
    //    [next setTitle: @"Saved Tweets"];
  }
}

@end
