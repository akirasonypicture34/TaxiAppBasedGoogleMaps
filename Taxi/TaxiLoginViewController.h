//
//  TaxiLoginViewController.h
//  Taxi
//
//  Created by Arul on 11/27/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaxiLoginViewController : UIViewController<UITextFieldDelegate>{
    
    
    IBOutlet UIView *emailView;
    
    IBOutlet UIView *passwordView;
    
    IBOutlet UITextField *emailTextField;
    
    IBOutlet UITextField *passwordTextField;
    
    IBOutlet UIButton *loginButton;
    
    IBOutlet UIButton *registerButton;
    
    IBOutlet UIButton *faceBookButton;
    
    
}

-(IBAction)onLoginButtonClicked:(id)sender;

-(IBAction)onRegisterButtonCliked:(id)sender;

-(IBAction)onFaceBookButtonClicked:(id)sender;

@end
