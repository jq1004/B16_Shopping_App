//
//  TopSellerInfo.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/12/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface TopSellerInfo : NSObject

@property NSString* pId;
@property NSString* sellerName;
@property NSString* sellerDeal;
@property NSString* sellerRating;
@property NSString* sellerLogo;

- (instancetype)initWithInfo:(NSString *)pId andSellerName:(NSString *)sellerName andSellerDeal:(NSString *)sellerDeal andSellerRating:(NSString *)sellerRating andSellerLogo:(NSString *)sellerLogo;

@end

NS_ASSUME_NONNULL_END
