//
//  ProductDetailViewController.m
//  B16_Shopping_App
//
//  Created by Junqing li on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "ProductDetailViewController.h"
#import "DataBaseManager.h"
#import "SWRevealViewController.h"
#import "CartViewController.h"

@interface ProductDetailViewController ()

@property NSString *userId;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *myBarBtn;
@property (weak, nonatomic) IBOutlet UIButton *cartBtn;

@end

@implementation ProductDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _addToCart.layer.cornerRadius = 12;
    _productImgView.clipsToBounds = YES;
    _productImgView.layer.cornerRadius = 12;
    
    _myBarBtn.target = self.revealViewController;
    _myBarBtn.action = @selector(revealToggle:);
    
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    _userId = [[NSUserDefaults standardUserDefaults] stringForKey:@"userId"];
    
    if (_product.pQuantity == 0) {
        _cartBtn.enabled = false;
    } else {
        _cartBtn.enabled = true;
    }
    
    [self setUpDetailView];
}

- (void)setUpDetailView
{
    _priceLbl.text = _product.pPrice;
    _quantityLbl.text = _product.pQuantity;
    _descriptionTxtV.text = _product.pDiscription;
    _productImgView.image = _productImg;
    _titleLbl.text = _product.pName;
}

- (IBAction)addToCartBtn:(UIButton *)sender {
    BOOL doesExist = [[DataBaseManager sharedInstance] productExistWithUserId:_userId andProductId:_product.pId];
    if (doesExist) {
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Reminder" description:@"Product already in cart!" type: TWMessageBarMessageTypeInfo duration:5];
    } else {
        [[DataBaseManager sharedInstance] saveToCartWithProduc:_product andUserId:_userId];
        [[TWMessageBarManager sharedInstance] showMessageWithTitle:@"Success" description:@"Product added to cart!" type: TWMessageBarMessageTypeSuccess duration:5];
    }
}

- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}

- (IBAction)backBtn:(UIBarButtonItem *)sender {
    [[self navigationController] popViewControllerAnimated:true];
}


@end
