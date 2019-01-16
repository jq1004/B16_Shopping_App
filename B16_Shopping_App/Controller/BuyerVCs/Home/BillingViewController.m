//
//  BillingViewController.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "BillingViewController.h"
#import "BraintreeCore.h"
#import "BraintreeDropIn.h"
#import "OrderConfirmViewController.h"
#import "APIHandler.h"
#import "APIParser.h"

@interface BillingViewController ()

@end

@implementation BillingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _placeOrderBtn.layer.cornerRadius = 12;
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)dismissKeyboard {
    [self.nameTextfield resignFirstResponder];
    [self.deliveryAddress resignFirstResponder];
    [self.billingAddress resignFirstResponder];
    [self.mobileTextfield resignFirstResponder];
    [self.emailTextfield resignFirstResponder];
}

- (IBAction)placeOrderBtnTapped:(id)sender {
    if (![self.nameTextfield.text  isEqual: @""] && ![self.deliveryAddress.text  isEqual: @""] && ![self.billingAddress.text  isEqual: @""] && ![self.mobileTextfield.text  isEqual: @""] && ![self.emailTextfield.text  isEqual: @""]) {
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
    } else {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Please fill in all required fields!" type: TWMessageBarMessageTypeError duration:3];
    }
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
        [SVProgressHUD show];
        [controller dismissViewControllerAnimated:true completion:nil];
    }];
    [self presentViewController:dropIn animated:YES completion:nil];
}

- (void)postNonceToServer:(NSString *)paymentMethodNonce {
    // Update URL with your server
    NSURL *paymentURL = [NSURL URLWithString:@"http://localhost:4567/checkouts"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:paymentURL];
    request.HTTPBody = [[NSString stringWithFormat:@"payment_method_nonce=%@&amount=%d", paymentMethodNonce, self.total] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle success and failure
        if (error == nil) {
            [self generateOrder];
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }
    }] resume];
}

- (void)generateOrder{
    NSString *str =[NSString stringWithFormat:@"%i", self.total];
    NSString * apiKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"];
    NSString * userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    [[APIHandler sharedInstance] orderApiCall:apiKey andItem_id:self.productId andItem_names:self.productName andItem_quantity:self.productQuantity andFinal_price:[NSString stringWithFormat:@"%i", self.total] andUser_id:userId andUser_name:self.nameTextfield.text andBillingadd:self.billingAddress.text andDeliveryAdd:self.deliveryAddress.text andMobile:self.mobileTextfield.text andEmail:self.emailTextfield.text withCompletion:^(NSData *result, NSError *error) {
        NSLog(@"%@",result);
        [[APIParser sharedInstance] orderParser:result andError:error withCompletion:^(Boolean *hasError, OrderInfo *result) {
            if(hasError){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    [self showAlert:@"Can't generate order" andMsg:@"Sorry, item is out of inventory."];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [SVProgressHUD dismiss];
                    OrderConfirmViewController *orderConfirmVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderConfirmVC"];
                    orderConfirmVC.orderInfo = result;
                    [self presentViewController:orderConfirmVC animated:true completion:nil];
                });
            }
            
        }];
    }];
}

@end
