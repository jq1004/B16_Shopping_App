//
//  APIParser.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserInfo.h"

@interface APIParser : NSObject

+(instancetype)sharedInstance;

- (UserInfo *)loginParser:(NSData *)userDetail andError:(NSError *)error withCompletion:(void (^)(Boolean *hasError))block;

@end
