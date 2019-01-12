//
//  UIViewController+UIViewControllerCategory.h
//  B16_Shopping_App
//
//  Created by Da Chen on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIViewController (UIViewControllerCategory)

- (void)showAlert:(NSString *)title andMsg:(NSString *)msg;

@end

NS_ASSUME_NONNULL_END
