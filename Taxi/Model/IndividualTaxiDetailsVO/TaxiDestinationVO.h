//
//  TaxiDestinationVO.h
//  Taxi
//
//  Created by Arul on 10/31/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxiDestinationVO : NSObject

@property(nonatomic,retain) NSString *active;

@property(nonatomic,retain) NSString *cityDTO;

@property(nonatomic,assign) int destinationID;

@property(nonatomic,retain) NSString *regionAddress;

@property(nonatomic,retain) NSString *regionCode;

@property(nonatomic,retain) NSString *regionName;

@property(nonatomic,retain) NSString *regiontype;

@property(nonatomic,retain) NSString *updatedOn;



@end
