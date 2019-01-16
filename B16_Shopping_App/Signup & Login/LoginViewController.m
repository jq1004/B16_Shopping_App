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
    _forgetPasswrodBtn.layer.cornerRadius = 5;
}

- (IBAction)login:(id)sender {
    NSString *phone = _phoneText.text;
    NSString *pwd = _password.text;
    
    if (![phone isEqual:@""] && ![pwd isEqual:@""]) {
        [[APIHandler sharedInstance] loginApiCall:phone password:pwd withCompletion:^(NSData* result, NSError* error) {
            [[APIParser sharedInstance] loginParser:result andError:error withCompletion:^(Boolean *hasError) {
                if (hasError) {
                    [self showAlert:@"Login Failed" andMsg:@"Please try again later."];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Some problem occured. Please try again later!" type: TWMessageBarMessageTypeError duration:5];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Success" description:@"Logged in successfully" type: TWMessageBarMessageTypeSuccess duration:5];
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        SWRevealViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealVC"];
                        
                        [self presentViewController:controller animated:true completion:nil];
                    });
                }
            }];
        }];
    } else {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Please fill in all required fields!" type: TWMessageBarMessageTypeError duration:5];
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
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Success" description:@"A password reset email have been sent successfully!" type: TWMessageBarMessageTypeSuccess duration:5];
        } else {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Something went wrong, Please try again later!" type: TWMessageBarMessageTypeError duration:5];
        }
    }];
}

@end
