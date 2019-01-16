//
//  OrderReceiptViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "OrderReceiptViewController.h"

@interface OrderReceiptViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UILabel *placeDateLbl;
@property (weak, nonatomic) IBOutlet UILabel *deliveryAddLbl;
@property (weak, nonatomic) IBOutlet UILabel *phoneNumber;
@property (weak, nonatomic) IBOutlet UILabel *totalPriceLbl;
@property (weak, nonatomic) IBOutlet UILabel *youPaidLbl;

@property (weak, nonatomic) IBOutlet UILabel *paymentTypeLbl;

@property (weak, nonatomic) IBOutlet UILabel *cardNumberLbl;

@property (weak, nonatomic) IBOutlet UIButton *trackOrderBtn;

@end

@implementation OrderReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void) setup{
    _orderIdLbl.layer.cornerRadius = 8;
    _placeDateLbl.layer.cornerRadius = 8;
    _deliveryAddLbl.layer.cornerRadius = 8;
    _phoneNumber.layer.cornerRadius = 8;
    _totalPriceLbl.layer.cornerRadius = 8;
    _youPaidLbl.layer.cornerRadius = 8;
    _paymentTypeLbl.layer.cornerRadius = 8;
    _cardNumberLbl.layer.cornerRadius = 8;
    _trackOrderBtn.layer.cornerRadius = 8;
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
