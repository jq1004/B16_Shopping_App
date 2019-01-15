//
//  CheckoutProductCell.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "CheckoutProductCell.h"
#import "APIHandler.h"

@implementation CheckoutProductCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _productView.layer.cornerRadius = 12;
    _productImgView.clipsToBounds = YES;
    _productImgView.layer.cornerRadius = 10;
    _addDeleteView.layer.cornerRadius = 12;
    // Configure the view for the selected state
    
    _qtyTxtF.enabled = false;
    if ([_product.pQuantity isEqual:@"1"]) {
        _plusBtn.enabled = false;
    }
    
    _productName.text = _product.pName;
    _productPrice.text = _product.pPrice;
    
    [[APIHandler sharedInstance] downloadImg:_product.pImageUrl withCompletion:^(UIImage *img) {
        if (img != nil) {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.productImgView.image = img;
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                self.productImgView.image = [UIImage imageNamed:@"not_found"];
            });
        }
    }];
}

- (void)manageStepper
{
    int qtyEntered = [_qtyTxtF.text doubleValue];
    int productQty = [_product.pQuantity doubleValue];
    
    if (qtyEntered >= productQty) {
        _plusBtn.enabled = false;
    } else {
        _plusBtn.enabled = true;
    }
    
    if (qtyEntered <= 0) {
        _minusBtn.enabled = false;
    } else {
        _minusBtn.enabled = true;
    }
}

- (IBAction)plusStepperBtn:(UIButton *)sender {
    
    int qtyEntered = [_qtyTxtF.text doubleValue];
    int productQty = [_product.pQuantity doubleValue];
    _qtyTxtF.text = [NSString stringWithFormat:@"%d", qtyEntered+1];
    
    if (qtyEntered+1 >= productQty) {
        _plusBtn.enabled = false;
    } else {
        _plusBtn.enabled = true;
    }
    
    if (qtyEntered+1 < 1) {
        _minusBtn.enabled = false;
    } else {
        _minusBtn.enabled = true;
    }
    
}
- (IBAction)minusStepperBtn:(UIButton *)sender {
    
    int productQty = [_product.pQuantity doubleValue];
    int qtyEntered = [_qtyTxtF.text doubleValue];
    _qtyTxtF.text = [NSString stringWithFormat:@"%d", qtyEntered-1];
    
    if (qtyEntered-1 < 1) {
        _minusBtn.enabled = false;
    } else {
        _minusBtn.enabled = true;
    }
    
    if (qtyEntered-1 >= productQty) {
        _plusBtn.enabled = false;
    } else {
        _plusBtn.enabled = true;
    }
}


@end
