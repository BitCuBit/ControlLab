//
//  ControlLabAppDelegate.m
//  ControlLab
//
//  Created by Pablo Casado Varela on 13/02/13.
//  Copyright (c) 2013 Pablo Casado Varela. All rights reserved.
//

#import "ControlLabAppDelegate.h"

@implementation ControlLabAppDelegate {

}

@synthesize mm;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    // Set Gyroscope
    mm = [[CMMotionManager alloc] init];

    NSString *usuario = @"pcasado@dtic.ua.es"; // Just an example
    NSString *password = @"b78uxmM33r1"; // Just an example
    NSString *urlCam1 = @"http://shanon.iuii.ua.es/cam1/"; // Just an example
    NSString *urlCam2 = @"http://shanon.iuii.ua.es/cam2/"; // Just an example
    NSString *urlCam3 = @"http://shanon.iuii.ua.es/cam3/"; // Just an example
    NSNumber *gyroscope = [[NSNumber alloc] initWithInt:1];
    NSNumber *panGesture = [[NSNumber alloc] initWithInt:1];
    NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];

    if (standardUserDefaults) {
        [standardUserDefaults setObject:[NSString stringWithString:usuario] forKey:@"usuario"];
        [standardUserDefaults setObject:[NSString stringWithString:password] forKey:@"password"];
        [standardUserDefaults setObject:[NSString stringWithString:urlCam1] forKey:@"urlcam1"];
        [standardUserDefaults setObject:[NSString stringWithString:urlCam2] forKey:@"urlcam2"];
        [standardUserDefaults setObject:[NSString stringWithString:urlCam3] forKey:@"urlcam3"];
        [standardUserDefaults setObject:gyroscope forKey:@"gyroscope"];
        [standardUserDefaults setObject:panGesture forKey:@"panGesture"];
        [standardUserDefaults synchronize];
    }

    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
