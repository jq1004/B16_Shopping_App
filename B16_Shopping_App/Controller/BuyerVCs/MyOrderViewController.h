//
//  MyOrderViewController.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface MyOrderViewController : UIViewController <UITableViewDataSource,UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBarBtn;
@property NSArray<OrderInfo*> *orders;

@end

NS_ASSUME_NONNULL_END
