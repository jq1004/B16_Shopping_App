//
//  CartViewController.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "CartViewController.h"
#import "DataBaseManager.h"
#import "CheckoutProductCell.h"
#import "CheckOutViewController.h"

@interface CartViewController()

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property NSString *userId;
@end

@implementation CartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    
    _tblView.delegate = self;
    _tblView.dataSource = self;
    
    _products = [[DataBaseManager sharedInstance] fetchcartWithUserId:_userId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _products.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CheckoutProductCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.product = _products[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.tblView deselectRowAtIndexPath:indexPath animated:YES];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [[DataBaseManager sharedInstance] removeProductWithUserId:_userId andProductId:_products[indexPath.row].pId];
        [_products removeObjectAtIndex:indexPath.row];
        [_tblView reloadData];
    }
}

- (IBAction)checkOutBtn:(UIButton *)sender {
    CheckOutViewController *checkoutVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CheckOutVC"];
    
    NSMutableDictionary *qtys = [[NSMutableDictionary alloc] init];
    for (NSInteger i = 0; i < [_tblView numberOfRowsInSection:0]; ++i)
    {
        NSString *pId = [[[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] product] pId];
        if (pId == nil) {
            pId = @"nil"; 
        }
        qtys[pId] = [[_tblView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i inSection:0]] qty];
    }
    
    checkoutVC.products = _products;
    checkoutVC.qtys = qtys;
    [[self navigationController] pushViewController:checkoutVC animated:true];
}

@end
