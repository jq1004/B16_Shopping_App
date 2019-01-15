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

@interface CheckOutViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *applyCouponBtn;

@property (weak, nonatomic) IBOutlet UILabel *subTotalLbl;

@property (weak, nonatomic) IBOutlet UILabel *deliveryLbl;

@property (weak, nonatomic) IBOutlet UIButton *checkoutBtn;

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
    _applyCouponBtn.layer.cornerRadius = 12;
    _checkoutBtn.layer.cornerRadius = 12;
    _totalView.layer.cornerRadius = 12;
    [_applyCouponBtn setTitle:@"Apply" forState:UIControlStateNormal];
    [self computePrice];
}

- (void)computePrice {
    int subtotal = 0;
    for (int i = 0; i < _products.count; i++) {
        subtotal += [_products[i].pPrice intValue] * [_qtys[_products[i].pId] intValue];
    }
    self.subTotalLbl.text = [NSString stringWithFormat:@"%d", subtotal];
    self.totalLbl.text = [NSString stringWithFormat:@"%d", subtotal];
    self.total = subtotal;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
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
    [[APIHandler sharedInstance] applyForCouponWithApiKey:[[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"] andUserId:[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"] andCouponNo:@"2147483648" withCompletion:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] couponParser:result andError:error withCompletion:^(Boolean *hasError, NSString *discountAmount) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Can't apply coupon" andMsg:@"Sorry, we can't recognize this coupon code, please try another one."];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    self.discountAmount = discountAmount;
                    self.applyCouponBtn.backgroundColor = [UIColor lightGrayColor];
                    [self.applyCouponBtn setTitle:[NSString stringWithFormat:@"-%@$", discountAmount] forState:UIControlStateNormal];
                    self.applyCouponBtn.enabled = false;
                    
                    int discount = [discountAmount intValue];
                    self.totalLbl.text = [NSString stringWithFormat:@"%d", self.total - discount];
                });
            }
        }];
    }];
}

- (IBAction)checkOutBtnTapped:(id)sender {
    // TODO: Switch this URL to your own authenticated API
    NSURL *clientTokenURL = [NSURL URLWithString:@"http://localhost:4567/client_token"];
    NSMutableURLRequest *clientTokenRequest = [NSMutableURLRequest requestWithURL:clientTokenURL];
    [clientTokenRequest setValue:@"text/plain" forHTTPHeaderField:@"Accept"];
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:clientTokenRequest completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle errors
        NSString *clientToken = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
        [self showDropInUI:clientToken];
        // As an example, you may wish to present Drop-in at this point.
        // Continue to the next section to learn more...
    }] resume];
}

- (void)showDropInUI:(NSString *)apiToken {
    BTDropInRequest *request = [[BTDropInRequest alloc] init];
    BTDropInController *dropIn = [[BTDropInController alloc] initWithAuthorization:apiToken request:request handler:^(BTDropInController * _Nonnull controller, BTDropInResult * _Nullable result, NSError * _Nullable error) {
        
        if (error != nil) {
            NSLog(@"ERROR");
        } else if (result.cancelled) {
            NSLog(@"CANCELLED");
        } else {
            // Use the BTDropInResult properties to update your UI
            // result.paymentOptionType
            // result.paymentMethod
            // result.paymentIcon
            // result.paymentDescription
            [self postNonceToServer:@"fake-valid-nonce"];
        }
        [controller dismissViewControllerAnimated:true completion:nil];
    }];
    [self presentViewController:dropIn animated:YES completion:nil];
}

- (void)postNonceToServer:(NSString *)paymentMethodNonce {
    // Update URL with your server
    NSURL *paymentURL = [NSURL URLWithString:@"http://localhost:4567/checkouts"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:paymentURL];
    request.HTTPBody = [[NSString stringWithFormat:@"payment_method_nonce=%@&amount=%@", paymentMethodNonce, @"18"] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle success and failure
        NSLog(@"%@", data);
    }] resume];
}
@end
