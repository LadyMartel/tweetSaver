//
//  STMainViewController.m
//  SaveTweets
//
//  Created by Rose on 8/8/14.
//  Copyright (c) 2014 LadyMartel. All rights reserved.
//

#import "STMainViewController.h"
#import "STTableViewController.h"

@interface STMainViewController ()

@end

@implementation STMainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
  [_searchQuery setDelegate: self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
  [_searchQuery resignFirstResponder];
  return YES;
}


- (IBAction)handleSearch:(id)sender {
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
//
  }else if([[segue identifier] isEqualToString:@"save"]){
    next = (STTableViewController *)[segue destinationViewController];
//    next = (STTableViewController *)[segue destinationViewController];
//    [next setTitle: @"Saved Tweets"];
  }
}

@end
