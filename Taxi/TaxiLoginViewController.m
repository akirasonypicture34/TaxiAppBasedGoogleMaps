//
//  TaxiLoginViewController.m
//  Taxi
//
//  Created by Arul on 11/27/15.
//  Copyright (c) 2015 Daxter. All rights reserved.
//

#import "TaxiLoginViewController.h"

@interface TaxiLoginViewController ()

@end

@implementation TaxiLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRed:241.0 / 255.0 green:241.0 / 255.0 blue:241.0 / 255.0  alpha:1.0]];
    
    [self.navigationItem setTitle:@"Login/Register"];
    
    emailTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    passwordTextField.autocorrectionType = UITextAutocorrectionTypeNo;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    

}

- (void)keyBoardWillShow:(NSNotification *)notification
{
    
    //[passwordView setFrame:CGRectMake(passwordView.frame.origin.x, passwordView.frame.origin.y - 75, passwordView.frame.size.width, passwordView.frame.size.height)];
}

- (void)keyBoardWillHide:(NSNotification *)notification
{
    
    //[passwordView setFrame:CGRectMake(passwordView.frame.origin.x, passwordView.frame.origin.y + 75, passwordView.frame.size.width, passwordView.frame.size.height)];
    
}

-(IBAction)onLoginButtonClicked:(id)sender{
    
    
}

-(IBAction)onRegisterButtonCliked:(id)sender{
    
    
}

-(IBAction)onFaceBookButtonClicked:(id)sender{
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField{
    
    [emailTextField resignFirstResponder];
    [passwordTextField resignFirstResponder];
    
    return YES;
}


- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
