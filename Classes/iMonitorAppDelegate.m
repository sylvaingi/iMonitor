//
//  iMonitorAppDelegate.m
//  iMonitor
//
//  Created by Robert Zboub on 21/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "iMonitorAppDelegate.h"
#import "TacController.h"
#import "ServicesController.h"
#import "HotesController.h"

@implementation iMonitorAppDelegate

@synthesize window;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
	
	TacController *tac = [[TacController alloc] initWithNibName:@"TacController" bundle:nil];
	
	
    HotesController *hotes = [[HotesController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *hotesNav = [[UINavigationController alloc]initWithRootViewController:hotes];
    
	ServicesController *services = [[ServicesController alloc] initWithStyle:UITableViewStylePlain];
    UINavigationController *servicesNav = [[UINavigationController alloc]initWithRootViewController:services];
	
	UITabBarController* tabController =[[UITabBarController alloc] init];
	tabController.viewControllers=[NSArray arrayWithObjects:tac,hotesNav,servicesNav,nil];
	
	[self.window addSubview:tabController.view];
	
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
