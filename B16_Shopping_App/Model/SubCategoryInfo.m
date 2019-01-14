//
//  SubCategoryInfo.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "SubCategoryInfo.h"

@implementation SubCategoryInfo

- (instancetype)initWithSCid:(NSString *)scId andSCategoryName:(NSString *)scName andSCategoryDiscription:(NSString *)scDiscription andSCategoryImageUrl:(NSString *)scImageUrl
{
    self = [super init];
    
    if(self) {
        self.scId = scId;
        self.scName = scName;
        self.scDiscription = scDiscription;
        self.scImageUrl = scImageUrl;
    }
    
    return self;
}

@end
