//
//  TaxisupplierDTOVO.h
//  Taxi
//
//  Created by Arul on 10/31/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TaxiuserDTOVO.h"

@interface TaxisupplierDTOVO : NSObject

@property(nonatomic,retain) NSString *address;

@property(nonatomic,assign) int supplierID;

@property(nonatomic,assign) float latitude;

@property(nonatomic,assign) float longitude;

@property(nonatomic,assign) int licenseNumber;

@property(nonatomic,retain) NSString *name;

@property(nonatomic,assign) int phoneNumber;

@property(nonatomic,retain) NSString *profilePictureBlobkey;

@property(nonatomic,retain) NSString *profilePictureUrl;

@property(nonatomic,retain) TaxiuserDTOVO *taxiuserDTOVO;

@property(nonatomic,retain) NSString *website;







@end
