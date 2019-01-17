//
//  ShipmentTrackViewController.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/16/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "ShipmentTrackViewController.h"
#import "SWRevealViewController.h"
#import "CartViewController.h"

@interface ShipmentTrackViewController ()
@property (weak, nonatomic) IBOutlet UILabel *shipIdLbl;
@property (weak, nonatomic) IBOutlet UIImageView *stepsBarImgV;
@property (weak, nonatomic) IBOutlet UILabel *stepsNameLbl;
@property (weak, nonatomic) IBOutlet UIImageView *stepsImgV;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBarBtn;

@end

@implementation ShipmentTrackViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _myBarBtn.target = self.revealViewController;
    _myBarBtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _shipIdLbl.text = _shipStatus[@"shipmentid"];
    
    if ([_shipStatus[@"shipmentstatus"] isEqualToString:@"1"]) {
        _stepsBarImgV.image = [UIImage imageNamed:@"step1"];
        _stepsNameLbl.text = @"Confirmed";
        _stepsImgV.image = [UIImage imageNamed:@"confirmed"];
    } else if ([_shipStatus[@"shipmentstatus"] isEqualToString:@"2"]) {
        _stepsBarImgV.image = [UIImage imageNamed:@"step2"];
        _stepsNameLbl.text = @"Packed";
        _stepsImgV.image = [UIImage imageNamed:@"packed"];
    } else if ([_shipStatus[@"shipmentstatus"] isEqualToString:@"3"]) {
        _stepsBarImgV.image = [UIImage imageNamed:@"step3"];
        _stepsNameLbl.text = @"On the way";
         _stepsImgV.image = [UIImage imageNamed:@"shipped"];
    } else if ([_shipStatus[@"shipmentstatus"] isEqualToString:@"4"]) {
        _stepsBarImgV.image = [UIImage imageNamed:@"step4"];
        _stepsNameLbl.text = @"Delivered";
        _stepsImgV.image = [UIImage imageNamed:@"delivered"];
    }
}

- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}
- (IBAction)backBtn:(UIBarButtonItem *)sender {
    [[self navigationController] popViewControllerAnimated:true];
}


@end
