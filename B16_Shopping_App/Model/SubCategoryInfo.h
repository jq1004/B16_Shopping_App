//
//  SubCategoryInfo.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SubCategoryInfo : NSObject

@property NSString* scId;
@property NSString* scName;
@property NSString* scDiscription;
@property NSString* scImageUrl;

- (instancetype)initWithSCid:(NSString *)scId andSCategoryName:(NSString *)scName andSCategoryDiscription:(NSString *)scDiscription andSCategoryImageUrl:(NSString *)scImageUrl;

@end
