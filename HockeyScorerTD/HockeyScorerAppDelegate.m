//
//  HockeyScorerAppDelegate.m
//  HockeyScorerTD
//
//  Created by Anne West on 9/1/14.
//  Copyright (c) 2014 TDG. All rights reserved.
//

#import "HockeyScorerAppDelegate.h"

//need to import the top level VC and the dataModel
#import "SeasonsViewController.h"
#import "DataModel.h"

@implementation HockeyScorerAppDelegate
{
    DataModel *_dataModel;//should be the only instance variable in this app
}

//create the top level DataModel object and find the top level VC
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    
    _dataModel = [[DataModel alloc] init];
    
    //find the top level navigation contoler (SVC) via reference to top level object UIWindow
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    
    //not the topViewControler here becuase that's what is on top of the screen right now. Want first item in the array under the root view controller
    SeasonsViewController *controller = navigationController.viewControllers[0];
    
    controller.dataModel = _dataModel;
    
    
    return YES;
}

//Prepare to save when ap enters background or is terminated

- (void) saveData
{
    /*//find the top level navigation contoler (SVC) via reference to top level object UIWindow
    UINavigationController *navigationController = (UINavigationController *) self.window.rootViewController;
    
    //not the topViewControler here becuase that's what is on top of the screen right now. Want first item in the array under the root view controller
    SeasonsViewController *controller = navigationController.viewControllers[0];
    
    //use the save method there
    [controller saveSeasons];*/
    
    [_dataModel saveSeasons];
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self saveData];
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    [self saveData];
}


							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}



- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


@end
