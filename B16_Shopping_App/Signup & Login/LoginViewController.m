//
//  LoginViewController.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)login:(id)sender {
    [self tempApiCall];
}

- (void) tempApiCall {
    // Make api call
    NSString *phone = _phoneText.text;
    NSString *pwd = _password.text;
    NSString *strURL = [NSString stringWithFormat:@"http://rjtmobile.com/aamir/e-commerce/ios-app/shop_login.php?mobile=%@&password=%@", phone, pwd];
//    NSURL *url = [NSURL URLWithString:strURL];
    NSURL *url = [NSURL URLWithString:@"http://rjtmobile.com/aamir/e-commerce/ios-app/shop_login.php?mobile=55565454&password=7011"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        NSLog(@"%@", data);
    }];
    [dataTask resume];
}
@end
