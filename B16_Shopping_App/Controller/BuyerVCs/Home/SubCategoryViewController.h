//
//  SubCategoryViewController.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//



#import <UIKit/UIKit.h>
#import "TopSellerInfo.h"
#import "SubCategoryInfo.h"

@interface SubCategoryViewController : UIViewController <UIScrollViewDelegate, UITableViewDelegate, UITableViewDataSource>

@property NSString *cId;
@property NSMutableArray<SubCategoryInfo *> *subcategories;
@property NSMutableArray<TopSellerInfo *> *topSellers;
@property NSMutableArray<UIImage *> *subcategoryImgs;
@property NSMutableArray<UIImage *> *topSellerImgs;

@end

