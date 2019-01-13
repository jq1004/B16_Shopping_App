//
//  CategoryCell.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/13/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CategoryCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *categoryTitle;

@end

NS_ASSUME_NONNULL_END
