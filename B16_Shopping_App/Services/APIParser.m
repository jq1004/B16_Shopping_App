//
//  APIParser.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIParser.h"

@interface APIParser()

@end

@implementation APIParser


+ (instancetype)sharedInstance
{
    
    static id instance = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    
    return instance;
}

- (UserInfo *)loginParser:(NSData *)userDetail andError:(NSError *)error {
    UserInfo *userInfo = nil;
    NSArray *userInfoJson = [NSJSONSerialization JSONObjectWithData: userDetail options: NSJSONReadingMutableContainers error: &error];

    if (!userInfoJson || error) {
        NSLog(@"Error parsing JSON: %@", error);
    } else {
        NSLog(@"%@", userInfoJson[0][@"id"]); 
        userInfo = [[UserInfo alloc] initWithInfo:userInfoJson[0][@"id"] andFirstName:userInfoJson[0][@"firstname"] andLastName:userInfoJson[0][@"lastname"] andEmail:userInfoJson[0][@"email"] andMobile:userInfoJson[0][@"mobile"] andAppApiKey:userInfoJson[0][@"appapikey "]];
    }
    return userInfo;
}

@end
