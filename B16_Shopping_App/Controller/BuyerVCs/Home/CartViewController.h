//
//  CartViewController.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/14/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ProductInfo.h"

@interface CartViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property NSArray *products;

@end
