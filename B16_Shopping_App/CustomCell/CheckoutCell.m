//
//  CheckoutCell.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "CheckoutCell.h"
#import "APIHandler.h"

@implementation CheckoutCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    _cellSideView.layer.cornerRadius = 12;
    _productImg.clipsToBounds = YES;
    _productImg.layer.cornerRadius = 10;
    // Configure the view for the selected state
    
    _productName.text = _product.pName;
    _productPrice.text = _product.pPrice;
    
    [[APIHandler sharedInstance] downloadImg:_product.pImageUrl withCompletion:^(UIImage *img) {
        if (img != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.productImg.image = img;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.productImg.image = [UIImage imageNamed:@"not_found"];
            });
        }
    }];
}

@end
