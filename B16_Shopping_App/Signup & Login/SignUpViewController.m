//
//  SignUpViewController.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SignUpViewController.h"
#import "APIHandler.h"

@interface SignUpViewController()

@property (weak, nonatomic) IBOutlet UITextField *fnameTxtF;
@property (weak, nonatomic) IBOutlet UITextField *lnameTxtF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxtF;
@property (weak, nonatomic) IBOutlet UITextField *addressTxtF;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtF;
@property (weak, nonatomic) IBOutlet UITextField *pwdTxtF;
@property (weak, nonatomic) IBOutlet UITextField *cpwdTxtF;
@property (weak, nonatomic) IBOutlet UIButton *buyerBtn;
@property (weak, nonatomic) IBOutlet UIButton *sellerBtn;
@property (weak, nonatomic) IBOutlet UITextField *taxIdTxtF;
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@property NSString *UserType;

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backBtn.layer.borderWidth = 1;
    self.backBtn.layer.borderColor = [UIColor colorWithRed:1.00 green:0.23 blue:0.82 alpha:1.0].CGColor;
    self.taxIdTxtF.hidden = true;
    self.sellerBtn.imageView.image = [UIImage imageNamed:@"radioE"];
    self.UserType = @"Buyer";
}

- (IBAction)buyerBtnClicked:(UIButton *)sender {
    self.UserType = @"Buyer";
    self.buyerBtn.imageView.image = [UIImage imageNamed:@"radioF"];
    self.sellerBtn.imageView.image = [UIImage imageNamed:@"radioE"];
    self.taxIdTxtF.hidden = true;
}

- (IBAction)sellerBtnClicked:(UIButton *)sender {
    self.UserType = @"Seller";
    self.buyerBtn.imageView.image = [UIImage imageNamed:@"radioE"];
    self.sellerBtn.imageView.image = [UIImage imageNamed:@"radioF"];
    self.taxIdTxtF.hidden = false;
}

- (IBAction)signUpBtnClicked:(UIButton *)sender {
    
    if (![self.fnameTxtF.text  isEqual: @""] && ![self.lnameTxtF.text  isEqual: @""] && ![self.mobileTxtF.text  isEqual: @""] && ![self.addressTxtF.text  isEqual: @""] && ![self.emailTxtF.text  isEqual: @""] && ![self.pwdTxtF.text  isEqual: @""] && ![self.cpwdTxtF.text  isEqual: @""] && ![self.UserType  isEqual: @""]) {
        
        if ([self.pwdTxtF.text isEqual: self.cpwdTxtF.text]) {
            
            [[APIHandler sharedInstance] signUpUserWithFirstName:self.fnameTxtF.text lastName:self.lnameTxtF.text address:self.addressTxtF.text password:self.pwdTxtF.text email:self.emailTxtF.text mobile:self.mobileTxtF.text completionHandler:^(NSString *response) {
                if ([response isEqual:@"successfully registered"]) {
                    [self dismissViewControllerAnimated:true completion:nil];
                    //show success message
                } else {
                    //show error message
                }
            }];
            
        } else {
            //show error : password mismatch
        }
        
    } else {
        //show error : fill in all reauired fields
    }
}

- (IBAction)backBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
