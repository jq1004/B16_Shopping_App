//
//  CheckOutViewController.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckOutViewController : UIViewController

@property NSArray<ProductInfo *> *products;
@property NSDictionary *qtys;
@property NSString *discountAmount;
@property int total; 

@end

NS_ASSUME_NONNULL_END
