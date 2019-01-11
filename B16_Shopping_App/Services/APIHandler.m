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

-(void)signUpAPI: (NSString *)fname : (NSString *)lname : (NSString *)address : (NSString *)password : (NSString *)email : (NSString *)mobile : (void (^) (NSString* response))completionHandler
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

-(void)updateProfileAPI: (NSString *)fname : (NSString *)lname : (NSString *)address : (NSString *)email : (NSString *)mobile : (void (^) (NSString* response))completionHandler
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

@end

