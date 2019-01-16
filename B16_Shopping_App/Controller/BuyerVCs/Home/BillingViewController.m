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
}

- (IBAction)placeOrderBtnTapped:(id)sender {
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
    request.HTTPBody = [[NSString stringWithFormat:@"payment_method_nonce=%@&amount=%d", paymentMethodNonce, self.total] dataUsingEncoding:NSUTF8StringEncoding];
    request.HTTPMethod = @"POST";
    
    [[[NSURLSession sharedSession] dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        // TODO: Handle success and failure
        if (error == nil) {
            [self generateOrder];
        } else {
            NSLog(@"%@", error);
        }
        NSLog(@"%@", data);
    }] resume];
}

- (void)generateOrder{
    [[APIHandler sharedInstance] orderApiCall:@"6948b84ad9c4e16ec5cb04a2906b120f" andItem_id:@"701" andItem_names:@"laptop" andItem_quantity:@"1" andFinal_price:@"100000" andUser_id:@"1583" andUser_name:@"Aamir" andBillingadd:@"Noida" andDeliveryAdd:@"Noida" andMobile:@"2133215888" andEmail:@"cll1004328@gmail.com" withCompletion:^(NSData *result, NSError *error) {
        NSLog(@"%@",result);
        [[APIParser sharedInstance] orderParser:result andError:error withCompletion:^(Boolean *hasError, OrderInfo *result) {
            if(hasError){
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Can't generate order" andMsg:@"Sorry, item is out of inventory."];
                });
            } else {
                dispatch_async(dispatch_get_main_queue(), ^{
                    OrderConfirmViewController *orderConfirmVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"OrderConfirmVC"];
                    orderConfirmVC.orderInfo = result;
                    [self presentViewController:orderConfirmVC animated:true completion:nil];
                });
            }
            
        }];
    }];
}

@end
