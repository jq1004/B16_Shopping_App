//
//  APIHandler.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface APIHandler : NSObject

+ (instancetype)sharedInstance;

- (void)signUpUserWithFirstName:(NSString *)fname lastName:(NSString *)lname address:(NSString *)address password:(NSString *)password email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler;

- (void)updateProfileUserWithFirstName:(NSString *)fname lastName:(NSString *)lname email:(NSString *)email mobile:(NSString *)mobile completionHandler:(void (^) (NSString *response))completionHandler;

- (void)loginApiCall:(NSString *)phoneNumber password:(NSString *)pwd withCompletion:(void (^)(NSData *result, NSError *error))block;

- (void)forgetPwdApiCall:(NSString *)email withCompletion:(void (^)(NSError *error))block;

- (void)resetUserPasswordWithMobile: (NSString *)mobile oldPassword:(NSString *)oldPassword newPassword:(NSString *)newPassword completionHandler:(void (^) (NSString *response))completionHandler;

- (void)categoryApiCall:(NSString *)apiKey andUserId:(NSString *)userId withCompletion:(void (^)(NSData *result, NSError *error))block;

- (void)topSellersApiCall:(void (^)(NSData *result, NSError *error))block;

- (void)downloadImg:(NSString *)imgUrl withCompletion:(void (^)(UIImage *img))block;

- (void)productApiCall:(NSString *)apiKey andUserId:(NSString *)userId andCategoryId:(NSString *) cid andSubCategoryId:(NSString *) scid withCompletion:(void (^)(NSData *result, NSError *error))block;

- (void)subCategoryApiCall:(NSString *)apiKey andCatId:(NSString *)categoryId andUserId:(NSString *)userId withCompletion:(void (^)(NSData *result, NSError *error))completionHandler;

- (void)applyForCouponWithApiKey:(NSString *)apiKey andUserId:(NSString *)userId andCouponNo:(NSString *)couponNo withCompletion:(void (^)(NSData *result, NSError *error))block;

- (void)orderApiCall:(NSString *)apiKey andItem_id:(NSString *)item_id andItem_names:(NSString *)item_names andItem_quantity:(NSString *)item_quantity andFinal_price:(NSString *)final_price andUser_id:(NSString *)user_id andUser_name:(NSString *)user_name andBillingadd:(NSString *)billingadd andDeliveryAdd:(NSString *)deliveryadd andMobile:(NSString *)mobile andEmail:(NSString *)email withCompletion:(void (^)(NSData *result, NSError *error))block;

@end
