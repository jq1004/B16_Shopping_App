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
    
    menuItems = @[@"profile", @"shop", @"myOrder", @"logout"];
    
    userId = [[NSUserDefaults standardUserDefaults] valueForKey:@"userId"];
    user = [[DataBaseManager sharedInstance] fetchUserInfoWithId:userId];
    
    _userNameLbl.text = [NSString stringWithFormat:@"%@ %@", [user valueForKey:@"firstName"][0], [user valueForKey:@"lastName"][0]];
 
    _profileImgView.layer.borderWidth = 2;
    _profileImgView.layer.borderColor = [UIColor colorWithRed:1.00 green:0.23 blue:0.82 alpha:1.0].CGColor;
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.width / 2;
    _profileImgView.clipsToBounds = true;
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [paths objectAtIndex:0]; //Get the docs directory
    NSString *filePath = [documentsPath stringByAppendingPathComponent:[NSString stringWithFormat:@"/%@.png",[user valueForKey:@"mobile"][0]]];
    NSData *pngData = [NSData dataWithContentsOfFile:filePath];
    UIImage *image = [UIImage imageWithData:pngData];
    _profileImgView.image = image;
    
    self.revealViewController.rearViewRevealWidth =  self.view.frame.size.width-105;

    // Do any additional setup after loading the view.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return menuItems.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSInteger row = [indexPath row];
    if (row == 3){
        [[NSUserDefaults standardUserDefaults] setBool:false forKey:@"isLoggedIn"];
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        LoginViewController *loginVC = [storyboard instantiateViewControllerWithIdentifier:@"LoginVC"];
        [[UIApplication sharedApplication].keyWindow setRootViewController:loginVC];
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{

    NSIndexPath *indexPath = [self.tbv indexPathForSelectedRow];
    UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;

}

@end
