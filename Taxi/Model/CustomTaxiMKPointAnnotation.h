//
//  CustomTaxiMKPointAnnotation.h
//  Taxi
//
//  Created by Arul on 10/30/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <MapKit/MapKit.h>
#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "TaxiResponseVO.h"

@interface CustomTaxiMKPointAnnotation : MKPointAnnotation

@property(nonatomic,retain) TaxiResponseVO *taxiResponseVO;

@end
