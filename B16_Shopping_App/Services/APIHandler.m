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
    
    NSString *urlstring = [NSString stringWithFormat:@"%@fname=%@&lname=%@&address=%@&email=%@&mobile=%@&password=%@",KSIGNUPAPI,fname,lname,address,email,mobile,password];

    
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

- (void)updateProfileUserWithFirstName:(NSString *)fname lastName:(NSString *)lname email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler
{
    
    NSString *urlstring = [NSString stringWithFormat:@"%@fname=%@&lname=%@&address=address&email=%@&mobile=%@",KUPDATEPROFILEAPI,fname,lname,email,mobile];
    
    
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

- (void)loginApiCall:(NSString *)phoneNumber password:(NSString *)pwd withCompletion:(void (^)(NSData *result, NSError *error))block {
    NSString *strURL = [NSString stringWithFormat:@"%@mobile=%@&password=%@", kLOGINAPI, phoneNumber, pwd];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data, error);
    }];
    [dataTask resume];
}

- (void)forgetPwdApiCall:(NSString *)email withCompletion:(void (^)(NSError *))block {
    NSString *strURL = [NSString stringWithFormat:@"%@email=%@", kLOGINAPI, email];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(error);
    }];
    [dataTask resume];
}

- (void)resetUserPasswordWithMobile: (NSString *)mobile oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completionHandler:(void (^) (NSString *response))completionHandler
{
    
    NSString *urlString = [NSString stringWithFormat:@"%@mobile=%@&password=%@&newpassword=%@",KRESETPASSWORDAPI,mobile,oldPassword,newPassword];
    
    NSURL *url = [NSURL URLWithString:urlString];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSession *session = [NSURLSession sharedSession];
    NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error == nil && data != nil) {
            NSDictionary *json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            NSArray *arr = json[@"msg"];
            NSString *msg = arr[0];
            completionHandler(msg);
        }
    }];
    
    [dataTask resume];
}

- (void)categoryApiCall:(NSString *)apiKey andUserId:(NSString *)userId withCompletion:(void (^)(NSData *result, NSError *error))block {
    NSString *strURL = [NSString stringWithFormat:@"%@api_key=%@&user_id=%@", kCATEGORYAPI, apiKey, userId];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data, error);
    }];
    [dataTask resume];
}

- (void)subCategoryApiCall:(NSString *)apiKey andCatId:(NSString *)categoryId andUserId:(NSString *)userId withCompletion:(void (^)(NSData *result, NSError *error))completionHandler {
    
    NSString *strURL = [NSString stringWithFormat:@"%@Id=%@&api_key=%@&user_id=%@", kSUBCATEGORYAPI, categoryId, apiKey, userId];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completionHandler(data, error);
    }];
    [dataTask resume];
}

- (void)topSellersApiCall:(void (^)(NSData *result, NSError *error))block {
    NSString *strURL = kTOPSELLERSAPI;
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data, error);
    }];
    [dataTask resume];
}

- (void)downloadImg:(NSString *)imgUrl withCompletion:(void (^)(UIImage *img))block {
    NSURL *url = [NSURL URLWithString:imgUrl];
    UIImage *img = nil;
    
    @try {
        NSData *imgData = [NSData dataWithContentsOfURL:url];
        img = [UIImage imageWithData:imgData];
        block(img);
    } @catch (NSException *exception) {
        NSLog(@"Error");
        block(img);
    } @finally {
    }
}

- (void)productApiCall:(NSString *)apiKey andUserId:(NSString *)userId andCategoryId:(NSString *) cid andSubCategoryId:(NSString *) scid withCompletion:(void (^)(NSData *result, NSError *error))block{
    NSString *strURL = [NSString stringWithFormat:@"%@cid=%@&scid=%@&api_key=%@&user_id=%@", kPRODUCTAPI, cid, scid, apiKey, userId];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data, error);
    }];
    [dataTask resume];
}

- (void)applyForCouponWithApiKey:(NSString *)apiKey andUserId:(NSString *)userId andCouponNo:(NSString *)couponNo withCompletion:(void (^)(NSData *, NSError *))block {
    NSString *strURL = [NSString stringWithFormat:@"%@api_key=%@&user_id=%@&couponno=%@", kCOUPONAPI, apiKey, userId, couponNo];
    NSURL *url = [NSURL URLWithString:strURL];
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    [request setHTTPMethod:@"GET"];
    
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        block(data, error);
    }];
    [dataTask resume];
}

@end

