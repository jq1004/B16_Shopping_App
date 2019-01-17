//
//  SubCategoryViewController.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "SubCategoryViewController.h"
#import "SWRevealViewController.h"
#import "APIHandler.h"
#import "APIParser.h"
#import "SubCategoryCell.h"
#import "ProductListViewController.h"
#import "CartViewController.h"

@interface SubCategoryViewController()
@property (weak, nonatomic) IBOutlet UIPageControl *pageCtrl;
@property (weak, nonatomic) IBOutlet UIScrollView *topSellerScroller;
@property (weak, nonatomic) IBOutlet UITableView *tbView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *menuBtn;

@end

@implementation SubCategoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.cId = @"107";
    [self setup];
    [self fetchSubCategoryInfo];
    [self fetchTopSellers];
    
}

- (void)setup {
    _menuBtn.target = self.revealViewController;
    _menuBtn.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.subcategoryImgs = [[NSMutableArray alloc] init];
    self.topSellerImgs = [[NSMutableArray alloc] init];
    
    _tbView.delegate = self;
    _tbView.dataSource = self;
    _tbView.tableFooterView = [[UIView alloc] init];
}

- (void)fetchSubCategoryInfo {
    [SVProgressHUD show];
    dispatch_group_t groupC = dispatch_group_create();
    dispatch_group_enter(groupC);
    dispatch_group_t imgGroupC = dispatch_group_create();
    [[APIHandler sharedInstance] subCategoryApiCall:[[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"] andCatId:self.cId andUserId:[[NSUserDefaults standardUserDefaults] stringForKey:@"userId"] withCompletion:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] subCategoryParser:result andError:error withCompletion:^(Boolean *hasError, NSMutableArray<SubCategoryInfo *> *result) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    //show error: couldnt get subcategory info
                });
            } else {
                self.subcategories = result;
                for (int i = 0; i < result.count; i++) {
                    dispatch_group_enter(imgGroupC);
                    [[APIHandler sharedInstance] downloadImg:result[i].scImageUrl withCompletion:^(UIImage *img) {
                        if (img != nil){
                            [self.subcategoryImgs addObject:img];
                        } else {
                            [self.subcategoryImgs addObject:[UIImage imageNamed:@"not_found"]];
                        }
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
                    //show error: top sellers info is missing
                });
            } else {
                self.topSellers = result;
                for (int i = 0; i < result.count; i++) {
                    dispatch_group_enter(imgGroupT);
                    [[APIHandler sharedInstance] downloadImg:result[i].sellerLogo withCompletion:^(UIImage *img) {
                        if (img != nil){
                            [self.topSellerImgs addObject:img];
                        } else {
                            [self.topSellerImgs addObject:[UIImage imageNamed:@"not_found"]];
                        }
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
    return _subcategoryImgs.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SubCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SubCategoryCell" forIndexPath:indexPath];
        cell.leftLabel.text = _subcategories[indexPath.row].scName;
        cell.leftImgView.image = _subcategoryImgs[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 180;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tbView deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductListViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductListViewController"];
    ctrl.cid = _cId;
    ctrl.scid = _subcategories[indexPath.row].scId;
    [[self navigationController] pushViewController:ctrl animated:true];
}


- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}

- (IBAction)backBtn:(UIBarButtonItem *)sender {
    [[self navigationController] popViewControllerAnimated:true];
}



@end
