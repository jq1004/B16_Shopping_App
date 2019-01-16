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
    [[DataBaseManager sharedInstance] saveToCartWithProduc:_product andUserId:_userId];
    //show alert success
}

- (IBAction)cartBtn:(UIBarButtonItem *)sender {
    CartViewController *ctrl = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"CartViewController"];
    [[self navigationController] pushViewController:ctrl animated:true];
}



@end
