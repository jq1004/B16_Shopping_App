//
//  UserInfo.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface UserInfo : NSObject
@property NSString* userId;
@property NSString* firstName;
@property NSString* lastName;
@property NSString* email;
@property NSString* mobile;
@property NSString* appapikey;

-(instancetype) initWithInfo:(NSString *)userId andFirstName: (NSString *)firstName andLastName:(NSString *)lastName andEmail:(NSString *)email andMobile: (NSString*)mobile andAppApiKey:(NSString*) appapikey;
@end
