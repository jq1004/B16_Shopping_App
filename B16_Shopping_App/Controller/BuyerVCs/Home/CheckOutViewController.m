//
//  CheckOutViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "CheckOutViewController.h"
#import "CheckoutCell.h"
#import "BraintreeCore.h"
#import "BraintreeDropIn.h"
#import "APIHandler.h"
#import "APIParser.h"
#import "BillingViewController.h"
#import "TWMessageBarManager.h"

@interface CheckOutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *applyCouponBtn;

@property (weak, nonatomic) IBOutlet UILabel *subTotalLbl;

@property (weak, nonatomic) IBOutlet UILabel *deliveryLbl;

@property (weak, nonatomic) IBOutlet UIButton *checkoutBtn;

@property (weak, nonatomic) IBOutlet UITextField *couponTextfield;

@property (weak, nonatomic) IBOutlet UIView *subTotalView;

@property (weak, nonatomic) IBOutlet UILabel *totalLbl;

@property (weak, nonatomic) IBOutlet UIView *totalView;

@property NSString *demoPaymentApiKey;

- (IBAction)applyCouponBtnTapped:(id)sender;

- (IBAction)checkOutBtnTapped:(id)sender;

@end

@implementation CheckOutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _checkoutBtn.layer.cornerRadius = 12;
    _totalView.layer.cornerRadius = 12;
    _applyCouponBtn.layer.cornerRadius = 6;
    _subTotalView.layer.cornerRadius = 12;
    [_applyCouponBtn setTitle:@"Apply" forState:UIControlStateNormal];
    [self computePrice];
}

- (void)computePrice {
    int subtotal = 0;
    for (int i = 0; i < _products.count; i++) {
        subtotal += [_products[i].pPrice intValue] * [_qtys[_products[i].pId] intValue];
    }
    self.subTotalLbl.text = [NSString stringWithFormat:@"$%d", subtotal];
    self.totalLbl.text = [NSString stringWithFormat:@"$%d", subtotal];
    self.total = subtotal;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _products.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 170;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    CheckoutCell *cell = [tableView dequeueReusableCellWithIdentifier:@"checkoutCustomCell"];
    cell.product = _products[indexPath.row];
    cell.qtyTextField.text = _qtys[_products[indexPath.row].pId];
    return cell;
}

- (IBAction)applyCouponBtnTapped:(id)sender {
    if ([self.couponTextfield.text isEqualToString:@""]) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Sorry" description:@"Please type in your coupon." type: TWMessageBarMessageTypeError duration:3];
    } else {
        [[APIHandler sharedInstance] applyForCouponWithApiKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"] andUserId:[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"] andCouponNo:self.couponTextfield.text withCompletion:^(NSData *result, NSError *error) {
            [[APIParser sharedInstance] couponParser:result andError:error withCompletion:^(Boolean *hasError, NSString *discountAmount) {
                if (hasError) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Can't apply coupon" description:@"Sorry, we can't recognize this coupon code, please try another one." type: TWMessageBarMessageTypeError duration:3];
                    });
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        self.couponTextfield.enabled = false;
                        self.discountAmount = discountAmount;
                        self.applyCouponBtn.backgroundColor = [UIColor lightGrayColor];
                        [self.applyCouponBtn setTitle:[NSString stringWithFormat:@"$-%@", discountAmount] forState:UIControlStateNormal];
                        self.applyCouponBtn.enabled = false;
                        
                        int discount = [discountAmount intValue];
                        self.totalLbl.text = [NSString stringWithFormat:@"$%d", self.total - discount];
                    });
                }
            }];
        }];
    }
}

- (IBAction)checkOutBtnTapped:(id)sender {
    BillingViewController *billingVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"BillingVC"];
    billingVC.total = self.total; 
    [[self navigationController] pushViewController:billingVC animated:true];
}

@end
