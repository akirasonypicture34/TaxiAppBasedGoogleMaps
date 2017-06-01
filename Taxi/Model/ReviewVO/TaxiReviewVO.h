//
//  TaxiReviewVO.h
//  Taxi
//
//  Created by Arul on 1/25/16.
//  Copyright (c) 2016 Daxter. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TaxiReviewVO : NSObject

@property(nonatomic,retain) NSString *comment;

@property(nonatomic,retain) NSString *formattedDate;

@property(nonatomic,retain) NSString *commentId;

@property(nonatomic,retain) NSString *rating;

@property(nonatomic,retain) NSString *taxiId;

@property(nonatomic,retain) NSString *updateDate;

@property(nonatomic,retain) NSString *userEmail;

@property(nonatomic,retain) NSString *userFullName;

@end
