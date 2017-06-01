//
//  ViewController.h
//  Taxi
//
//  Created by Arul on 10/24/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import <QuartzCore/QuartzCore.h>

#import "AFHTTPRequestOperation.h"
#import "AFHTTPRequestOperationManager.h"
#import "AFNetworkReachabilityManager.h"

#import "AppDelegate.h"
#import "TaxiProxy.h"
#import "TaxiDetailViewController.h"
#import "CustomTaxiMKPointAnnotation.h"
#import "TaxiLoginViewController.h"
#import "TaxiRightTableViewCell.h"


@interface ViewController : UIViewController<MKMapViewDelegate,CLLocationManagerDelegate,UITextFieldDelegate,UIGestureRecognizerDelegate,UITableViewDataSource,UITableViewDelegate>{
    
    CLLocationManager *locationManager;
    
    CLLocation *currentLocation;
    
    IBOutlet UIButton *callTaxiButton;
    
    IBOutlet UIView *searchView;
    
    IBOutlet UIScrollView *scrollView;
    
    IBOutlet UIButton *transportTypeButton;
    
    IBOutlet UIView *pointToPonitView;
    
    IBOutlet UIView *airportTransferView;
    
    IBOutlet UIView *outStationTransferView;
    
    
    IBOutlet UIButton *cancelButton;
    
    IBOutlet UIButton *searchButton;
    
    IBOutlet UITextField *ppsourceTextField;
    
    IBOutlet UITextField *ppdestinationTextField;
    
    IBOutlet UILabel *transportTypeLabel;
    
    IBOutlet UIView *transportTypeView;
    
    IBOutlet UIView *profileView;
    
    IBOutlet UIImageView *profileImageView;
    
    IBOutlet UILabel *profileNameLabel;
    
    IBOutlet UIButton *notificationButton;
    
    IBOutlet UIButton *promotionButton;
    
    IBOutlet UIButton *freeRideButton;
    
    IBOutlet UIButton *paymetButton;
    
    IBOutlet UIButton *historyButton;
    
    IBOutlet UIButton *helpButton;
    
    IBOutlet UIButton *settingsButton;
    
    IBOutlet UIView *unauthorizedView;
    
    IBOutlet UIView *authorizedView;
    
    IBOutlet UIButton *loginRegisterButton;
    
    IBOutlet UIView *rightView;
    
    IBOutlet UIButton *rightViewButton;
    
    IBOutlet UITableView *rightTableView;
    
    BOOL rightViewOn;
    
    
    IBOutlet UIButton *pointToPointButton,*airportTransferButton,*OutstationTransferButton;
    
    
    
}

@property(nonatomic,strong) IBOutlet MKMapView *mapView;

@property(nonatomic,retain) NSMutableArray *taxiResponseArray;


-(IBAction)onCallTaxiButtonClicked:(id)sender;

-(IBAction)onTransPortTypeButtonClicked:(id)sender;

-(IBAction)onCancelButtonClicked:(id)sender;

-(IBAction)onSearchButtonClicked:(id)sender;

-(IBAction)onLoginRegisterButtonClicked:(id)sender;

-(IBAction)onNotificationButtonClicked:(id)sender;
-(IBAction)onPromotonButtonClicked:(id)sender;
-(IBAction)onFreeRideButtonClicked:(id)sender;
-(IBAction)onPaymentButtonClicked:(id)sender;
-(IBAction)onHistoryButtonClicked:(id)sender;
-(IBAction)onHelpButtonClicked:(id)sender;
-(IBAction)onSetingsButtonClicked:(id)sender;

-(IBAction)onRightViewButtonClicked:(id)sender;


-(IBAction)onPointToPointButtonClicked:(id)sender;

-(IBAction)onAirportTransferButtonClicked:(id)sender;

-(IBAction)onOutstationTranferButtonClicked:(id)sender;



@end

