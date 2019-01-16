//
//  SettingsViewController.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/15/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SWRevealViewController.h"
#import "SettingsViewController.h"

@interface SettingsViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBarBtn;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
    _myBarBtn.target = self.revealViewController;
    _myBarBtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

@end
