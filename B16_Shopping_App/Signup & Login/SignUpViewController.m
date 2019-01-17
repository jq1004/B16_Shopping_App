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
@property (weak, nonatomic) IBOutlet UIButton *backBtn;

@end

@implementation SignUpViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.backBtn.layer.borderWidth = 1;
    self.backBtn.layer.borderColor = [UIColor colorWithRed:12 green:31 blue:143 alpha:0.94].CGColor;
}
- (BOOL)validatePhoneWithString:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}
- (BOOL)validateEmailWithString:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

- (IBAction)signUpBtnClicked:(UIButton *)sender {
    if(![self.emailTxtF.text  isEqual: @""] &&![self validateEmailWithString:self.emailTxtF.text]){
         [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Email is not correct!" type: TWMessageBarMessageTypeError duration:5];
        
    }
    else if(![self.mobileTxtF.text  isEqual: @""] && ![self validatePhoneWithString:self.mobileTxtF.text]){
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Mobile number is not correct!" type: TWMessageBarMessageTypeError duration:5];
    }
    else if(![self.pwdTxtF.text  isEqual: @""] && (self.pwdTxtF.text.length < 6|| self.pwdTxtF.text.length>10)){
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Password length should be more than 5 and less than 11!" type: TWMessageBarMessageTypeError duration:5];
    }
    else if(![self.cpwdTxtF.text  isEqual: @""] && (self.cpwdTxtF.text.length < 6|| self.cpwdTxtF.text.length>10)){
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Password length should be more than 5 and less than 11!" type: TWMessageBarMessageTypeError duration:5];
    }

    else if (![self.fnameTxtF.text  isEqual: @""] && ![self.lnameTxtF.text  isEqual: @""] && ![self.mobileTxtF.text  isEqual: @""] && ![self.addressTxtF.text  isEqual: @""] && ![self.emailTxtF.text  isEqual: @""] && ![self.pwdTxtF.text  isEqual: @""] && ![self.cpwdTxtF.text  isEqual: @""]) {
        
        if ([self.pwdTxtF.text isEqual: self.cpwdTxtF.text]) {
            
            [[APIHandler sharedInstance] signUpUserWithFirstName:self.fnameTxtF.text lastName:self.lnameTxtF.text address:self.addressTxtF.text password:self.pwdTxtF.text email:self.emailTxtF.text mobile:self.mobileTxtF.text completionHandler:^(NSString *response) {
                if ([response isEqual:@"successfully registered"]) {
                    [self dismissViewControllerAnimated:true completion:nil];
                    dispatch_async(dispatch_get_main_queue(), ^{
                         [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Success" description:@"You have successfully registerd. Shop your way out!" type: TWMessageBarMessageTypeSuccess duration:5];
                    });
                    
                } else {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:response type: TWMessageBarMessageTypeError duration:5];
                    });
                }
            }];
            
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Password Mismatch!" type: TWMessageBarMessageTypeError duration:5];
            });
        }
        
    } else {
        dispatch_async(dispatch_get_main_queue(), ^{
            [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Error" description:@"Please fill in all required fields!" type: TWMessageBarMessageTypeError duration:5];
        });
    }
}

- (IBAction)backBtnClicked:(UIButton *)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

@end
