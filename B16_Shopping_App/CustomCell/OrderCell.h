//
//  OrderCell.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/16/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OrderInfo.h"

@interface OrderCell : UITableViewCell

@property NSDictionary *shipStatus;
@property OrderInfo *order;
@property (weak, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (weak, nonatomic) IBOutlet UIButton *trackBtn;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;

- (void)manageshipStatus;

@end
