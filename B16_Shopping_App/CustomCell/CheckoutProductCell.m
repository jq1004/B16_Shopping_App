//
//  CheckoutProductCell.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "CheckoutProductCell.h"

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
}

@end
