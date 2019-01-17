//
//  OrderCell.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/16/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "OrderCell.h"


@interface OrderCell()

@end

@implementation OrderCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    _trackBtn.enabled = false;
    
    _orderIdLbl.text = _order.oId;
    _dateLbl.text= _order.oPlacedon;
    
}

- (void)manageshipStatus
{
    if ([_shipStatus[@"shipmentstatus"] isEqualToString:@"4"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.trackBtn.enabled = false;
        });
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            self.trackBtn.enabled = true;
        });
    }
}

@end
