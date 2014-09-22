//
//  ViewController.m
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


#import "ViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface ViewController ()<CLLocationManagerDelegate>


-(IBAction)emailNotif:(id)sender;
-(IBAction)imageNotif:(id)sender;
-(IBAction)locationNotif:(id)sender;


@end

@implementation ViewController
            
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark
#pragma mark IBAction methods

-(IBAction)emailNotif:(id)sender{
    
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = @"Email Based Notification";
    localNotification.category = @"Email";  // This should match categories identifier which we have defined in App delegate
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];

}

-(IBAction)imageNotif:(id)sender{
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = @"Image Download Notification";
    localNotification.category = @"Image";  // This should match categories identifier which we have defined in App delegate
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}

-(IBAction)locationNotif:(id)sender{
    
    CLLocationManager *manager = [[CLLocationManager alloc] init];
    manager.delegate = self;
    [manager requestAlwaysAuthorization]; // you need to define NSLocationAlwaysUsageDescription key in plist file
    //[manager requestWhenInUseAuthorization]; // you need to define NSLocationWhenInUseUsageDescripion in plist file
}

-(void)startShowingNotification{
    
    UILocalNotification* localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    localNotification.alertBody = @"Location based Notification";
    localNotification.regionTriggersOnce = NO;
    
    CLLocationCoordinate2D coord;
    coord.latitude = 28.597727;
    coord.longitude = 77.373868;
    localNotification.region = [[CLCircularRegion alloc] initWithCenter:coord radius:0.5 identifier:@"Home"];
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
    
}


#pragma mark
#pragma mark CLLocationManagerDelegate methods

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
    
    NSLog(@"**** didChangeAuthorizationStatus ****");
    BOOL canUseLocationNotification = (status == kCLAuthorizationStatusAuthorizedAlways);
    //BOOL canUseLocationNotification = (status == kCLAuthorizationStatusAuthorizedWhenInUse);
    if (canUseLocationNotification) {
        [self startShowingNotification];
    }
}


@end
