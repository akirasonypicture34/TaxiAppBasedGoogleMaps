//
//  TaxiDetailViewController.m
//  Taxi
//
//  Created by Arul on 10/30/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import "TaxiDetailViewController.h"

@interface TaxiDetailViewController ()

@end

@implementation TaxiDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationController.navigationBar.hidden =YES;
    
    [taxiImageView setBackgroundColor:[UIColor whiteColor]];
    
    taxiImageView.layer.cornerRadius = taxiImageView.frame.size.width / 2.0;
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"IndividualTaxiResponse" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveIndividualTaxiResponse:)
                                                 name:@"IndividualTaxiResponse"
                                               object:nil];
    
    
    
    [[NSNotificationCenter defaultCenter]removeObserver:self name:@"ReviewTaxiResponse" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(receiveReviewTaxiResponse:)
                                                 name:@"ReviewTaxiResponse"
                                               object:nil];
    
    
    if (self.taxiResponseVO.taId!=nil) {
        
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            
            [[TaxiProxy shardInstance] callToGetIndividualTaxiDetailsWithTaxiID:self.taxiResponseVO.taId];
            
        });
    } else {
        
        NSLog(@"Taxi ID Not Available");
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        [[TaxiProxy shardInstance] callToGetReviewWithTaxiID:self.taxiResponseVO.taId];
        
    });
}


-(void) receiveIndividualTaxiResponse:(NSNotification*)notification {
    
    if ([[notification name] isEqualToString:@"IndividualTaxiResponse"]) {
        
        taxiDetailsVO = [notification object];
        
        if (taxiDetailsVO!=nil) {
            
            
            [taxiNameLabel setText:self.taxiResponseVO.name];
            [taxiWebSiteLabel setText:taxiDetailsVO.taxiSupplierDTOVO.website];
            [taxiAddressLabel setText:taxiDetailsVO.taxiSourceVO.regionAddress];
            
            
            
            [self loadDetailsView];
            
        } else {
            
            [activityIndicator stopAnimating];
            
            NSLog(@"Taxi detail not available");
            
        }
    }
}


-(void) receiveReviewTaxiResponse:(NSNotification*)notification {
    
    if ([[notification name] isEqualToString:@"ReviewTaxiResponse"]) {
    
        self.reviewArray = [notification object];
    
        [taxiReviewTableView reloadData];
    }
}



-(void) loadDetailsView {
    
    [activityIndicator stopAnimating];
    
    NSString *staticMapUrl = [NSString stringWithFormat:@"http://maps.google.com/maps/api/staticmap?markers=color:red|%f,%f&%@&sensor=true",taxiDetailsVO.latitude, taxiDetailsVO.longitude,@"zoom=10&size=270x70"];
    NSURL *mapUrl = [NSURL URLWithString:[staticMapUrl stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    UIImage *image = [UIImage imageWithData: [NSData dataWithContentsOfURL:mapUrl]];
    
    [mapImageView setImage:image];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    
    return self.reviewArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    TaxiReviewTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    TaxiReviewVO *reviewVO = [self.reviewArray objectAtIndex:indexPath.row];
    
    [cell.reviewDateLabel setText:reviewVO.formattedDate];
    
    [cell.reviewDescriptionLabel setText:reviewVO.comment];;
    
    return cell;
}


#pragma mark - Button Click Events


-(void)barButtonBackPressed:(id)sender{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}


-(IBAction)onTaxiBookNowButtonClicked:(id)sender{
    
    
}


-(IBAction)onTaxiPhoneButtonClicked:(id)sender{
    
    
}


-(IBAction)onTaxiWhatsUpButtonClicked:(id)sender{
    
}


-(IBAction)onTaxiBookButtonClicked:(id)sender{
    
    
    
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
