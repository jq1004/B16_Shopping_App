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

@interface ProductListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *productItems;
    }

@property (weak, nonatomic) IBOutlet UITableView *tbv;

@end

@implementation ProductListViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.products = [[NSMutableArray alloc] init];
    self.productImgs = [[NSMutableArray alloc] init];
    
    self.tbv.delegate = self;
    self.tbv.dataSource = self;
    
    [self fetchProductInfo];
}
- (void)fetchProductInfo {
    NSString *userId = [[NSUserDefaults standardUserDefaults] valueForKey: @"userId"];
//    NSString *userapikey = [[NSUserDefaults standardUserDefaults] valueForKey: @"appapikey"];
    NSString *userapikey = @"c6020622f9ce6f2e0547272d6334c260";
    [SVProgressHUD show];
    dispatch_group_t groupC = dispatch_group_create();
    dispatch_group_enter(groupC);
    dispatch_group_t imgGroupC = dispatch_group_create();
    [[APIHandler sharedInstance] productApiCall: userapikey andUserId:userId andCategoryId:@"107" andSubCategoryId:@"205" withCompletion:^(NSData *result, NSError *error) {
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
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    NSLog(@"print img array %lu",(unsigned long)_productImgs.count);
    return _products.count;
    
//    return _productImgs.count;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 280;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIdentifier = @"cell";
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
//    UIImage * img = [UIImage imageNamed:@"ua_shoe"];
    cell.productImgView.image = _productImgs[indexPath.row];
    cell.productName.text = _products[indexPath.row].pName;
    cell.productPrice.text = _products[indexPath.row].pPrice;
    cell.productQuantity.text = _products[indexPath.row].pQuantity;
    return cell;
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
