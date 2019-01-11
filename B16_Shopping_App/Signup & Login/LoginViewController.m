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

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    NSString *phone = _phoneText.text;
    NSString *pwd = _password.text;
    [[APIHandler sharedInstance] loginApiCall:phone password:pwd withCompletion:^(NSData* result, NSError* error) {
        [[APIParser sharedInstance] loginParser:result andError:error]; 
    }];
}

@end
