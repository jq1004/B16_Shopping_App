//
//  MyOrderViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "MyOrderViewController.h"
#import "SWRevealViewController.h"
#import "OrderCell.h"
#import "APIHandler.h"
#import "UserInfo.h"
#import "DataBaseManager.h"
#import "ShipmentTrackViewController.h"
#import "CartViewController.h"

@interface MyOrderViewController ()

@property (weak, nonatomic) IBOutlet UITableView *tblView;
@property NSString *userId;
@property NSString *apikey;
@property UserInfo *user;
@property NSDictionary *shipStatus;
@property NSMutableArray *shiparray;

@end

@implementation MyOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _myBarBtn.target = self.revealViewController;
    _myBarBtn.action = @selector(revealToggle:);
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    // Do any additional setup after loading the view.
    
    _shiparray = [[NSMutableArray alloc] init];
    
    _tblView.delegate = self;
    _tblView.dataSource = self;
    _tblView.tableFooterView = [[UIView alloc] init];
    
    _userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    _user = [[DataBaseManager sharedInstance] fetchUserInfoWithId:_userId];
    _apikey = [[NSUserDefaults standardUserDefaults] stringForKey:@"appapikey"];
    
    [self fetchOrderHistory];
}

-(void)fetchOrderHistory
{
    [SVProgressHUD show];
    [[APIHandler sharedInstance] orderHistoryWithApiKey:_apikey andUserId:_userId andMobile:[_user valueForKey:@"mobile"][0] withCompletion:^(NSArray *result) {
        if (result != nil) {
            self.orders = result;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tblView reloadData];
                [SVProgressHUD dismiss];
            });
        } else {
            dispatch_async(dispatch_get_main_queue(), ^{
                [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Info" description:@"No Data" type: TWMessageBarMessageTypeInfo duration:5];
                [SVProgressHUD dismiss];
            });
        }
    }];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _orders.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    OrderCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    cell.order = _orders[indexPath.row];
    [cell.trackBtn addTarget:self action:@selector(push:) forControlEvents:UIControlEventTouchUpInside];
    [[APIHandler sharedInstance] shipmentTrackWithApiKey:_apikey andUserId:_userId andOrderId:_orders[indexPath.row].oId withCompletion:^(NSDictionary *result) {
        cell.shipStatus = result;
        dispatch_async(dispatch_get_main_queue(), ^{
            cell.trackBtn.tag = indexPath.row;
        });
        [self.shiparray addObject:result];
        [cell manageshipStatus];
    }];
   return cell;
}

- (void)push :(UIButton *) sender
{
    ShipmentTrackViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"ShipmentTrackViewController"];
    ctrl.shipStatus = _shiparray[sender.tag];
    [[self navigationController] pushViewController:ctrl animated:true];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 87;
}

- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}


@end
