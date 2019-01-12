//
//  LoginViewController.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "LoginViewController.h"
#import "APIHandler.h"
#import "APIParser.h"
#import "SignUpViewController.h"
#import "SWRevealViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)setupUI {
    _loginBtn.layer.cornerRadius = 5;
    _goToSignUpPageBtn.layer.cornerRadius = 5;
    _goToSignUpPageBtn.layer.borderWidth = 1;
    _goToSignUpPageBtn.layer.borderColor = [UIColor colorWithRed:1.00 green:0.23 blue:0.82 alpha:1.0].CGColor;
}

- (IBAction)login:(id)sender {
    NSString *phone = _phoneText.text;
    NSString *pwd = _password.text;
    
    if (![phone isEqual:@""] && ![pwd isEqual:@""]) {
        [[APIHandler sharedInstance] loginApiCall:phone password:pwd withCompletion:^(NSData* result, NSError* error) {
            [[APIParser sharedInstance] loginParser:result andError:error withCompletion:^(Boolean *hasError) {
                if (hasError) {
                    [self showAlert:@"Login Failed" andMsg:@"Please try again later."];
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        SWRevealViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealVC"];
                        
                        [self presentViewController:controller animated:true completion:nil];
                    });
                }
            }];
        }];
    } else {
        [self showAlert:@"Oops" andMsg:@"Please fill in all reauired fields."];
    }
}

- (IBAction)goToSignUpPageBtnTapped:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignUpViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    
    [self presentViewController:controller animated:true completion:nil];
}

- (IBAction)forgotPwdBtnTapped:(id)sender {
    NSString *phone = _phoneText.text;
    [[APIHandler sharedInstance] forgetPwdApiCall:phone withCompletion:^(NSError *error) {
        if (error == nil) {
            [self showAlert:@"Success" andMsg:@"We have sent an password reset email for you."];
        } else {
            [self showAlert:@"Failed" andMsg:@"Something went wrong, please try again later."];
        }
    }];
}

@end
