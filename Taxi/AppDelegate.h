//
//  AppDelegate.h
//  Taxi
//
//  Created by Arul on 10/24/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <Foundation/Foundation.h>

#import "AFNetworkReachabilityManager.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

+ (BOOL) checkForInternetConnection;


+ (AppDelegate*) getAppDelegate;




@end

