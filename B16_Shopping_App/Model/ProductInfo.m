//
//  ProductInfo.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "ProductInfo.h"

@implementation ProductInfo

- (instancetype)initWithInfo:(NSString *)pId andProductName:(NSString *)pName andProductpQuantity:(NSString *)pQuantity andProductPrice:(NSString *)pPrice andProductDiscription:(NSString *)pDiscription andProductImageUrl:(NSString *)pImageUrl{
    
    self = [super init];
    if (self){
        self.pId = pId;
        self.pName = pName;
        self.pQuantity = pQuantity;
        self.pPrice = pPrice;
        self.pDiscription = pDiscription;
        self.pImageUrl = pImageUrl;
    }
    return self;
}

@end
