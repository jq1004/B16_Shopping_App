//
//  UserInfo.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "UserInfo.h"

@implementation UserInfo

- (instancetype) initWithInfo:(NSString *)userId andFirstName:(NSString *)firstName andLastName:(NSString *)lastName andEmail:(NSString *)email andMobile:(NSString *)mobile andAppApiKey:(NSString *)appapikey {
    self = [super init];
    if (self) {
        self.userId = userId;
        self.firstName = firstName;
        self.lastName = lastName;
        self.email = email;
        self.mobile = mobile;
        self.appapikey = appapikey;
    }
    return self;
}
@end
