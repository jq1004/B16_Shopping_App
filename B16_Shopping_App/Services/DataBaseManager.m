//
//  DataBaseManager.m
//  B16_Shopping_App
//
//  Created by Hajar Mouaddine on 1/12/19.
//  Copyright © 2019 Da Chen. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DataBaseManager.h"

@interface DataBaseManager()

@end

@implementation DataBaseManager

+ (instancetype)sharedInstance
{
    static id shared = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (shared == nil) {
            shared = [[self alloc] init];
        }
    });
    
    return shared;
}

#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

//- (NSFetchedResultsController *)fetchedResultsControllerUser {
//    
//}

- (NSPersistentContainer *)persistentContainer {
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"B16_Shopping_App"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end
