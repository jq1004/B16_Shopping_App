//
//  APIParser.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "APIParser.h"
#import "DataBaseManager.h"

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

- (UserInfo *)loginParser:(NSData *)userDetail andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError))block {
    UserInfo *userInfo = nil;
    NSArray *userInfoJson = [NSJSONSerialization JSONObjectWithData: userDetail options:NSJSONReadingMutableContainers error: &error];

    if (!userInfoJson || ![userInfoJson[0][@"msg"] isEqual: @"success"] || error) {
        
        NSLog(@"Error parsing JSON: %@", error);
        block(true);
        
    } else {
        
        NSLog(@"%@", userInfoJson[0][@"id"]);
        
        userInfo = [[UserInfo alloc] initWithInfo:userInfoJson[0][@"id"] andFirstName:userInfoJson[0][@"firstname"] andLastName:userInfoJson[0][@"lastname"] andEmail:userInfoJson[0][@"email"] andMobile:userInfoJson[0][@"mobile"] andAppApiKey:userInfoJson[0][@"appapikey "]];
        
        Boolean doesExist = [[DataBaseManager sharedInstance] doesExistWithId: userInfoJson[0][@"id"]];
        if (!doesExist) {
            [[DataBaseManager sharedInstance] saveUserWithUser:userInfo];
        }
        
        [[NSUserDefaults standardUserDefaults] setValue:userInfoJson[0][@"id"] forKey:@"userId"];
        [[NSUserDefaults standardUserDefaults] setBool:true forKey:@"isLoggedIn"];
        [[NSUserDefaults standardUserDefaults] setValue:userInfoJson[0][@"appapikey "] forKey:@"appapikey"];
        block(false);
    }
    return userInfo;
}

- (void)categoryParser:(NSData *)categoryInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<CategoryInfo *> *result))block {
    NSMutableArray<CategoryInfo *> *arr = [[NSMutableArray alloc] init];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:categoryInfoList options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData || error) {
        NSLog(@"Error parsing JSON: %@", error);
        block(true, arr);
    } else {
        NSArray *categories = jsonData[@"category"];
        for (int i = 0; i < categories.count; i++) {
            NSDictionary *category = categories[i];
            CategoryInfo *categoryItem = [[CategoryInfo alloc] initWithInfo:category[@"cid"] andCategoryName:category[@"cname"] andCategoryDiscription:category[@"cdiscription"] andCategoryImageUrl:category[@"cimagerl"]];
            [arr addObject:categoryItem];
        }
        block(false, arr);
    }
}

- (void)subCategoryParser:(NSData *)subCategoryInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<SubCategoryInfo *> *result))completionHandler {
    NSMutableArray<SubCategoryInfo *> *arr = [[NSMutableArray alloc] init];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:subCategoryInfoList options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData || error) {
        NSLog(@"Error parsing JSON: %@", error);
        completionHandler(true, arr);
    } else {
        NSArray *scategories = jsonData[@"subcategory"];
        for (int i = 0; i < scategories.count; i++) {
            NSDictionary *scategory = scategories[i];
            SubCategoryInfo *scategoryItem = [[SubCategoryInfo alloc] initWithSCid:scategory[@"scid"] andSCategoryName:scategory[@"scname"] andSCategoryDiscription:scategory[@"scdiscription"] andSCategoryImageUrl:scategory[@"scimageurl"]];
            [arr addObject:scategoryItem];
        }
        completionHandler(false, arr);
    }
}

- (void)topSellerParser:(NSData *)topSellerInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<TopSellerInfo *> *result))block {
    NSMutableArray<TopSellerInfo *> *arr = [[NSMutableArray alloc] init];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:topSellerInfoList options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData || error) {
        NSLog(@"Error parsing JSON: %@", error);
        block(true, arr);
    } else {
        NSArray *topSellers = jsonData[@"Top sellers"];
        for (int i = 0; i < topSellers.count; i++) {
            NSDictionary *topSeller = topSellers[i];
            TopSellerInfo *topSellerItem = [[TopSellerInfo alloc] initWithInfo:topSeller[@"id"] andSellerName:topSeller[@"sellername"] andSellerDeal:topSeller[@"sellerdeal"] andSellerRating:topSeller[@"sellerrating"] andSellerLogo:topSeller[@"sellerlogo"]];
            [arr addObject:topSellerItem];
        }
        block(false, arr);
    }
}

- (void)productParser:(NSData *)productInfoList andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, NSMutableArray<ProductInfo *> *result))block;{
    
    NSMutableArray<ProductInfo *> *arr = [[NSMutableArray alloc] init];
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:productInfoList options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData || error) {
        NSLog(@"Error parsing JSON: %@", error);
        block(true, arr);
    } else {
        NSArray *products = jsonData[@"products"];
        NSLog(@"check api parse nsarray %@",products);
        for (int i = 0; i < products.count; i++) {
            NSDictionary *product = products[i];
            ProductInfo *productItem = [[ProductInfo alloc] initWithInfo:product[@"id"] andProductName:product[@"pname"] andProductpQuantity:product[@"quantity"] andProductPrice:product[@"prize"] andProductDiscription:product[@"discription"] andProductImageUrl:product[@"image"]];
            [arr addObject:productItem];
        }
        block(false, arr);
    }
}

- (void)couponParser:(NSData *)counponInfo andError:(NSError *)error withCompletion:(void (^)(Boolean *, NSString *))block {
    NSDictionary *discountInfoJson = [NSJSONSerialization JSONObjectWithData: counponInfo options:NSJSONReadingMutableContainers error: &error];
    
    if (!discountInfoJson || error) {
        NSLog(@"Error parsing JSON: %@", error);
        block(true, @"");
    } else {
        NSString *discountAmount = discountInfoJson[@"Coupon discount"][0][@"discount"];
        block(false, discountAmount);
    }
}

- (void)orderParser:(NSData *)orderInfo andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError, OrderInfo *result))block;{
    NSDictionary *jsonData = [NSJSONSerialization JSONObjectWithData:orderInfo options:NSJSONReadingMutableContainers error:&error];
    
    if (!jsonData || error) {
        NSLog(@"Error parsing JSON: %@", error);
        block(true, nil);
    } else {
        NSArray *orderArr = jsonData[@"Order confirmed"];
        NSLog(@"check api parse nsarray %@",orderArr);
        NSDictionary *order = orderArr[0];
        OrderInfo *orderItem = [[OrderInfo alloc] initWithInfo:order[@"orderid"] andOrderName:order[@"name"] andOrderBillingadd:order[@"billingadd"] andOrderDeliveryadd:order[@"deliveryadd"] andOrderMobile:order[@"mobile"] andOrderItemname:order[@"itemname"] andOrderTotalprice:order[@"totalprice"] andPaidprice:order[@"paidprice"] andOrderPlacedone:order[@"placedon"]];
        block(false, orderItem);
    }
}

@end
