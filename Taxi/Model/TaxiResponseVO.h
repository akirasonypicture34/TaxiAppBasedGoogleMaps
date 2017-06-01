//
//  TaxiResponseVO.h
//  Taxi
//
//  Created by Arul on 10/30/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TaxiResponseVO : NSObject

@property(nonatomic,retain) NSString *acVehicle;

@property(nonatomic,retain) NSString *address;

@property(nonatomic,retain) NSString *blobkey;

@property(nonatomic,retain) NSString *cartype;

@property(nonatomic,retain) NSString *currency;

@property(nonatomic,retain) NSString *taxDescription;

@property(nonatomic,retain) NSString *dropOffLocation;

@property(nonatomic,retain) NSString *taId;

@property(nonatomic,retain) NSString *imageUrl;

@property(nonatomic,assign) float latitude;

@property(nonatomic,assign) float longitude;

@property(nonatomic,retain) NSString *name;

@property(nonatomic,assign) int phoneNumber;

@property(nonatomic,retain) NSString *pickUpLocation;

@property(nonatomic,assign) float price;

@property(nonatomic,retain) NSString *starRating;

@property(nonatomic,retain) NSString *supplierId;

@property(nonatomic,retain) NSString *transporttype;

@property(nonatomic,assign) int type;

@property(nonatomic,retain) NSString *website;


@end
