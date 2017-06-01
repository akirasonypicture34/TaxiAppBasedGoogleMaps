//
//  TaxiDetailsVO.h
//  Taxi
//
//  Created by Arul on 10/31/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "TaxicityDTOVO.h"
#import "TaxicountryDTOVO.h"
#import "TaxiDestinationVO.h"
#import "TaxiSourceVO.h"
#import "TaxisupplierDTOVO.h"

@interface TaxiDetailsVO : NSObject

@property(nonatomic,retain) NSString *acVehicle;

@property(nonatomic,retain) NSString *active;

@property(nonatomic,retain) NSString *additionalInformation;

@property(nonatomic,assign) BOOL cancellationPolicy;\

@property(nonatomic,retain) NSString *cartype;

@property(nonatomic,retain) TaxicityDTOVO *taxicityDTOVO;

@property(nonatomic,retain) TaxicountryDTOVO *taxicountryDTOVO;

@property(nonatomic,retain) NSString *currency;

@property(nonatomic,retain) NSString *taxiDescription;

@property(nonatomic,retain) TaxiDestinationVO *taxiDestinationVO;

@property(nonatomic,retain) NSString *dropOffLocation;

@property(nonatomic,assign) int taxiID;

@property(nonatomic,assign) float latitude;

@property(nonatomic,assign) float longitude;

@property(nonatomic,assign) int  maxLuggageCapacity;

@property(nonatomic,assign) int maxPassengerCapacity;

@property(nonatomic,retain) NSString *meetingPoint;

@property(nonatomic,retain) NSString *name;

@property(nonatomic,retain) NSString *pickUpLocation;

@property(nonatomic,assign) int price;

@property(nonatomic,retain) TaxiSourceVO *taxiSourceVO;

@property(nonatomic,retain) NSString *starRating;

@property(nonatomic,retain) TaxisupplierDTOVO *taxiSupplierDTOVO;

@property(nonatomic,retain) NSString *transporttype;

@property(nonatomic,retain) NSString *updatedOn;





@end
