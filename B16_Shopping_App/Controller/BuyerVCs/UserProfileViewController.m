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
    _userProfileImgView.clipsToBounds = true;
    _imgBtn.layer.cornerRadius = _imgBtn.frame.size.width / 2;
    
    _cancelBtn.hidden = true;
    
    [self manageTxtFieldsWithChoice:false];
    _mobileTxtF.enabled = false;
    
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    user = [[DataBaseManager sharedInstance] fetchUserInfoWithId:userId];
    
    _fnameTxtF.text = [user valueForKey:@"firstName"][0];
    _lnameTxtF.text = [user valueForKey:@"lastName"][0];
    _emailTxtF.text = [user valueForKey:@"email"][0];
    _mobileTxtF.text = [user valueForKey:@"mobile"][0];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",_mobileTxtF.text]];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    if (image != nil) {
        _userProfileImgView.image = image;
    } else {
        _userProfileImgView.image = [UIImage imageNamed:@"profileImage"];
    }
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
}

- (void)manageTxtFieldsWithChoice :(Boolean *)choice {
    _fnameTxtF.enabled = choice;
    _lnameTxtF.enabled = choice;
    _emailTxtF.enabled = choice;
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
            
            [[APIHandler sharedInstance] updateProfileUserWithFirstName:self.fnameTxtF.text lastName:self.lnameTxtF.text email:self.emailTxtF.text mobile:self.mobileTxtF.text completionHandler:^(NSString *response) {
                if ([response isEqual: @"successfully updated"]) {
                    dispatch_async(dispatch_get_main_queue(), ^{
                        UserInfo *userinfo = [[UserInfo alloc] initWithInfo:self->userId andFirstName:self.fnameTxtF.text andLastName:self.lnameTxtF.text andEmail:self.emailTxtF.text andMobile:self.mobileTxtF.text andAppApiKey:@""];
                        [[DataBaseManager sharedInstance] updateUserWithUser:userinfo];
                    });                    
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
        
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.allowsEditing = YES;
    
        if (![UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
            picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        } else {
            picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        }
    
        [self presentViewController:picker animated:YES completion:NULL];
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info
{
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    self.userProfileImgView.image = chosenImage;
    
    NSData *pngData = UIImagePNGRepresentation(chosenImage);
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",_mobileTxtF.text]]; //Add the file name
    [pngData writeToFile:filePath atomically:YES]; //Write the file
        
    [picker dismissViewControllerAnimated:YES completion:NULL];
        
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}


@end
