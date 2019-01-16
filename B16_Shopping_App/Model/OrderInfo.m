//
//  OrderInfo.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/16/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "OrderInfo.h"

@implementation OrderInfo
- (instancetype)initWithInfo:(NSString *)oId andOrderName:(NSString *)oName andOrderBillingadd:(NSString *)oBillingadd andOrderDeliveryadd:(NSString *)oDeliveryadd andOrderMobile:(NSString *)oMobile andOrderItemname:(NSString *)oItemname andOrderTotalprice:(NSString *)oTotalprice andPaidprice:(NSString *)oPaidprice andOrderPlacedone:(NSString *)oPlacedon{
    
    self = [super init];
    if (self){
        self.oId = oId;
        self.oName = oName;
        self.oBillingadd = oBillingadd;
        self.oDeliveryadd = oDeliveryadd;
        self.oMobile = oMobile;
        self.oItemname = oItemname;
        self.oTotalprice = oTotalprice;
        self.oPaidprice = oPaidprice;
        self.oPlacedon = oPlacedon;
    }
    
    return self;
}
@end
