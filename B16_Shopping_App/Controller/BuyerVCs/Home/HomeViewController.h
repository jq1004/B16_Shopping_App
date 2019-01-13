//
//  HomeViewController.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CategoryInfo.h"
#import "TopSellerInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface HomeViewController : UIViewController <UIScrollViewDelegate>

@property NSMutableArray<CategoryInfo *> *categories;
@property NSMutableArray<TopSellerInfo *> *topSellers;
@property NSMutableArray<UIImage *> *categoryImgs;
@property NSMutableArray<UIImage *> *topSellerImgs;

@end

NS_ASSUME_NONNULL_END
