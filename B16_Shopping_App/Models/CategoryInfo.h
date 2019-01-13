//
//  CategoryInfo.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/12/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryInfo : NSObject

@property NSString* cId;
@property NSString* cName;
@property NSString* cDiscription;
@property NSString* cImageUrl;

- (instancetype)initWithInfo:(NSString *)cId andCategoryName:(NSString *)cName andCategoryDiscription:(NSString *)cDiscription andCategoryImageUrl:(NSString *)cImageUrl;

@end

NS_ASSUME_NONNULL_END
