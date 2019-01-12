//
//  AppDelegate.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "AppDelegate.h"
#import "LoginViewController.h"
#import "SWRevealViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    self.window = UIWindow(frame: UIScreen.main.bounds)
//    let storyboard = UIStoryboard(name: "Main", bundle: nil)
//    if let user = Auth.auth().currentUser {
//        WebService.shared.fetchUserInfo(usrID: user.uid) { (value) in
//            userInfo = value
//            NotificationCenter.default.post(name: NSNotification.Name("UserInfoIsReady"), object: nil)
//        }
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "TabBarVC") as! UITabBarController
//        self.window?.rootViewController = initialViewController
//    } else {
//        let initialViewController = storyboard.instantiateViewController(withIdentifier: "SignUpVC") as! SignUpViewController
//        self.window?.rootViewController = initialViewController
//    }
//    self.window?.makeKeyAndVisible()
    
//    if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"]) {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        SWRevealViewController *sWRevealVC = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealVC"];
//        [[UIApplication sharedApplication].keyWindow setRootViewController:sWRevealVC];
//    } else {
//        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//        UIViewController *signinVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
//        [[UIApplication sharedApplication].keyWindow setRootViewController:signinVC];
//    }
    
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"isLoggedIn"]) {
            SWRevealViewController *sWRevealVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SWRevealVC"]; //or the homeController
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:sWRevealVC];
            self.window.rootViewController = navController;
        } else {
            LoginViewController *loginController = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LoginVC"]; //or the homeController
            UINavigationController *navController = [[UINavigationController alloc]initWithRootViewController:loginController];
            self.window.rootViewController = navController;
        }
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
