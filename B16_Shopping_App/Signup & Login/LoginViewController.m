//
//  LoginViewController.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "LoginViewController.h"
#import "APIHandler.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    NSString *phone = _phoneText.text;
    NSString *pwd = _password.text;
    [[APIHandler sharedInstance] loginUserWithPhone:phone password:pwd];
}

@end
