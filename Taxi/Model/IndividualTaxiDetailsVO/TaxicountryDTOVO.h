//
//  TaxicountryDTOVO.h
//  Taxi
//
//  Created by Arul on 10/31/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxicountryDTOVO : NSObject

@property(nonatomic,retain) NSString *active;

@property(nonatomic,retain) NSString *cities;

@property(nonatomic,retain) NSString *countryCode;

@property(nonatomic,retain) NSString *countryName;

@property(nonatomic,assign) int countryID;

@property(nonatomic,retain) NSString *updatedOn;


@end
