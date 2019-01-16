//
//  MenuViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"
#import "LoginViewController.h"
#import "DataBaseManager.h"
#import "UserInfo.h"

@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *menuItems;
    NSString *userId;
    UserInfo *user;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setUp];
    
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    user = [[DataBaseManager sharedInstance] fetchUserInfoWithId:userId];
}

- (void) setUp {
    menuItems = @[@"profile", @"shop", @"myOrder", @"Settings", @"logout"];
    _profileImgView.layer.borderWidth = 2;
    _profileImgView.layer.borderColor = [UIColor whiteColor].CGColor;
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.width / 2;
    _profileImgView.clipsToBounds = true;
    
    _tbv.tableFooterView = [[UIView alloc] init];
    
    self.revealViewController.rearViewRevealWidth =  self.view.frame.size.width-55;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    _userNameLbl.text = [NSString stringWithFormat:@"%@ %@", [user valueForKey:@"firstName"][0], [user valueForKey:@"lastName"][0]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",[user valueForKey:@"mobile"][0]]];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    if (image != nil) {
        _profileImgView.image = image;
    } else {
        _profileImgView.image = [UIImage imageNamed:@"profileImage"];
    }
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return menuItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tbv deselectRowAtIndexPath:indexPath animated:YES];
    NSInteger row = [indexPath row];
    if (row == 4){
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isLoggedIn"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:loginVC];
    }
}

@end
