//
//  UserProfileViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "UserProfileViewController.h"
#import "SWRevealViewController.h"
#import "APIHandler.h"
#import "UserInfo.h"
#import "DataBaseManager.h"

@interface UserProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImgView;
@property (weak, nonatomic) IBOutlet UITextField *fnameTxtF;
@property (weak, nonatomic) IBOutlet UITextField *lnameTxtF;
@property (weak, nonatomic) IBOutlet UITextField *addressTxtF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxtF;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtF;
@property (weak, nonatomic) IBOutlet UIButton *imgBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;
@property (weak, nonatomic) IBOutlet UIButton *updateBtn;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBtn;



@end

@implementation UserProfileViewController
{
    NSString *userId;
    UserInfo *user;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuBtn.target = self.revealViewController;
    _menuBtn.action = @selector(revealToggle:);
    
    _userProfileImgView.layer.borderWidth = 2;
    _userProfileImgView.layer.borderColor = [UIColor colorWithRed:1.00 green:0.23 blue:0.82 alpha:1.0].CGColor;
    _userProfileImgView.layer.cornerRadius = _userProfileImgView.frame.size.width / 2;
    _imgBtn.layer.cornerRadius = _imgBtn.frame.size.width / 2;
    
    _cancelBtn.hidden = true;
    
    [self manageTxtFieldsWithChoice:false];
    
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    user = [[DataBaseManager sharedInstance] fetchUserInfoWithId:userId];
    
    _fnameTxtF.text = [user valueForKey:@"firstName"][0];
    _lnameTxtF.text = [user valueForKey:@"lastName"][0];
    _emailTxtF.text = [user valueForKey:@"email"][0];
    _mobileTxtF.text = [user valueForKey:@"mobile"][0];
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)manageTxtFieldsWithChoice :(Boolean *)choice {
    _fnameTxtF.enabled = choice;
    _lnameTxtF.enabled = choice;
    _emailTxtF.enabled = choice;
    _addressTxtF.enabled = choice;
    _mobileTxtF.enabled = choice;
}

- (IBAction)updateProfileBtnClicked:(UIButton *)sender {
    
    if (sender.tag == 0) {
        [_updateBtn setTitle:@"Save" forState:normal];
        sender.tag = 1;
        _cancelBtn.hidden = false;
        [self manageTxtFieldsWithChoice:true];
    } else {
        [_updateBtn setTitle:@"Update" forState:normal];
        sender.tag = 0;
        _cancelBtn.hidden = true;
        [self manageTxtFieldsWithChoice:false];
        
        if (![self.fnameTxtF.text  isEqual: @""] && ![self.lnameTxtF.text  isEqual: @""] && ![self.mobileTxtF.text  isEqual: @""] && ![self.emailTxtF.text  isEqual: @""])
        {
            
            [[APIHandler sharedInstance] updateProfileUserWithFirstName:self.fnameTxtF.text lastName:self.lnameTxtF.text address:self.addressTxtF.text email:self.emailTxtF.text mobile:self.mobileTxtF.text completionHandler:^(NSString *response) {
                if ([response isEqual: @"successfully updated"]) {
                    //show success message
                } else {
                    //show error message
                }
            }];
            
        } else {
            //show error : all required fields should be filled
        }
    }
    
}

- (IBAction)cancelUpdClicked:(UIButton *)sender {
    [_updateBtn setTitle:@"Update" forState:normal];
    _updateBtn.tag = 0;
    _cancelBtn.hidden = true;
    [self manageTxtFieldsWithChoice:false];
}


- (IBAction)pickImgBtnClicked:(UIButton *)sender {
}


@end
