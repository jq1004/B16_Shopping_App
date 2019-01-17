//
//  OrderConfirmViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "OrderConfirmViewController.h"
#import "SWRevealViewController.h"
#import "ShipmentTrackViewController.h"
#import "APIHandler.h"

@interface OrderConfirmViewController ()

@property (weak, nonatomic) IBOutlet UILabel *orderId;


@property (weak, nonatomic) IBOutlet UILabel *placeDay;

@property (weak, nonatomic) IBOutlet UILabel *deliveryAdd;

@property (weak, nonatomic) IBOutlet UILabel *phoneNum;
@property (weak, nonatomic) IBOutlet UILabel *totalPrice;
@property (weak, nonatomic) IBOutlet UILabel *youPaid;
@property (weak, nonatomic) IBOutlet UILabel *paymentType;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBarBtn;


@property (weak, nonatomic) IBOutlet UIButton *trackBtn;

@property NSString *userId;
@property NSString *apikey;


@end

@implementation OrderConfirmViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    // Do any additional setup after loading the view.
}

- (void)setup{
    
    _myBarBtn.target = self.revealViewController;
    _myBarBtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    _userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    _apikey = [[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"];
    
    _orderId.layer.cornerRadius = 8;
    _placeDay.layer.cornerRadius = 8;
    _deliveryAdd.layer.cornerRadius = 8;
    _phoneNum.layer.cornerRadius = 8;
    _totalPrice.layer.cornerRadius = 8;
    _youPaid.layer.cornerRadius = 8;
    _paymentType.layer.cornerRadius = 8;
    _trackBtn.layer.cornerRadius = 8;
    
    
    NSMutableString *orderView = [NSMutableString string];
    [orderView appendString:@"  OrderId: "];
    [orderView appendString:self.orderInfo.oId];
    _orderId.text =  orderView;
    
    NSMutableString *placeDateView = [NSMutableString string];
    [placeDateView appendString:@"  Placed on: "];
    [placeDateView appendString:self.orderInfo.oPlacedon];
    _placeDay.text = placeDateView;
    
    NSMutableString *deliveryAddressView = [NSMutableString string];
    [deliveryAddressView appendString:@"  Delivery Address: "];
    [deliveryAddressView appendString:self.orderInfo.oDeliveryadd];
    _deliveryAdd.text = deliveryAddressView;
    
    NSMutableString *phoneNumView = [NSMutableString string];
    [phoneNumView appendString:@"  Phone Number: "];
    [phoneNumView appendString:self.orderInfo.oMobile];
    _phoneNum.text = phoneNumView;
    
    NSMutableString *totalPriceView = [NSMutableString string];
    [totalPriceView appendString:@"  Total Price: "];
    [totalPriceView appendString:self.orderInfo.oTotalprice];
    _totalPrice.text = totalPriceView;
    
    NSMutableString *youPaidView = [NSMutableString string];
    [youPaidView appendString:@"  You Paid: "];
    [youPaidView appendString:self.orderInfo.oPaidprice];
    _youPaid.text = youPaidView;

    _paymentType.text = @"  Payment Type: Credit Card";
}

- (IBAction)trackBtn:(UIButton *)sender {
    ShipmentTrackViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShipmentTrackViewController"];
    
    [[APIHandler sharedInstance] shipmentTrackWithApiKey:_apikey andUserId:_userId andOrderId:self.orderInfo.oId withCompletion:^(NSDictionary *result) {
        ctrl.shipStatus = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            [[self navigationController] pushViewController:ctrl animated:true];
        });
    }];
}


@end
