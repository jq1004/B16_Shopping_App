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
@property (weak, nonatomic) IBOutlet UIButton *checkOutBtn;
@end

@implementation CartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    _userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    
    _tblView.delegate = self;
    _tblView.dataSource = self;
    
    _products = [[DataBaseManager sharedInstance] fetchcartWithUserId:_userId];
    [self fetchProductsInCart];
}

- (void)fetchProductsInCart {
    if (_products.count == 0) {
        _checkOutBtn.enabled = false;
        _checkOutBtn.backgroundColor = [UIColor lightGrayColor];
        _checkOutBtn.titleLabel.textColor = [UIColor grayColor];
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Empty" description:@"Continue Shopping!" type: TWMessageBarMessageTypeInfo duration:3];
    } else {
        _checkOutBtn.enabled = true;
        _checkOutBtn.backgroundColor = [UIColor colorWithHue:0.6389 saturation:0.99 brightness:0.57 alpha:1.0];
        _checkOutBtn.titleLabel.textColor = [UIColor whiteColor];
        _checkOutBtn.titleLabel.textColor = [UIColor grayColor];
    }
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
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure?" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        UIAlertAction *alertAction2 = [UIAlertAction actionWithTitle:@"Delete" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
            [[DataBaseManager sharedInstance] removeProductWithUserId:self.userId andProductId:self.products[indexPath.row].pId];
            [self.products removeObjectAtIndex:indexPath.row];
            [self fetchProductsInCart];
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tblView reloadData];
            });
        }];
        [alertController addAction:alertAction];
        [alertController addAction:alertAction2];
        [self presentViewController:alertController animated:true completion:nil];
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
