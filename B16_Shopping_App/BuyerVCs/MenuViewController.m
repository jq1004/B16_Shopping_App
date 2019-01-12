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
@interface MenuViewController ()<UITableViewDataSource,UITableViewDelegate>{
     NSArray *menuItems;
}

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    menuItems = @[@"profile", @"shop", @"myOrder", @"logout"];
//    [UIImage imageNamed:@"return_journey_denoter.png"];
    
   
//    _profileImgView.image = [UIImage imageNamed:@"harry-kane"];
    _profileImgView.layer.borderWidth = 2;
    _profileImgView.layer.borderColor = [UIColor colorWithRed:1.00 green:0.23 blue:0.82 alpha:1.0].CGColor;
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.width / 2;
    
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
