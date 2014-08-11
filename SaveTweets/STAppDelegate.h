//
//  STAppDelegate.h
//  SaveTweets
//
//  Created by Rose on 8/6/14.
//  Copyright (c) 2014 LadyMartel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface STAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
