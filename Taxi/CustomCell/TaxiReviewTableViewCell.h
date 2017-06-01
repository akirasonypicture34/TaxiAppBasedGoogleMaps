//
//  TaxiReviewTableViewCell.h
//  Taxi
//
//  Created by Arul on 1/11/16.
//  Copyright (c) 2016 Daxter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface TaxiReviewTableViewCell : UITableViewCell

@property(nonatomic,retain) IBOutlet UIImageView *reviewImageView;

@property(nonatomic,retain) IBOutlet UILabel *reviewNameLabel;

@property(nonatomic,retain) IBOutlet UILabel *reviewDateLabel;

@property(nonatomic,retain) IBOutlet UILabel *reviewTitleLabel;

@property(nonatomic,retain) IBOutlet UILabel *reviewDescriptionLabel;



@end
