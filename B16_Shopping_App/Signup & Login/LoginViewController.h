//
//  LoginViewController.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/10/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LoginViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneText;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIButton *goToSignUpPageBtn;

@property (weak, nonatomic) IBOutlet UIButton *forgetPasswrodBtn;

- (IBAction)login:(id)sender;
- (IBAction)goToSignUpPageBtnTapped:(id)sender;
- (IBAction)forgotPwdBtnTapped:(id)sender;

@end

NS_ASSUME_NONNULL_END
