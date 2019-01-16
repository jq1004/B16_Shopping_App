//
//  CheckoutCell.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface CheckoutCell : UITableViewCell

@property ProductInfo *product;
@property NSString* qty;

@property (weak, nonatomic) IBOutlet UIImageView *productImg;
@property (weak, nonatomic) IBOutlet UILabel *productName;
@property (weak, nonatomic) IBOutlet UIView *cellSideView;
@property (weak, nonatomic) IBOutlet UILabel *productPrice;
@property (weak, nonatomic) IBOutlet UITextField *qtyTextField;
@end

NS_ASSUME_NONNULL_END
