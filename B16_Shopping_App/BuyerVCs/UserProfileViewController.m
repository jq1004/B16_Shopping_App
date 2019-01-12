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

@interface UserProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *userProfileImgView;
@property (weak, nonatomic) IBOutlet UITextField *fnameTxtF;
@property (weak, nonatomic) IBOutlet UITextField *lnameTxtF;
@property (weak, nonatomic) IBOutlet UITextField *addressTxtF;
@property (weak, nonatomic) IBOutlet UITextField *mobileTxtF;
@property (weak, nonatomic) IBOutlet UITextField *emailTxtF;


@end

@implementation UserProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _menuBarBtn.target = self.revealViewController;
    _menuBarBtn.action = @selector(revealToggle:);
    
    _userProfileImgView.layer.borderWidth = 2;
    _userProfileImgView.layer.borderColor = [UIColor colorWithRed:1.00 green:0.23 blue:0.82 alpha:1.0].CGColor;
    _userProfileImgView.layer.cornerRadius = _userProfileImgView.frame.size.width / 2;
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (IBAction)updateProfileBtnClicked:(UIButton *)sender {
    if (![self.fnameTxtF.text  isEqual: @""] && ![self.lnameTxtF.text  isEqual: @""] && ![self.mobileTxtF.text  isEqual: @""] && ![self.addressTxtF.text  isEqual: @""] && ![self.emailTxtF.text  isEqual: @""])
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

@end
