//
//  ProductDetailViewController.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"

NS_ASSUME_NONNULL_BEGIN

@interface ProductDetailViewController : UIViewController

@property ProductInfo *product;
@property UIImage *productImg;

@property (weak, nonatomic) IBOutlet UIImageView *productImgView;
@property (weak, nonatomic) IBOutlet UIButton *addToCart;
@property (weak, nonatomic) IBOutlet UILabel *quantityLbl;
@property (weak, nonatomic) IBOutlet UILabel *priceLbl;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTxtV;
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;

- (void)setUpDetailView;

@end

NS_ASSUME_NONNULL_END
