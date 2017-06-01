//
//  TaxiProxy.h
//  Taxi
//
//  Created by Arul on 10/29/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AppDelegate.h"
#import "ViewController.h"
#import "TaxiResponseVO.h"


#import "TaxiDetailsVO.h"
#import "TaxicityDTOVO.h"
#import "TaxicountryDTOVO.h"
#import "TaxiDestinationVO.h"
#import "TaxiSourceVO.h"
#import "TaxisupplierDTOVO.h"
#import "TaxiuserDTOVO.h"
#import "TaxiReviewVO.h"

@interface TaxiProxy : NSObject{
    
    
    NSMutableArray *taxiResponseArray;
    
    NSMutableArray *reviewResponseArray;
}

+ (TaxiProxy*) shardInstance;

- (void) callTaxiAPIWithLocation:(CLLocation*)location;

- (void) callToGetIndividualTaxiDetailsWithTaxiID:(NSString*)taxiID;

- (void) callToGetReviewWithTaxiID:(NSString*)taxiID;



@end
