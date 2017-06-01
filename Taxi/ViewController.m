//
//  ViewController.m
//  Taxi
//
//  Created by Arul on 10/24/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    pointToPointButton.layer.cornerRadius = pointToPointButton.frame.size.height / 2.0f;
    airportTransferButton.layer.cornerRadius = airportTransferButton.frame.size.height / 2.0f;
    OutstationTransferButton.layer.cornerRadius = OutstationTransferButton.frame.size.height / 2.0f;
    

    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:241.0 / 255.0 green:241.0 / 255.0 blue:241.0 / 255.0  alpha:1.0]];
    [self.navigationController.navigationBar setTranslucent:NO];
    
    [self.navigationItem setTitle:@"CallTaxi"];
    
    self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObject:[UIColor blackColor] forKey:NSForegroundColorAttributeName];
    
    UIImage *image = [[UIImage imageNamed:@"6"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:image style:UIBarButtonItemStylePlain target:self action:@selector(profileButtonPressed:)];
    
     self.navigationItem.leftBarButtonItem = backButton;
    
    [profileView setHidden:YES];
    
    rightTableView.dataSource = self;
    
    rightTableView.delegate = self;
    
    [rightView setHidden:YES];
    rightViewOn = false;
    
    searchView.layer.cornerRadius = 5.0f;
    searchView.layer.borderColor = [UIColor colorWithRed:251.0 / 255.0 green:186.0 / 255.0 blue:26.0 / 255.0 alpha:1.0].CGColor;
    searchView.layer.borderWidth = 1.5f;
        
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"TaxiResponse" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
     selector:@selector(receiveTaxiResponse:)
     name:@"TaxiResponse"
     object:nil];
    
    
    UITapGestureRecognizer *gesRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTap:)]; // Declare the Gesture.
    gesRecognizer.delegate = self;
    [pointToPonitView addGestureRecognizer:gesRecognizer];
    
    
    [self.mapView bringSubviewToFront:callTaxiButton];
    
    
    [searchView setHidden:YES];
    
    
    locationManager = [[CLLocationManager alloc]init];
    
    locationManager.delegate  = self;
    
    if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [locationManager requestWhenInUseAuthorization];
    }
    
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    [locationManager startUpdatingLocation];
    
    
    self.mapView.delegate  = self;

    self.mapView.showsUserLocation = YES;
    
    self.mapView.userInteractionEnabled = YES;
    
    
    currentLocation = [[CLLocation alloc]initWithLatitude:47.376887 longitude:8.541694];
    
    [self startSearching];
    

}

-(void)profileButtonPressed:(id)sender{
    
    if (rightViewOn) {
        
        [rightView setFrame:CGRectMake(rightView.frame.origin.x + 180, rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height)];
        
        rightViewOn = false;
        
    }
    
    [profileView setHidden:NO];
}


#pragma mark - Location Manager Delegate Methods


-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
   /* currentLocation = [locations lastObject];
    
    
    MKCoordinateRegion mapRegion;
    mapRegion.center.longitude = currentLocation.coordinate.longitude;
    mapRegion.center.latitude = currentLocation.coordinate.latitude;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    [_mapView setRegion:mapRegion animated: YES];
    
    [self startSearching];*/
    
    
    [locationManager stopUpdatingLocation];
    
}


-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    
    
    NSLog(@"Failed To Get current location");
    
    [locationManager stopUpdatingLocation];
}


-(void)startSearching {

    MKCoordinateRegion mapRegion;
    mapRegion.center.longitude = currentLocation.coordinate.longitude;
    mapRegion.center.latitude = currentLocation.coordinate.latitude;
    mapRegion.span.latitudeDelta = 0.03;
    mapRegion.span.longitudeDelta = 0.03;
    [_mapView setRegion:mapRegion animated: YES];
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[TaxiProxy shardInstance] callTaxiAPIWithLocation:currentLocation];

    });
    
}








- (void) receiveTaxiResponse:(NSNotification*)notification{
    
    if ([[notification name] isEqualToString:@"TaxiResponse"]) {
        
        self.taxiResponseArray = [notification object];
        
        if ([self.taxiResponseArray count] >0) {
            
            [self markMapView];
            
            rightViewOn = YES;
            
            [rightView setHidden:NO];
            
            [rightTableView reloadData];
            
        } else {
            
            
        }
    }
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return [self.taxiResponseArray count];
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaxiRightTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TaxiResponseVO *taxi = [self.taxiResponseArray objectAtIndex:indexPath.row];
    
    cell.taxiNameLabel.text = taxi.name;
    
    cell.taxiAddressLabel.text = taxi.address;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
   TaxiResponseVO *taxi = [self.taxiResponseArray objectAtIndex:indexPath.row];
    
    TaxiDetailViewController *itemDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"TaxiDetail"];
    itemDetail.taxiResponseVO = taxi;
    [self.navigationController pushViewController:itemDetail animated:YES];
    
}




- (void) markMapView {
    
    for (int i = 0; i<[self.taxiResponseArray count]; i++) {
        
        TaxiResponseVO *taxi = [self.taxiResponseArray objectAtIndex:i];
        
        CustomTaxiMKPointAnnotation *myAnnotation = [[CustomTaxiMKPointAnnotation alloc]init];
        myAnnotation.coordinate = CLLocationCoordinate2DMake(taxi.latitude, taxi.longitude);
        myAnnotation.title = taxi.name;
        myAnnotation.subtitle = taxi.address;
        myAnnotation.taxiResponseVO = taxi;
        
        [self.mapView addAnnotation:myAnnotation];
    }
    
    [self zoomToFitMapAnnotations:_mapView];
}


