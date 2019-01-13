//
//  DataBaseManager.h
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/12/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "UserInfo.h"

@interface DataBaseManager : NSObject

@property (readonly, strong) NSPersistentContainer *persistentContainer;

- (NSPersistentContainer *)persistentContainer;

+ (instancetype)sharedInstance;

- (void)saveContext;

- (void)saveUserWithUser :(UserInfo *)user;

- (Boolean)doesExistWithId :(NSString *)Id;

- (UserInfo*)fetchUserInfoWithId :(NSString *)Id;

- (void)updateUserWithUser :(UserInfo *)user;

@end
