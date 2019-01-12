//
//  UIViewController+UIViewControllerCategory.m
//  B16_Shopping_App
//
//  Created by Da Chen on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import "UIViewController+UIViewControllerCategory.h"

@implementation UIViewController (UIViewControllerCategory)

- (void)showAlert:(NSString *)title andMsg:(NSString *)msg {
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:title message:msg preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *alertAction = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleCancel handler:nil];
    [alertController addAction:alertAction];
    [self presentViewController:alertController animated:true completion:nil]; 
}

@end
