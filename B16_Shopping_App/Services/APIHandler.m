//
//  APIHandler.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIHandler.h"

@interface APIHandler()

@end

@implementation APIHandler

+ (instancetype)sharedInstance
{
    
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}


- (void)signUpUserWithFirstName:(NSString *)fname lastName:(NSString *)lname address:(NSString *)address password:(NSString *)password email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler
{
    
    NSString *urlstring = [NSString stringWithFormat:@"http://rjtmobile.com/aamir/e-commerce/ios-app/shop_reg.php?fname=%@&lname=%@&address=%@&email=%@&mobile=%@&password=%@",fname,lname,address,email,mobile,password];

    
    NSURL *serviceUrl = [NSURL URLWithString: urlstring];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: serviceUrl];
    
    [request setHTTPMethod: @"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            NSString *resp = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            completionHandler(resp);
        }
    }];
    [datatask resume];
    
}

- (void)updateProfileUserWithFirstName:(NSString *)fname lastName:(NSString *)lname address:(NSString *)address email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler
{
    
    NSString *urlstring = [NSString stringWithFormat:@"http://rjtmobile.com/aamir/e-commerce/ios-app/edit_profile.php?fname=%@&lname=%@&address=%@&email=%@&mobile=%@",fname,lname,address,email,mobile];
    
    
    NSURL *serviceUrl = [NSURL URLWithString: urlstring];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL: serviceUrl];
    
    [request setHTTPMethod: @"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    NSURLSessionDataTask *datatask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            NSString *resp = [[NSString alloc] initWithData:data encoding: NSUTF8StringEncoding];
            completionHandler(resp);
        }
    }];
    [datatask resume];
}

- (void)loginUserWithPhone:(NSString *)phoneNumber password:(NSString *)password
{
    NSString *strURL = [NSString stringWithFormat:@"%@mobile=%@&password=%@", kLOGINAPI, phoneNumber, password];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", data);
    }];
    [dataTask resume];
    
}

@end

