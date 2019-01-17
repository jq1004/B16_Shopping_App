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
            [[APIParser sharedInstance] loginParser:result andError:error withCompletion:^(bool hasError, NSString *errorMsg) {
                if (hasError) {
//                    [self showAlert:LOGINFAILURE andMsg:errorMsg];
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[TWMessageBarManager sharedInstance] showMessageWithTitle:LOGINFAILURE description:errorMsg type: TWMessageBarMessageTypeError duration:3];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        [[TWMessageBarManager sharedInstance] showMessageWithTitle:LOGINSUCCESS description:@"" type: TWMessageBarMessageTypeSuccess duration:3];
                        
                        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
                        SWRevealViewController *controller = [storyboard instantiateViewControllerWithIdentifier:@"SWRevealVC"];
                        
                        [self presentViewController:controller animated:true completion:nil];
                    });
                }
            }];
        }];
    } else {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:TEXTFIELDINPUTERROR type: TWMessageBarMessageTypeError duration:3];
    }
}

- (IBAction)goToSignUpPageBtnTapped:(id)sender {
//    UIStoryboard *storyboard = kMainStoryboard;
    SignUpViewController *controller = [kMainStoryboard instantiateViewControllerWithIdentifier:@"SignUpVC"];
    
    [self presentViewController:controller animated:true completion:nil];
}

- (IBAction)forgotPwdBtnTapped:(id)sender {
    NSString *phone = _phoneText.text;
    [[APIHandler sharedInstance] forgetPwdApiCall:phone withCompletion:^(NSError *error) {
        if (error == nil) {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Success" description:FORGOTPWDSUCCESS type: TWMessageBarMessageTypeSuccess duration:3];
        } else {
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:FORGOTPWDFAILURE type: TWMessageBarMessageTypeError duration:3];
        }
    }];
}

@end
