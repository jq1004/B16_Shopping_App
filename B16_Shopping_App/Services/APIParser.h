//
//  APIParser.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"
#import "CategoryInfo.h"
#import "TopSellerInfo.h"
#import "ProductInfo.h"
#import "SubCategoryInfo.h"
#import "OrderInfo.h"

@interface APIParser : NSObject

+(instancetype)sharedInstance;

- (UserInfo *)loginParser:(NSData *)userDetail andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError))block;

- (void)categoryParser:(NSData *)categoryInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<CategoryInfo *> *result))block;

- (void)topSellerParser:(NSData *)topSellerInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<TopSellerInfo *> *result))block;

- (void)productParser:(NSData *)productInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<ProductInfo *> *result))block;

- (void)subCategoryParser:(NSData *)subCategoryInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<SubCategoryInfo *> *result))completionHandler;

- (void)couponParser:(NSData *)counponInfo andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSString *discountAmount))block;

- (void)orderParser:(NSData *)orderInfo andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, OrderInfo * result))block;

@end
