//
//  AppDelegate.m
//  类网易新闻横向滑动的实现方案2
//
//  Created by huangdeyu on 16/2/23.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import "AppDelegate.h"
#import "DYHorizonalVC.h"
#import "VC1.h"
#import "VC2.h"
#import "VC3.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    VC1 * vc1 = [[VC1 alloc] init];
    VC2 * vc2 = [[VC2 alloc] init];
    VC3 * vc3 = [[VC3 alloc] init];
    VC1 * vc4 = [[VC1 alloc] init];
    VC2 * vc5 = [[VC2 alloc] init];
    DYHorizonalVC * vc   = [[DYHorizonalVC alloc] initWithControllers:@[vc1,vc2,vc3,vc4,vc5] titles:@[@"标题1",@"标题2",@"标题3",@"标题4",@"标题5"]];
    UINavigationController * nav = [[UINavigationController alloc] initWithRootViewController:vc ];
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    return YES;
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
