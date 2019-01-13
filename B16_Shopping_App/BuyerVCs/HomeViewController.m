//
//  HomeViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "APIHandler.h"
#import "APIParser.h"
@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBtn;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self fetchCategoryInfo];
    [self fetchTopSellers];
}

- (void)setupUI {
    _menuBtn.target = self.revealViewController;
    _menuBtn.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
}

- (void)fetchCategoryInfo {
    [SVProgressHUD show];
    [[APIHandler sharedInstance] categoryApiCall:@"ed356eb00da50b9b227ff16faf6dd0b6" andUserId:@"1513" withCompletion:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] categoryParser:result andError:error withCompletion:^(Boolean *hasError, NSMutableArray<CategoryInfo *> *result) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Category info is missing" andMsg:@"Sorry, we can't fetch category info at this time, please try again later."];
                });
            } else {
                self.categories = result;
                
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
        
    }];
}

- (void)fetchTopSellers {
    [SVProgressHUD show];
    [[APIHandler sharedInstance] topSellersApiCall:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] topSellerParser:result andError:error withCompletion:^(Boolean *hasError, NSMutableArray<TopSellerInfo *> *result) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Top sellers info is missing" andMsg:@"Sorry, we can't fetch top sellers info at this time, please try again later."];
                });
            } else {
                self.topSellers = result;
            }
            dispatch_async(dispatch_get_main_queue(), ^{
                [SVProgressHUD dismiss];
            });
        }];
    }];
}

@end