-(void)zoomToFitMapAnnotations:(MKMapView*)aMapView
{
    if([aMapView.annotations count] == 0)
        return;
    
    CLLocationCoordinate2D topLeftCoord;
    topLeftCoord.latitude = -90;
    topLeftCoord.longitude = 180;
    
    CLLocationCoordinate2D bottomRightCoord;
    bottomRightCoord.latitude = 90;
    bottomRightCoord.longitude = -180;
    
    for(CustomTaxiMKPointAnnotation *annotation in _mapView.annotations)
    {
        topLeftCoord.longitude = fmin(topLeftCoord.longitude, annotation.coordinate.longitude);
        topLeftCoord.latitude = fmax(topLeftCoord.latitude, annotation.coordinate.latitude);
        
        bottomRightCoord.longitude = fmax(bottomRightCoord.longitude, annotation.coordinate.longitude);
        bottomRightCoord.latitude = fmin(bottomRightCoord.latitude, annotation.coordinate.latitude);
    }
    
    MKCoordinateRegion region;
    region.center.latitude = topLeftCoord.latitude - (topLeftCoord.latitude - bottomRightCoord.latitude) * 0.7;
    region.center.longitude = topLeftCoord.longitude + (bottomRightCoord.longitude - topLeftCoord.longitude) * 0.7;
    region.span.latitudeDelta = fabs(topLeftCoord.latitude - bottomRightCoord.latitude)*0.5; // Add a little extra space on the sides
    region.span.longitudeDelta = fabs(bottomRightCoord.longitude - topLeftCoord.longitude)*0.5; // Add a little extra space on the sides
    
    region = [aMapView regionThatFits:region];
    [_mapView setRegion:region animated:YES];
}

//-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
//    
//    [self.mapView setCenterCoordinate:userLocation.coordinate animated:YES];
//}


- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>)annotation
{
    
    MKAnnotationView *annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"loc"];
    annotationView.image = [UIImage imageNamed:@"1"];
    annotationView.canShowCallout = YES;
    annotationView.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
    return annotationView;
}

-(void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view
calloutAccessoryControlTapped:(UIControl *)control
{
    CustomTaxiMKPointAnnotation *taxiAnnotation = [[mapView selectedAnnotations] objectAtIndex:0];
    
    TaxiDetailViewController *itemDetail = [self.storyboard instantiateViewControllerWithIdentifier:@"TaxiDetail"];
    itemDetail.taxiResponseVO = taxiAnnotation.taxiResponseVO;
    [self.navigationController pushViewController:itemDetail animated:YES];
    
}

#pragma mark - Button Click Events


-(IBAction)onCallTaxiButtonClicked:(id)sender {
    
    [searchView setHidden:NO];
    
    [callTaxiButton setUserInteractionEnabled:NO];
    
}

-(IBAction)onCancelButtonClicked:(id)sender {
    
    [searchView setHidden:YES];
    
    [callTaxiButton setUserInteractionEnabled:YES];
}

-(IBAction)onSearchButtonClicked:(id)sender {
    
    [searchView setHidden:YES];
    
    [callTaxiButton setUserInteractionEnabled:YES];
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"http://calltaxi.ch/app/taxi/listByGeoLocation.json?latitude=47.376887&longitude=8.541694&distance=10&radius=1000"];
    
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Point to point result:%@",responseObject);
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        
    }];
    
    
}


-(IBAction)onTransPortTypeButtonClicked:(id)sender {
    
    transportTypeView = [[UIView alloc]initWithFrame:CGRectMake(15, 45, 240, 120)];
    
    [transportTypeView setTag:100];
    
    [transportTypeView setBackgroundColor:[UIColor redColor]];
    
    UIButton *pointtoPointButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 240, 40)];
    [pointtoPointButton setTitle:@"Point To Point" forState:UIControlStateNormal];
    
    [pointToPonitView addSubview:transportTypeView];
    
}

- (void)handleTap:(UITapGestureRecognizer *)gestureRecognizer{
    
    NSLog(@"Tapped");
    
    [transportTypeView removeFromSuperview];
    
    
}



-(IBAction)onPointToPointButtonClicked:(id)sender{
    
    
    
    
}

-(IBAction)onAirportTransferButtonClicked:(id)sender{
    
    
}

-(IBAction)onOutstationTranferButtonClicked:(id)sender{
    
    
    
    
}



#pragma mark - UITextField Delegate Methods


- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [ppsourceTextField resignFirstResponder];
    [ppdestinationTextField resignFirstResponder];
    
    return YES;
}

-(IBAction)onNotificationButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
}


-(IBAction)onPromotonButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
    
}


-(IBAction)onFreeRideButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
    
}


-(IBAction)onPaymentButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
    
}


-(IBAction)onHistoryButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
    
}


-(IBAction)onHelpButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
    
}


-(IBAction)onSetingsButtonClicked:(id)sender{
    
    [profileView setHidden:YES];



}

-(IBAction)onLoginRegisterButtonClicked:(id)sender{
    
    [profileView setHidden:YES];
    
    TaxiLoginViewController *taxi = (TaxiLoginViewController*)[self.storyboard instantiateViewControllerWithIdentifier:@"loginRegisterView"];
    [self.navigationController pushViewController:taxi animated:YES];
}

-(IBAction)onRightViewButtonClicked:(id)sender{
    
    if (rightViewOn) {
        
        [rightView setFrame:CGRectMake(rightView.frame.origin.x + 180, rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height)];
        
        rightViewOn = false;
        
        
    } else {
        
        [rightView setFrame:CGRectMake(rightView.frame.origin.x - 180, rightView.frame.origin.y, rightView.frame.size.width, rightView.frame.size.height)];
        
        rightViewOn = YES;
    }
    
    
}








- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
