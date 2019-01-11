//
//  APIHandler.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIHandler : NSObject

+ (instancetype)sharedInstance;

- (void)signUpUserWithFirstName:(NSString *)fname lastName:(NSString *)lname address:(NSString *)address password:(NSString *)password email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler;

- (void)updateProfileUserWithFirstName:(NSString *)fname lastName:(NSString *)lname address:(NSString *)address email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler;

- (void)loginUserWithPhone:(NSString *)phoneNumber password:(NSString *)password;

@end
