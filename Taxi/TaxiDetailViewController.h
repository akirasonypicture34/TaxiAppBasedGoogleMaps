//
//  TaxiDetailViewController.h
//  Taxi
//
//  Created by Arul on 10/30/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

#import "ViewController.h"
#import "TaxiResponseVO.h"
#import "TaxiProxy.h"

#import "TaxiDetailsVO.h"
#import "TaxicityDTOVO.h"
#import "TaxicountryDTOVO.h"
#import "TaxiDestinationVO.h"
#import "TaxiSourceVO.h"
#import "TaxisupplierDTOVO.h"
#import "TaxiuserDTOVO.h"

#import "TaxiReviewTableViewCell.h"
#import "TaxiReviewVO.h"

@interface TaxiDetailViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    
    TaxiDetailsVO *taxiDetailsVO;
    
    IBOutlet UIActivityIndicatorView *activityIndicator;
    
    IBOutlet UIImageView *mapImageView;
    
    IBOutlet UIImageView *taxiImageView;
    
    IBOutlet UILabel *taxiNameLabel;
    
    IBOutlet UILabel *taxiWebSiteLabel;
    
    IBOutlet UILabel *distanceLabel;
    
    IBOutlet UIButton *taxiBookButton;
    
    IBOutlet UILabel *taxiAddressLabel;
    
    IBOutlet UILabel *totalFavoritesLabel;
    
    IBOutlet UIButton *phoneButton;
    
    IBOutlet UIButton *whatsUpButton;
    
    IBOutlet UIButton *bookButton;
    
    IBOutlet UITableView *taxiReviewTableView;
    
}
    

@property(nonatomic,retain) TaxiResponseVO *taxiResponseVO;

@property(nonatomic,retain) NSMutableArray *reviewArray;


-(IBAction)onTaxiBookNowButtonClicked:(id)sender;
-(IBAction)onTaxiPhoneButtonClicked:(id)sender;
-(IBAction)onTaxiWhatsUpButtonClicked:(id)sender;
-(IBAction)onTaxiBookButtonClicked:(id)sender;



@end
