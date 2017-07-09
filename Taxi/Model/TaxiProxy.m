//
//  TaxiProxy.m
//  Taxi
//
//  Created by Arul on 10/29/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import "TaxiProxy.h"
#import "JSONKit.h"

@implementation TaxiProxy

+ (TaxiProxy*) shardInstance{
    
    static TaxiProxy *sharedInstance;
    
    if (sharedInstance == nil) {
        
        sharedInstance = [[TaxiProxy alloc]init];
        
    }
    
    return sharedInstance;
}


- (void) callTaxiAPIWithLocation:(CLLocation *)location {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    [manager POST:@"http://calltaxi.ch/app/taxi/listByGeoLocation.json?latitude=47.376887&longitude=8.541694&distance=10&radius=1000" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        taxiResponseArray = [[NSMutableArray alloc]init];
        
        //NSLog(@"JSON: %@", responseObject);
        
        if ([responseObject count] > 0) {
            
            for (int i=0; i<[responseObject count]; i++) {
                
                NSDictionary *dictionary = [responseObject objectAtIndex:i];
                
                TaxiResponseVO *taxi = [[TaxiResponseVO alloc]init];
                
                if ([dictionary valueForKey:@"acVehicle"]!=nil) {
                    
//                      common acvehicle
                    taxi.acVehicle = [dictionary valueForKey:@"acVehicle"];
                    
                } else {
                    
                     taxi.acVehicle = @"";
                }
                
                
                if ([dictionary valueForKey:@"address"]!=nil) {
                    
                   taxi.address = [dictionary valueForKey:@"address"];
                    
                } else {
                    
                   taxi.address  = @"";
                }
               
                
                if ([dictionary valueForKey:@"blobkey"]!=nil ) {
                    
                    taxi.blobkey = [dictionary valueForKey:@"blobkey"];
                    
                } else {
                    
                   taxi.blobkey  = @"";
                }
                
                if ([dictionary valueForKey:@"cartype"]!=nil ) {
                    
                     taxi.cartype = [dictionary valueForKey:@"cartype"];
                    
                } else {
                    
                    taxi.cartype  = @"";
                }
                
                if ([dictionary valueForKey:@"currency"]!=nil) {
                    
                   taxi.currency = [dictionary valueForKey:@"currency"];
                    
                } else {
                    
                    taxi.currency   = @"";
                }
                
                
                if ([dictionary valueForKey:@"description"]!=nil ) {
                    
                     taxi.taxDescription = [dictionary valueForKey:@"description"];
                    
                } else {
                    
                    taxi.taxDescription   = @"";
                }
                
               
                if ([dictionary valueForKey:@"dropOffLocation"]!=nil) {
                    
                    taxi.dropOffLocation = [dictionary valueForKey:@"dropOffLocation"];
                    
                } else {
                    
                    taxi.dropOffLocation   = @"";
                }
                
                
               
                if ([dictionary valueForKey:@"id"]!=nil) {
                    
                   taxi.taId = [dictionary valueForKey:@"id"];
                    
                } else {
                    
                   taxi.taId   = @"";
                }
                
               
                
                if ([dictionary valueForKey:@"imageUrl"]!=nil) {
                    
                    taxi.imageUrl = [dictionary valueForKey:@"imageUrl"];
                    
                } else {
                    
                    taxi.imageUrl  = @"";
                }
                
                
                taxi.latitude = [[dictionary valueForKey:@"latitude"] floatValue];
                    
                taxi.longitude = [[dictionary valueForKey:@"longitude"] floatValue];
                
                
                if ([dictionary valueForKey:@"name"]!=nil) {
                    
                    taxi.name = [dictionary valueForKey:@"name"];

                    
                } else {
                    
                    taxi.name  = @"";
                }

                taxi.phoneNumber = [[dictionary valueForKey:@"phoneNumber"] integerValue];
                
                
                if ([dictionary valueForKey:@"pickUpLocation"]!=nil) {
                    
                    taxi.pickUpLocation = [dictionary valueForKey:@"pickUpLocation"];
                    
                    
                } else {
                    
                    taxi.pickUpLocation  = @"";
                }
                
                
                taxi.price = [[dictionary valueForKey:@"price"] floatValue];
                
                if ([dictionary valueForKey:@"starRating"]!=nil) {
                    
                   taxi.starRating = [dictionary valueForKey:@"starRating"];
                    
                } else {
                    
                    taxi.starRating   = @"";
                }
                
                if ([dictionary valueForKey:@"supplierId"]!=nil) {
                    
                    taxi.supplierId = [dictionary valueForKey:@"supplierId"];
                    
                } else {
                    
                    taxi.supplierId    = @"";
                }
                
                
                if ([dictionary valueForKey:@"transporttype"]!=nil ) {
                    
                    taxi.transporttype = [dictionary valueForKey:@"transporttype"];
                    
                } else {
                    
                    taxi.transporttype    = @"";
                }
                
                
                taxi.type = [[dictionary valueForKey:@"type"] integerValue];
                
                
                if ([dictionary valueForKey:@"website"]!=nil) {
                    
                    taxi.website = [dictionary valueForKey:@"website"];
                    
                } else {
                    
                    taxi.website  = @"";
                }
                
                [taxiResponseArray addObject:taxi];
                
            }
            
        }
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TaxiResponse" object:taxiResponseArray];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"TaxiResponse" object:nil];
        
        
    }];
    
}



