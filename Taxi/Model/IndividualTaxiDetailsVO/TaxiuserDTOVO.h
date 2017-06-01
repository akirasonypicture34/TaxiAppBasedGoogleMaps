//
//  TaxiuserDTOVO.h
//  Taxi
//
//  Created by Arul on 10/31/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxiuserDTOVO : NSObject

@property(nonatomic,retain) NSString *email;

@property(nonatomic,retain) NSString *firstName;

@property(nonatomic,assign) int userID;

@property(nonatomic,retain) NSString *isSocialUser;

@property(nonatomic,retain) NSString *lastName;


@end
