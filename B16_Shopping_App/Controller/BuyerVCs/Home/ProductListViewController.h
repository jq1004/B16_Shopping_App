//
//  ProductListViewController.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"
NS_ASSUME_NONNULL_BEGIN

@interface ProductListViewController : UIViewController

@property NSString *cid;
@property NSString *scid;
@property NSMutableArray<ProductInfo*> *products;
@property NSMutableArray<UIImage *> *productImgs;


@end

NS_ASSUME_NONNULL_END
