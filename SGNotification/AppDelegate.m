//
//  AppDelegate.m
//  SGNotification
//
//  Created by Sourav on 17/09/14.
//  Copyright (c) 2014 com.sourav.gupta. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.


#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
            

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [self getNotificationPermission];
    return YES;
}


// This methid needs to be called for both local notification and Remote notification
// A pop up will be shown to user, so that he can select whether he wants the notifications or not

-(void)getNotificationPermission{
    
    // Accept Action
    
    UIMutableUserNotificationAction *acceptAction = [[UIMutableUserNotificationAction alloc] init];
    acceptAction.identifier = @"Accept";
    acceptAction.title = @"Accept";
    acceptAction.activationMode = UIUserNotificationActivationModeBackground;
    acceptAction.destructive = NO;
    acceptAction.authenticationRequired = NO;
    
    // Reject Action
    
    UIMutableUserNotificationAction *rejectAction = [[UIMutableUserNotificationAction alloc] init];
    rejectAction.identifier = @"Reject";
    rejectAction.title = @"Reject";
    rejectAction.activationMode = UIUserNotificationActivationModeBackground;
    rejectAction.destructive = YES;
    rejectAction.authenticationRequired = YES;
    
    // Reply Action
    
    UIMutableUserNotificationAction *replyAction = [[UIMutableUserNotificationAction alloc] init];
    replyAction.identifier = @"Reply";
    replyAction.title = @"Reply";
    replyAction.activationMode = UIUserNotificationActivationModeForeground;
    replyAction.destructive = NO;
    replyAction.authenticationRequired = YES;
    
    // Email Category
    
    UIMutableUserNotificationCategory *emailCategory = [[UIMutableUserNotificationCategory alloc] init];
    emailCategory.identifier = @"Email";
    [emailCategory setActions:@[acceptAction,rejectAction,replyAction] forContext:UIUserNotificationActionContextDefault];
    [emailCategory setActions:@[acceptAction,rejectAction] forContext:UIUserNotificationActionContextMinimal];
    
    // Download Action
    
    UIMutableUserNotificationAction *downloadAction = [[UIMutableUserNotificationAction alloc] init];
    downloadAction.identifier = @"Download";
    downloadAction.title = @"Download";
    downloadAction.activationMode = UIUserNotificationActivationModeForeground;
    downloadAction.destructive = NO;
    downloadAction.authenticationRequired = YES;
    
    UIMutableUserNotificationAction *cancelAction = [[UIMutableUserNotificationAction alloc] init];
    cancelAction.identifier = @"Cancel";
    cancelAction.title = @"Cancel";
    cancelAction.activationMode = UIUserNotificationActivationModeForeground;
    cancelAction.destructive = YES;
    cancelAction.authenticationRequired = YES;

    
    // Image Category
    
    UIMutableUserNotificationCategory *imageCategory = [[UIMutableUserNotificationCategory alloc] init];
    imageCategory.identifier = @"Image";
    [imageCategory setActions:@[downloadAction,cancelAction] forContext:UIUserNotificationActionContextDefault];
    [imageCategory setActions:@[downloadAction,cancelAction] forContext:UIUserNotificationActionContextMinimal];


    NSSet *categories = [NSSet setWithObjects:emailCategory,imageCategory, nil];
    UIUserNotificationType notificarionType = UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert;
    
    // Register notification types and categories
    UIUserNotificationSettings *notificationSettings = [UIUserNotificationSettings settingsForTypes:notificarionType categories:categories];
    [[UIApplication sharedApplication] registerUserNotificationSettings:notificationSettings];
    
    // This line of code is required for remote push notification
    //[[UIApplication sharedApplication] registerForRemoteNotifications];



    
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

-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
    
    //UIUserNotificationType notificationtype = [notificationSettings types];
    
}

// You can check the current user notifiartions settings whenever you need it
-(void)getReadyForNotification{
    
    //UIUserNotificationSettings *settings = [[UIApplication sharedApplication] currentUserNotificationSettings];
    //[self checkSettings:settings];
}

// When appliation is in foregrounf this methid will get caled if you have scheduled a local notification
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    //CLRegion *region = notification.region;
    if ([notification.category isEqualToString:@"Image"]) {
        NSLog(@"Image category notification is presented to the user");
    }else if([notification.category isEqualToString:@"Email"]){
        NSLog(@"Email category notification is presented to the user");
    }
}

-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forLocalNotification:(UILocalNotification *)notification completionHandler:(void (^)())completionHandler{
    
    if ([identifier isEqualToString:@"Accept"]) {
        [self printAlert:@"Accept"];
    }else if ([identifier isEqualToString:@"Reject"]) {
        [self printAlert:@"Reject"];
    }else if ([identifier isEqualToString:@"Reply"]) {
        [self printAlert:@"Reply"];
    }else if ([identifier isEqualToString:@"Download"]) {
        [self printAlert:@"Download"];
    }else if ([identifier isEqualToString:@"Cancel"]) {
        [self printAlert:@"Cancel"];
    }
    completionHandler();
}

-(void)printAlert:(NSString *)title{
    NSLog(@"%@ button is selected",title);
 
   
}

// Callback for remote notification
-(void)application:(UIApplication *)application handleActionWithIdentifier:(NSString *)identifier forRemoteNotification:(NSDictionary *)userInfo completionHandler:(void (^)())completionHandler{
    NSLog(@"handleActionWithIdentifier forRemoteNotification");
}


@end
