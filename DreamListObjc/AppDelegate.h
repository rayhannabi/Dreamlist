//
//  AppDelegate.h
//  DreamListObjc
//
//  Created by Rayhan Janam on 6/19/18.
//  Copyright © 2018 Rayhan Janam. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong) NSPersistentContainer *persistentContainer;

+ (AppDelegate *)sharedDelegate;
+ (NSManagedObjectContext *)managedContext;

- (void)saveContext;

@end

