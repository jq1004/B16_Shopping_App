//
//  BillingViewController.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface BillingViewController : UIViewController

@property int total;

@property NSString * productName;

@property NSString * productId;

@property NSString * productQuantity;

@property (weak, nonatomic) IBOutlet UITextField *nameTextfield;

@property (weak, nonatomic) IBOutlet UITextField *deliveryAddress;

@property (weak, nonatomic) IBOutlet UITextField *billingAddress;

@property (weak, nonatomic) IBOutlet UITextField *mobileTextfield;

@property (weak, nonatomic) IBOutlet UITextField *emailTextfield;

@property (weak, nonatomic) IBOutlet UIButton *placeOrderBtn;

- (IBAction)placeOrderBtnTapped:(id)sender;
@end

NS_ASSUME_NONNULL_END
