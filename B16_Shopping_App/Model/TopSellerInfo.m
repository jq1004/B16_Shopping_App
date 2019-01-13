//
//  TopSellerInfo.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/12/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "TopSellerInfo.h"

@implementation TopSellerInfo

- (instancetype)initWithInfo:(NSString *)pId andSellerName:(NSString *)sellerName andSellerDeal:(NSString *)sellerDeal andSellerRating:(NSString *)sellerRating andSellerLogo:(NSString *)sellerLogo {
    self = [super init];
    if (self) {
        self.pId = pId;
        self.sellerName = sellerName;
        self.sellerDeal = sellerDeal;
        self.sellerRating = sellerRating;
        self.sellerLogo = sellerLogo;
    }
    return self;
}
@end
