//
//  ResetPasswordViewController.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "ResetPasswordViewController.h"
#import "APIHandler.h"
#import "DataBaseManager.h"
#import "UserInfo.h"

@interface ResetPasswordViewController ()

@property (weak, nonatomic) IBOutlet UITextField *oldPasswordTxtF;
@property (weak, nonatomic) IBOutlet UITextField *NewPasswordTxtF;

@end

@implementation ResetPasswordViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (IBAction)resetBtnClicked:(UIButton *)sender {
    
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    UserInfo *user = [[DataBaseManager sharedInstance] fetchUserInfoWithId:userId];
    
    if (![self.oldPasswordTxtF.text  isEqual: @""] && ![self.NewPasswordTxtF.text  isEqual: @""]) {
        [[APIHandler sharedInstance]resetUserPasswordWithMobile:[user valueForKey:@"mobile"][0] oldPassword:self.oldPasswordTxtF.text newPassword:self.NewPasswordTxtF.text completionHandler:^(NSString *response) {
            if ([response isEqual: @"password reset successfully"]) {
                //show success message
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isLoggedIn"];
                    [self dismissViewControllerAnimated:true completion:nil];
                });
            } else if ([response isEqual: @"old password mismatch"]) {
                //show error password mismatch
            } else {
                //show error : wrong mobile phone
            }
        }];
    }
    
}

@end