- (void) callToGetIndividualTaxiDetailsWithTaxiID:(NSString*)taxiID {
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *urlString = [NSString stringWithFormat:@"http://calltaxi.ch/api/v3/taxi/%@/details.json?apikey=274ae1604034be8d2b4296a9c64b5b6e",taxiID];
    
    [manager POST:urlString parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Taxi Details:%@",responseObject);
        
        
        TaxiDetailsVO *taxiDetailsVO = [[TaxiDetailsVO alloc]init];
        
        
        if ([responseObject count] > 0) {
            
            
            if ([responseObject valueForKey:@"acVehicle"]!=nil && ![[responseObject valueForKey:@"acVehicle"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.acVehicle = [responseObject valueForKey:@"acVehicle"];
                
            } else {
                
                taxiDetailsVO.acVehicle = @"";
            }
            
            
            if ([responseObject valueForKey:@"active"]!=nil && ![[responseObject valueForKey:@"active"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.active = [responseObject valueForKey:@"active"];
                
            } else {
                
                taxiDetailsVO.active = @"";
            }
            
            
            if ([responseObject valueForKey:@"additionalInformation"]!=nil && ![[responseObject valueForKey:@"additionalInformation"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.additionalInformation = [responseObject valueForKey:@"additionalInformation"];
                
            } else {
                
                taxiDetailsVO.additionalInformation = @"";
            }
            
            
            if ([responseObject valueForKey:@"cancellationPolicy"]!=nil && ![[responseObject valueForKey:@"cancellationPolicy"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.cancellationPolicy = [[responseObject valueForKey:@"cancellationPolicy"] boolValue];
                
            } else {
                
                taxiDetailsVO.cancellationPolicy = NO;
            }

            
            
            if ([responseObject valueForKey:@"cartype"]!=nil && ![[responseObject valueForKey:@"cartype"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.cartype = [responseObject valueForKey:@"cartype"] ;
                
            } else {
                
                taxiDetailsVO.cartype = @"";
            }
            
            
            if ([responseObject valueForKey:@"cityDTO"]!=nil && ![[responseObject valueForKey:@"cityDTO"] isKindOfClass:[NSNull class]]) {
                
                
                NSDictionary *dictionary = [responseObject valueForKey:@"cityDTO"];
                
                TaxicityDTOVO *taxiCityDTOVO = [[TaxicityDTOVO alloc]init];
                
                if ([dictionary valueForKey:@"active"]!=nil && ![[dictionary valueForKey:@"active"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.active = [dictionary valueForKey:@"active"];
                    
                } else {
                    
                    taxiCityDTOVO.active = @"";
                }
                
                
                if ([dictionary valueForKey:@"cityCode"]!=nil && ![[dictionary valueForKey:@"cityCode"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.cityCode = [dictionary valueForKey:@"cityCode"];
                    
                } else {
                    
                    taxiCityDTOVO.cityCode = @"";
                }
                
                
                if ([dictionary valueForKey:@"cityName"]!=nil && ![[dictionary valueForKey:@"cityName"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.cityName = [dictionary valueForKey:@"cityName"];
                    
                } else {
                    
                    taxiCityDTOVO.cityName = @"";
                }
                
                if ([dictionary valueForKey:@"countryDTO"]!=nil && ![[dictionary valueForKey:@"countryDTO"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.countryDTO = [dictionary valueForKey:@"countryDTO"];
                    
                } else {
                    
                    taxiCityDTOVO.countryDTO = @"";
                }
                
                if ([dictionary valueForKey:@"id"]!=nil && ![[dictionary valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.cityID = [dictionary valueForKey:@"id"];
                    
                } else {
                    
                    taxiCityDTOVO.cityID = @"";
                }
                
                if ([dictionary valueForKey:@"regions"]!=nil && ![[dictionary valueForKey:@"regions"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.regions = [dictionary valueForKey:@"regions"];
                    
                } else {
                    
                    taxiCityDTOVO.regions = @"";
                }
                
                if ([dictionary valueForKey:@"updatedOn"]!=nil && ![[dictionary valueForKey:@"updatedOn"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCityDTOVO.updatedOn = [dictionary valueForKey:@"updatedOn"];
                    
                } else {
                    
                    taxiCityDTOVO.updatedOn = @"";
                }
                
                [taxiDetailsVO setTaxicityDTOVO:taxiCityDTOVO];
                
            }
            
            
            if ([responseObject valueForKey:@"countryDTO"]!=nil && ![[responseObject valueForKey:@"countryDTO"] isKindOfClass:[NSNull class]]) {
                
                TaxicountryDTOVO *taxiCountryDTOVO = [[TaxicountryDTOVO alloc]init];
                
                NSDictionary *dicionary = [responseObject valueForKey:@"countryDTO"];
                
                if ([dicionary valueForKey:@"active"]!=nil && ![[dicionary valueForKey:@"active"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCountryDTOVO.active = [dicionary valueForKey:@"active"];
                    
                } else {
                    
                    taxiCountryDTOVO.active = @"";
                }
                
                
                if ([dicionary valueForKey:@"cities"]!=nil && ![[dicionary valueForKey:@"cities"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCountryDTOVO.cities = [dicionary valueForKey:@"cities"];
                    
                } else {
                    
                    taxiCountryDTOVO.cities = @"";
                }
                
                
                if ([dicionary valueForKey:@"countryCode"]!=nil && ![[dicionary valueForKey:@"countryCode"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCountryDTOVO.countryCode = [dicionary valueForKey:@"countryCode"];
                    
                } else {
                    
                    taxiCountryDTOVO.countryCode = @"";
                }
                
                if ([dicionary valueForKey:@"countryName"]!=nil && ![[dicionary valueForKey:@"countryName"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCountryDTOVO.countryName = [dicionary valueForKey:@"countryName"];
                    
                } else {
                    
                    taxiCountryDTOVO.countryName = @"";
                }
                
                
                if ([dicionary valueForKey:@"id"]!=nil && ![[dicionary valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCountryDTOVO.countryID = [[dicionary valueForKey:@"id"] integerValue];
                    
                } else {
                    
                    taxiCountryDTOVO.countryID = 0;
                }
                
                if ([dicionary valueForKey:@"updatedOn"]!=nil && ![[dicionary valueForKey:@"updatedOn"] isKindOfClass:[NSNull class]]) {
                    
                    taxiCountryDTOVO.updatedOn = [dicionary valueForKey:@"updatedOn"];
                    
                } else {
                    
                    taxiCountryDTOVO.updatedOn = @"";
                }
                
                
                [taxiDetailsVO setTaxicountryDTOVO:taxiCountryDTOVO];
                
            }
            
            
            if ([responseObject valueForKey:@"currency"]!=nil && ![[responseObject valueForKey:@"currency"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.currency = [responseObject valueForKey:@"currency"];
                
            } else {
                
                taxiDetailsVO.currency = @"";
            }
            
            
            if ([responseObject valueForKey:@"description"]!=nil && ![[responseObject valueForKey:@"description"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.taxiDescription = [responseObject valueForKey:@"description"];
                
            } else {
                
                taxiDetailsVO.taxiDescription = @"";
            }
            
            if ([responseObject valueForKey:@"destination"]!=nil && ![[responseObject valueForKey:@"destination"] isKindOfClass:[NSNull class]]) {
                
                
                TaxiDestinationVO *destinationVO = [[TaxiDestinationVO alloc]init];
                
                NSDictionary *dictionary = [responseObject valueForKey:@"destination"];
                
                if ([dictionary valueForKey:@"active"]!=nil && ![[dictionary valueForKey:@"active"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.active = [dictionary valueForKey:@"active"];
                    
                } else {
                    
                    destinationVO.active  = @"";
                }
                
                if ([dictionary valueForKey:@"cityDTO"]!=nil && ![[dictionary valueForKey:@"cityDTO"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.cityDTO = [dictionary valueForKey:@"cityDTO"];
                    
                } else {
                    
                    destinationVO.cityDTO  = @"";
                }
                
                
                if ([dictionary valueForKey:@"id"]!=nil && ![[dictionary valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.destinationID = [[dictionary valueForKey:@"id"] integerValue];
                    
                } else {
                    
                    destinationVO.destinationID  = 0;
                }
                
                
                if ([dictionary valueForKey:@"regionAddress"]!=nil && ![[dictionary valueForKey:@"regionAddress"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.regionAddress = [dictionary valueForKey:@"regionAddress"];
                    
                } else {
                    
                    destinationVO.regionAddress  = @"";
                }
                
                
                if ([dictionary valueForKey:@"regionCode"]!=nil && ![[dictionary valueForKey:@"regionCode"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.regionCode = [dictionary valueForKey:@"regionCode"];
                    
                } else {
                    
                    destinationVO.regionCode  = @"";
                }
                
                
                if ([dictionary valueForKey:@"regionName"]!=nil && ![[dictionary valueForKey:@"regionName"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.regionName = [dictionary valueForKey:@"regionName"];
                    
                } else {
                    
                    destinationVO.regionName  = @"";
                }
                
                if ([dictionary valueForKey:@"regiontype"]!=nil && ![[dictionary valueForKey:@"regiontype"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.regiontype = [dictionary valueForKey:@"regiontype"];
                    
                } else {
                    
                    destinationVO.regiontype  = @"";
                }
                
                if ([dictionary valueForKey:@"updatedOn"]!=nil && ![[dictionary valueForKey:@"updatedOn"] isKindOfClass:[NSNull class]]) {
                    
                    destinationVO.updatedOn = [dictionary valueForKey:@"updatedOn"];
                    
                } else {
                    
                    destinationVO.updatedOn  = @"";
                }
             
                [taxiDetailsVO setTaxiDestinationVO:destinationVO];
                
            }
            
            
            if ([responseObject valueForKey:@"dropOffLocation"]!=nil && ![[responseObject valueForKey:@"dropOffLocation"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.dropOffLocation = [responseObject valueForKey:@"dropOffLocation"];
                
            } else {
                
                taxiDetailsVO.dropOffLocation = @"";
            }
            
            
            if ([responseObject valueForKey:@"id"]!=nil && ![[responseObject valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.taxiID = [[responseObject valueForKey:@"id"] integerValue];
                
            } else {
                
                taxiDetailsVO.taxiID = 0;
            }
            
            if ([responseObject valueForKey:@"latitude"]!=nil && ![[responseObject valueForKey:@"latitude" ] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.latitude = [[responseObject valueForKey:@"latitude"]floatValue];
                
            } else {
                
                taxiDetailsVO.latitude = 0;
            }
            
            if ([responseObject valueForKey:@"longitude"]!=nil && ![[responseObject valueForKey:@"longitude" ] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.longitude = [[responseObject valueForKey:@"longitude"]floatValue];
                
            } else {
                
                taxiDetailsVO.longitude = 0;
                
            }
            
            if ([responseObject valueForKey:@"maxLuggageCapacity"]!=nil && ![[responseObject valueForKey:@"maxLuggageCapacity"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.maxLuggageCapacity = [[responseObject valueForKey:@"maxLuggageCapacity"]integerValue];
                
            } else {
                
                taxiDetailsVO.maxLuggageCapacity = 0;
                
            }
            
            if ([responseObject valueForKey:@"maxPassengerCapacity"]!=nil && ![[responseObject valueForKey:@"maxPassengerCapacity"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.maxPassengerCapacity = [[responseObject valueForKey:@"maxPassengerCapacity"]integerValue];
                
            } else {
                
                taxiDetailsVO.maxPassengerCapacity = 0;
                
            }
            
            if ([responseObject valueForKey:@"meetingPoint"]!=nil && ![[responseObject valueForKey:@"meetingPoint"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.meetingPoint = [responseObject valueForKey:@"meetingPoint"];
                
            } else {
                
                taxiDetailsVO.meetingPoint = @"";
                
            }
            
            if ([responseObject valueForKey:@"name"]!=nil && ![[responseObject valueForKey:@"name"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.name = [responseObject valueForKey:@"name"];
                
            } else {
                
                taxiDetailsVO.name = @"";
                
            }

            if ([responseObject valueForKey:@"pickUpLocation"]!=nil && ![[responseObject valueForKey:@"pickUpLocation"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.pickUpLocation = [responseObject valueForKey:@"pickUpLocation"];
                
            } else {
                
                taxiDetailsVO.pickUpLocation = @"";
                
            }
            
            if ([responseObject valueForKey:@"price"]!=nil && ![[responseObject valueForKey:@"price"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.price = [[responseObject valueForKey:@"price"] integerValue];
                
            } else {
                
                taxiDetailsVO.price = 0;
            }

            

            if ([responseObject valueForKey:@"source"]!=nil && ![[responseObject valueForKey:@"source"] isKindOfClass:[NSNull class]]) {
                
                
                TaxiSourceVO *sourceVO = [[TaxiSourceVO alloc]init];
                
                NSDictionary *dicionary = [responseObject valueForKey:@"source"];
                
                if ([dicionary valueForKey:@"active"]!=nil && ![[dicionary valueForKey:@"active"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.active = [dicionary valueForKey:@"active"];
                    
                } else {
                    
                    sourceVO.active = @"";
                }
                
                if ([dicionary valueForKey:@"cityDTO"]!=nil && ![[dicionary valueForKey:@"cityDTO"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.cityDTO = [dicionary valueForKey:@"cityDTO"];
                    
                } else {
                    
                    sourceVO.cityDTO = @"";
                }
                
                if ([dicionary valueForKey:@"id"]!=nil && ![[dicionary valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.sourceID = [[dicionary valueForKey:@"id"] integerValue];
                    
                } else {
                    
                    sourceVO.sourceID = 0;
                }
                
                if ([dicionary valueForKey:@"regionAddress"]!=nil && ![[dicionary valueForKey:@"regionAddress"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.regionAddress = [dicionary valueForKey:@"regionAddress"];
                    
                } else {
                    
                    sourceVO.regionAddress = @"";
                }
                
                
                if ([dicionary valueForKey:@"regionCode"]!=nil && ![[dicionary valueForKey:@"regionCode"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.regionCode = [dicionary valueForKey:@"regionCode"];
                    
                } else {
                    
                    sourceVO.regionCode = @"";
                }
                
                
                if ([dicionary valueForKey:@"regionName"]!=nil && ![[dicionary valueForKey:@"regionName"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.regionName = [dicionary valueForKey:@"regionName"];
                    
                } else {
                    
                    sourceVO.regionName = @"";
                }
                
                if ([dicionary valueForKey:@"regiontype"]!=nil && ![[dicionary valueForKey:@"regiontype"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.regiontype = [dicionary valueForKey:@"regiontype"];
                    
                } else {
                    
                    sourceVO.regiontype = @"";
                }
                
                if ([dicionary valueForKey:@"updatedOn"]!=nil && ![[dicionary valueForKey:@"updatedOn"] isKindOfClass:[NSNull class]]) {
                    
                    sourceVO.updatedOn = [dicionary valueForKey:@"updatedOn"];
                    
                } else {
                    
                    sourceVO.updatedOn = @"";
                }
                
                [taxiDetailsVO setTaxiSourceVO:sourceVO];
            }
            
            
            if ([responseObject valueForKey:@"starRating"]!=nil && ![[responseObject valueForKey:@"starRating"] isKindOfClass:[NSNull class]]) {
                
                taxiDetailsVO.starRating = [responseObject valueForKey:@"starRating"];
                
            } else {
                
                taxiDetailsVO.starRating = @"";
            }
            
            
            if ([responseObject valueForKey:@"supplierDTO"]!=nil && ![[responseObject valueForKey:@"supplierDTO"] isKindOfClass:[NSNull class]]) {
            
                
                TaxisupplierDTOVO *supplierVO = [[TaxisupplierDTOVO alloc]init];
                
                NSDictionary *dictionary = [responseObject valueForKey:@"supplierDTO"];
                
                if ([dictionary valueForKey:@"address"]!=nil  && ![[dictionary valueForKey:@"address"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.address = [dictionary valueForKey:@"address"];
                    
                } else {
                    
                    supplierVO.address = @"";
                }
                
                if ([dictionary valueForKey:@"id"]!=nil && ![[dictionary valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.supplierID = [[dictionary valueForKey:@"id"] integerValue];
                    
                } else {
                    
                    supplierVO.supplierID = 0;
                }
                
                
                if ([dictionary valueForKey:@"latitude"]!=nil && ![[dictionary valueForKey:@"latitude" ] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.latitude = [[dictionary valueForKey:@"latitude"] floatValue];
                    
                } else {
                    
                    supplierVO.latitude = 0;
                }
                
                
                if ([dictionary valueForKey:@"longitude"]!=nil && ![[dictionary valueForKey:@"longitude" ] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.longitude = [[dictionary valueForKey:@"longitude"] floatValue];
                    
                } else {
                    
                    supplierVO.longitude = 0;
                }
                
                
                if ([dictionary valueForKey:@"licenseNumber"]!=nil && ![[dictionary valueForKey:@"licenseNumber"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.licenseNumber = [[dictionary valueForKey:@"licenseNumber"] integerValue];
                    
                } else {
                    
                    supplierVO.licenseNumber = 0;
                }
                
                if ([dictionary valueForKey:@"name"]!=nil && ![[dictionary valueForKey:@"name"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.name = [dictionary valueForKey:@"name"];
                    
                } else {
                    
                    supplierVO.name = @"";
                }
                
                if ([dictionary valueForKey:@"phoneNumber"]!=nil && ![[dictionary valueForKey:@"phoneNumber"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.phoneNumber = [[dictionary valueForKey:@"phoneNumber"] integerValue];
                    
                } else {
                    
                    supplierVO.phoneNumber = 0;
                }
                
                if ([dictionary valueForKey:@"profilePictureBlobkey"]!=nil && ![[dictionary valueForKey:@"profilePictureBlobkey"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.profilePictureBlobkey = [dictionary valueForKey:@"profilePictureBlobkey"];
                    
                } else {
                    
                    supplierVO.profilePictureBlobkey = @"";
                }
                
                
                if ([dictionary valueForKey:@"profilePictureUrl"]!=nil && ![[dictionary valueForKey:@"profilePictureUrl"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.profilePictureUrl = [dictionary valueForKey:@"profilePictureUrl"];
                    
                } else {
                    
                    supplierVO.profilePictureUrl = @"";
                }
                
                
                if ([dictionary valueForKey:@"website"]!=nil && ![[dictionary valueForKey:@"website"] isKindOfClass:[NSNull class]]) {
                    
                    supplierVO.website = [dictionary valueForKey:@"website"];
                    
                } else {
                    
                    supplierVO.website = @"";
                }
                
                
                if ([dictionary valueForKey:@"userDTO"]!=nil && ![[dictionary valueForKey:@"userDTO"] isKindOfClass:[NSNull class]]) {
                    
                    
                    TaxiuserDTOVO *userVO = [[TaxiuserDTOVO alloc]init];
                    
                    NSDictionary *dic =  [dictionary valueForKey:@"userDTO"];
                    
                    if ([dic valueForKey:@"email"]!=nil && ![[dic valueForKey:@"email"] isKindOfClass:[NSNull class]]) {
                        
                        userVO.email = [dic valueForKey:@"email"];
                        
                    } else {
                        
                        userVO.email = @"";
                    }
                    
                    
                    if ([dic valueForKey:@"firstName"]!=nil && ![[dic valueForKey:@"firstName"] isKindOfClass:[NSNull class]]) {
                        
                        userVO.firstName = [dic valueForKey:@"firstName"];
                        
                    } else {
                        
                        userVO.firstName = @"";
                    }
                    
                    
                    if ([dic valueForKey:@"lastName"]!=nil && ![[dic valueForKey:@"lastName"] isKindOfClass:[NSNull class]]) {
                        
                        userVO.lastName = [dic valueForKey:@"lastName"];
                        
                    } else {
                        
                        userVO.lastName = @"";
                    }
                    
                    if ([dic valueForKey:@"isSocialUser"]!=nil && ![[dic valueForKey:@"isSocialUser"] isKindOfClass:[NSNull class]]) {
                        
                        userVO.isSocialUser = [dic valueForKey:@"isSocialUser"];
                        
                    } else {
                        
                        userVO.isSocialUser = @"";
                    }
                    
                    if ([dic valueForKey:@"id"]!=nil && ![[dic valueForKey:@"id"] isKindOfClass:[NSNull class]]) {
                        
                        userVO.userID = [[dic valueForKey:@"id"] integerValue];
                        
                    } else {
                        
                        userVO.userID = 0;
                    }
                    
                    [supplierVO setTaxiuserDTOVO:userVO];
                    
                    [taxiDetailsVO setTaxiSupplierDTOVO:supplierVO];
                    
                }
                
                
                if ([responseObject valueForKey:@"transporttype"]!=nil && ![[responseObject valueForKey:@"transporttype"] isKindOfClass:[NSNull class]]) {
                    
                    taxiDetailsVO.transporttype = [responseObject valueForKey:@"transporttype"];
                    
                } else {
                    
                    taxiDetailsVO.transporttype = @"";
                }
                
                if ([responseObject valueForKey:@"updatedOn"]!=nil && ![[responseObject valueForKey:@"updatedOn"] isKindOfClass:[NSNull class]]) {
                    
                    taxiDetailsVO.updatedOn = [responseObject valueForKey:@"updatedOn"];
                    
                } else {
                    
                    taxiDetailsVO.updatedOn = @"";
                }

            }
            
           [[NSNotificationCenter defaultCenter] postNotificationName:@"IndividualTaxiResponse" object:taxiDetailsVO];
            
        } else {
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"IndividualTaxiResponse" object:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        NSLog(@"Error: %@", error);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"IndividualTaxiResponse" object:nil];
        
    }];
}


- (void) callToGetReviewWithTaxiID:(NSString*)taxiID{
    
    NSURL *URL = [NSURL URLWithString:@"http://calltaxi.ch/app/review/listByTaxiId.json?apikey=274ae1604034be8d2b4296a9c64b5b6e"];
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                                taxiID,@"taxiId", nil];
    
    NSString *myJSONString = [dictionary JSONStringWithOptions:JKSerializeOptionNone error:nil];
    NSData *myJSONData =[myJSONString dataUsingEncoding:NSUTF8StringEncoding];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:URL];
    [request setHTTPBody:myJSONData];
    [request setHTTPMethod:@"POST"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:[NSOperationQueue mainQueue]
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError *error) {
                               
                            NSDictionary* json = [NSJSONSerialization JSONObjectWithData:data
                                                                                    options:kNilOptions
                                                                                      error:&error];
                               
                               
                            NSArray *array = [json valueForKey:@"items"];
                               
                            reviewResponseArray = [[NSMutableArray alloc]init];
                               
                               for (int i = 0; i<[array count];i++) {
                                
                                NSDictionary *dic = [array objectAtIndex:i];
                                
                                TaxiReviewVO *reviewVO = [[TaxiReviewVO alloc]init];
                                
                                if ([dic valueForKey:@"comment"]!=nil) {
                                    
                                    reviewVO.comment = [dic valueForKey:@"comment"];
                                    
                                } else {
                                    
                                    reviewVO.comment = @"";
                                }
                                
                                if ([dic valueForKey:@"formattedDate"]!=nil) {
                                    
                                    reviewVO.formattedDate = [dic valueForKey:@"formattedDate"];
                                    
                                } else {
                                    
                                    reviewVO.formattedDate = @"";
                                }
                                
                                if ([dic valueForKey:@"id"]!=nil) {
                                    
                                    reviewVO.commentId = [dic valueForKey:@"id"];
                                    
                                } else {
                                    
                                    reviewVO.commentId = @"";
                                }
                                
                                if ([dic valueForKey:@"rating"]!=nil) {
                                    
                                    reviewVO.rating = [dic valueForKey:@"rating"];
                                    
                                } else {
                                    
                                    reviewVO.rating = @"";
                                }
                                
                                if ([dic valueForKey:@"taxiId"]!=nil) {
                                    
                                    reviewVO.taxiId = [dic valueForKey:@"taxiId"];
                                    
                                } else {
                                    
                                    reviewVO.taxiId = @"";
                                }
                                
                                if ([dic valueForKey:@"updatedOn"]!=nil) {
                                    
                                    reviewVO.updateDate = [dic valueForKey:@"updatedOn"];
                                    
                                } else {
                                    
                                    reviewVO.updateDate = @"";
                                }
                                
                                if ([dic valueForKey:@"userEmail"]!=nil) {
                                    
                                    reviewVO.userEmail = [dic valueForKey:@"userEmail"];
                                    
                                } else {
                                    
                                    reviewVO.userEmail = @"";
                                }
                                
                                if ([dic valueForKey:@"userFullName"]!=nil) {
                                    
                                    reviewVO.userFullName = [dic valueForKey:@"userFullName"];
                                    
                                } else {
                                    
                                    reviewVO.userFullName = @"";
                                }
                                
                                
                                [reviewResponseArray addObject:reviewVO];
                                
                                   
                            }
                               
                               
                            [[NSNotificationCenter defaultCenter] postNotificationName:@"ReviewTaxiResponse" object:reviewResponseArray];
                               
                           }];
    
}

@end
