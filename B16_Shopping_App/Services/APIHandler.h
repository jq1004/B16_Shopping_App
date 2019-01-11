//
//  APIHandler.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIHandler : NSObject

+(instancetype)sharedInstance;
-(void)signUpAPI: (NSString *)fname : (NSString *)lname : (NSString *)address : (NSString *)password : (NSString *)email : (NSString *)mobile : (void (^) (NSString* response))completionHandler;
-(void)updateProfileAPI: (NSString *)fname : (NSString *)lname : (NSString *)address : (NSString *)email : (NSString *)mobile : (void (^) (NSString* response))completionHandler;
@end
