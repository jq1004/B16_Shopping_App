//
//  OrderConfirmViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "OrderConfirmViewController.h"

@interface OrderConfirmViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderId;


@property (weak, nonatomic) IBOutlet UILabel *placeDay;

@property (weak, nonatomic) IBOutlet UILabel *deliveryAdd;

@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *youPaid;
@property (weak, nonatomic) IBOutlet UILabel *paymentType;

@property (weak, nonatomic) IBOutlet UILabel *cardNum;


@property (weak, nonatomic) IBOutlet UIButton *trackBtn;


@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)setup{
    _orderId.layer.cornerRadius = 8;
    _placeDay.layer.cornerRadius = 8;
    _deliveryAdd.layer.cornerRadius = 8;
    _phoneNum.layer.cornerRadius = 8;
    _totalPrice.layer.cornerRadius = 8;
    _youPaid.layer.cornerRadius = 8;
    _paymentType.layer.cornerRadius = 8;
    _cardNum.layer.cornerRadius = 8;
    _trackBtn.layer.cornerRadius = 8;
    
    _orderId.text = self.orderInfo.oId;
    _placeDay.text = self.orderInfo.oPlacedon;
    _deliveryAdd.text = self.orderInfo.oDeliveryadd;
    _phoneNum.text = self.orderInfo.oMobile;
    _totalPrice.text = self.orderInfo.oTotalprice;
    _youPaid.text = self.orderInfo.oPaidprice;
    _paymentType.text = @"Credit Card";
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
