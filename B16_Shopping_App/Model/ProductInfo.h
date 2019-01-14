//
//  ProductInfo.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ProductInfo : NSObject
@property NSString* pId;
@property NSString* pName;
@property NSString* pQuantity;
@property NSString* pPrice;
@property NSString* pDiscription;
@property NSString* pImageUrl;


- (instancetype)initWithInfo:(NSString *)pId andProductName:(NSString *)pName andProductpQuantity:(NSString *)pQuantity andProductPrice:(NSString *)pPrice andProductDiscription:(NSString *)pDiscription andProductImageUrl:(NSString *)pImageUrl;

@end
NS_ASSUME_NONNULL_END



