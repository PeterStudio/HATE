//
//  AppDelegate.m
//  HATE
//
//  Created by duwen on 15/4/21.
//  Copyright (c) 2015年 peterstudio. All rights reserved.
//

#import "AppDelegate.h"
#import "PTDefine.h"
#import "LoginViewController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

+ (AppDelegate *)appDelegate{
    return (AppDelegate *)[UIApplication sharedApplication].delegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, UIScreenWidth, UIScreenHeight)];
    [self reloadLoginViewController];
    return YES;
}

- (void)reloadLoginViewController{
    UIStoryboard * storyboard = [UIStoryboard storyboardWithName:@"UserSystemSB" bundle:nil];
    LoginViewController * loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginSBID"];
    loginVC.title = @"登录";
    UINavigationController * nav = [[UINavigationController alloc]initWithRootViewController:loginVC];
    [self.window setRootViewController:nav];
    [self.window makeKeyAndVisible];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
