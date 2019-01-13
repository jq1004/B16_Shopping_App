//
//  ProductListViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "ProductListViewController.h"

@interface ProductListViewController ()<UITableViewDataSource,UITableViewDelegate>{
    NSArray *productItems;
    }

@property (weak, nonatomic) IBOutlet UITableView *tbv;
@property (nonatomic,strong) NSArray *productArray;

//@property (nonatomic,strong) Product *product;
@end

@implementation ProductListViewController
@synthesize productArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 7;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //    return productArray.count;
    return 5;
}
//- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return 200;
//}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    //product = productArray[indexPath.row];
    //NSString *productName = product.productName;
    static NSString *cellIdentifier = @"cell";
    ProductListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    UIImage * img = [UIImage imageNamed:@"ua_shoe"];
    cell.productImgView.image = img;
    
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
