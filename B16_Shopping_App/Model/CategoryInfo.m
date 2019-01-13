//
//  CategoryInfo.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/12/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "CategoryInfo.h"

@implementation CategoryInfo

- (instancetype)initWithInfo:(NSString *)cId andCategoryName:(NSString *)cName andCategoryDiscription:(NSString *)cDiscription andCategoryImageUrl:(NSString *)cImageUrl {
    self = [super init];
    if (self) {
        self.cId = cId;
        self.cName = cName;
        self.cDiscription = cDiscription;
        self.cImageUrl = cImageUrl;
    }
    return self;
}
@end
