//
//  ProductListViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "ProductListViewController.h"
#import "ProductListCell.h"
#import "APIHandler.h"
#import "APIParser.h"
#import "ProductDetailViewController.h"
#import "SWRevealViewController.h"
#import "CartViewController.h"

@interface ProductListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *productItems;
    }

@property (weak, nonatomic) IBOutlet UITableView *tbv;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBarBtn;

@end

@implementation ProductListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = [[NSMutableArray alloc] init];
    self.productImgs = [[NSMutableArray alloc] init];
    
    _myBarBtn.target = self.revealViewController;
    _myBarBtn.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    
    self.tbv.delegate = self;
    self.tbv.dataSource = self;
    
    [self fetchProductInfo];
}
- (void)fetchProductInfo {
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey: @"userId"];
    NSString *userapikey = [[NSUserDefaults standardUserDefaults] valueForKey: @"appapikey"];

    [SVProgressHUD show];
    dispatch_group_t groupC = dispatch_group_create();
    dispatch_group_enter(groupC);
    dispatch_group_t imgGroupC = dispatch_group_create();
    [[APIHandler sharedInstance] productApiCall: userapikey andUserId:userId andCategoryId:_cid andSubCategoryId:_scid withCompletion:^(NSData *result, NSError *error) {
        [[APIParser sharedInstance] productParser:result andError:error withCompletion:^(Boolean *hasError, NSMutableArray<ProductInfo *> *result) {
            if (hasError) {
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self showAlert:@"Product info is missing" andMsg:@"Sorry, we can't fetch product info at this time, please try again later."];
                });
            } else {
                self.products = result;
                
                for (int i = 0; i < result.count; i++) {
                    dispatch_group_enter(imgGroupC);
                    [[APIHandler sharedInstance] downloadImg:result[i].pImageUrl withCompletion:^(UIImage *img) {
                        if (img != nil){
                        [self.productImgs addObject:img];
                        } else {
                            [self.productImgs addObject:[UIImage imageNamed:@"not_found"]];
                        }
                         dispatch_group_leave(imgGroupC);
                    }];
                }
            }
            dispatch_group_notify(imgGroupC, dispatch_get_main_queue(), ^{
                dispatch_group_leave(groupC);
            });
            dispatch_group_notify(groupC, dispatch_get_main_queue(), ^{
                [self.tbv reloadData];
                [SVProgressHUD dismiss];
            });
        }];
        
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _products.count;
    
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 320;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.productImgView.image = _productImgs[indexPath.row];
    cell.productName.text = _products[indexPath.row].pName;
    cell.productPrice.text = _products[indexPath.row].pPrice;
    cell.productQuantity.text = _products[indexPath.row].pQuantity;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tbv deselectRowAtIndexPath:indexPath animated:YES];
    
    ProductDetailViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ProductDetailViewController"];
    ctrl.product = [[ProductInfo alloc] initWithInfo:_products[indexPath.row].pId andProductName:_products[indexPath.row].pName andProductpQuantity:_products[indexPath.row].pQuantity andProductPrice:_products[indexPath.row].pPrice andProductDiscription:_products[indexPath.row].pDiscription andProductImageUrl:_products[indexPath.row].pImageUrl];
    ctrl.productImg = _productImgs[indexPath.row];
    [[self navigationController] pushViewController:ctrl animated:true];
}

- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}


@end
