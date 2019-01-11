//
//  MenuViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "MenuViewController.h"
#import "SWRevealViewController.h"

@interface MenuViewController ()

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [UIImage imageNamed:@"return_journey_denoter.png"];
    
    _profileImgView.layer.cornerRadius = _profileImgView.frame.size.height/2;
    _profileImgView.clipsToBounds = YES;
    _profileImgView.image = [UIImage imageNamed:@"harry-kane"];
    
    self.revealViewController.rearViewRevealWidth =  self.view.frame.size.width-120;
//    self.revealViewController.rearViewRevealOverdraw = 0;
//    self.view.frame.size.width-100;
    // Do any additional setup after loading the view.
}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
