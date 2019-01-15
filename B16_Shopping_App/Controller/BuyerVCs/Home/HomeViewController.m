//
//  HomeViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "HomeViewController.h"
#import "SWRevealViewController.h"
#import "SubCategoryViewController.h"
#import "APIHandler.h"
#import "APIParser.h"
#import "CategoryCell.h"
#import "CartViewController.h"

@interface HomeViewController ()

@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *topSellerScroller;
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (weak, nonatomic) IBOutlet UITableView *tbView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setup];
    [self fetchCategoryInfo];
    [self fetchTopSellers];
}

- (void)setup {

    _menuBtn.target = self.revealViewController;
    _menuBtn.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.categoryImgs = [[NSMutableArray alloc] init];
    self.topSellerImgs = [[NSMutableArray alloc] init];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tableFooterView = [[UIView alloc] init];
}

- (void)fetchCategoryInfo {
    [SVProgressHUD show];
    dispatch_group_t groupC = dispatch_group_create();
    dispatch_group_enter(groupC);
    dispatch_group_t imgGroupC = dispatch_group_create();
    [[APIHandler sharedInstance] categoryApiCall:[[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"] andUserId:[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"] withCompletion:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] categoryParser:result andError:error withCompletion:^(Boolean *hasError, NSMutableArray<CategoryInfo *> *result) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Category info is missing" andMsg:@"Sorry, we can't fetch category info at this time, please try again later."];
                });
            } else {
                self.categories = result;
                for (int i = 0; i < result.count; i++) {
                    dispatch_group_enter(imgGroupC);
                    [[APIHandler sharedInstance] downloadImg:result[i].cImageUrl withCompletion:^(UIImage *img) {
                        [self.categoryImgs addObject:img];
                        dispatch_group_leave(imgGroupC);
                    }];
                }
            }
            dispatch_group_notify(imgGroupC, dispatch_get_main_queue(), ^{
                dispatch_group_leave(groupC);
            });
            dispatch_group_notify(groupC, dispatch_get_main_queue(), ^{
                [self.tbView reloadData];
                [SVProgressHUD dismiss];
            });
        }];
        
    }];
}

- (void)fetchTopSellers {
    [SVProgressHUD show];
    dispatch_group_t groupT = dispatch_group_create();
    dispatch_group_enter(groupT);
    dispatch_group_t imgGroupT = dispatch_group_create();
    [[APIHandler sharedInstance] topSellersApiCall:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] topSellerParser:result andError:error withCompletion:^(Boolean *hasError, NSMutableArray<TopSellerInfo *> *result) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Top sellers info is missing" andMsg:@"Sorry, we can't fetch top sellers info at this time, please try again later."];
                });
            } else {
                self.topSellers = result;
                for (int i = 0; i < result.count; i++) {
                    dispatch_group_enter(imgGroupT);
                    [[APIHandler sharedInstance] downloadImg:result[i].sellerLogo withCompletion:^(UIImage *img) {
                        [self.topSellerImgs addObject:img];
                        dispatch_group_leave(imgGroupT);
                    }];
                }
            }
             dispatch_group_notify(imgGroupT, dispatch_get_main_queue(), ^{
                dispatch_group_leave(groupT);
            });
             dispatch_group_notify(groupT, dispatch_get_main_queue(), ^{
                 self.pageCtrl.numberOfPages = result.count;
                 CGRect frame = CGRectMake(0.0, 0.0, 0.0, 0.0);
                 for (int i = 0; i < result.count; i++) {
                     frame.origin.x = self.topSellerScroller.frame.size.width * (CGFloat)i;
                     frame.size = self.topSellerScroller.frame.size;
                     
                     UIImageView *imgView = [[UIImageView alloc] initWithFrame:frame];
                     imgView.image = self.topSellerImgs[i];
                     [self.topSellerScroller addSubview:imgView];
                 }
                 self.topSellerScroller.contentSize = CGSizeMake(self.topSellerScroller.frame.size.width * (CGFloat)result.count, self.topSellerScroller.frame.size.height);
                 self.topSellerScroller.delegate = self;
                 [SVProgressHUD dismiss];
            });
        }];
    }];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    int pageNumber = _topSellerScroller.contentOffset.x / _topSellerScroller.frame.size.width;
    _pageCtrl.currentPage = pageNumber;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _categoryImgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CategoryCell" forIndexPath:indexPath];
    cell.img.image = self.categoryImgs[indexPath.row];
    cell.categoryTitle.text = self.categories[indexPath.row].cName;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tbView deselectRowAtIndexPath:indexPath animated:YES];
    
    SubCategoryViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"SubCategoryViewController"];
    ctrl.cId = self.categories[indexPath.row].cId;
    [[self navigationController] pushViewController:ctrl animated:true];
}

- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}


@end
