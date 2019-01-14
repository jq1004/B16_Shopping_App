//
//  UserProfileViewController.h
//  B16_Shopping_App
//
//  Created by Junqing li on 1/11/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UserProfileViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate>
- (void)manageTxtFieldsWithChoice :(Boolean *)choice;

@end

NS_ASSUME_NONNULL_END