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

#pragma mark - core Data Access Methods

- (void)saveUserWithUser :(UserInfo *)user
{
    NSManagedObject *userEntity = [NSEntityDescription insertNewObjectForEntityForName:@"User" inManagedObjectContext:self.persistentContainer.viewContext];
    [userEntity setValue: user.userId forKey:@"id"];
    [userEntity setValue: user.firstName forKey:@"firstname"];
    [userEntity setValue: user.lastName forKey:@"lastname"];
    [userEntity setValue: user.email forKey:@"email"];
    [userEntity setValue: user.mobile forKey:@"mobile"];
    [userEntity setValue: user.appapikey forKey:@"appapikey"];
    [self saveContext];
}

- (Boolean)doesExistWithId :(NSString *)Id
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@",Id]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 0) {
        return false;
    } else {
        return true;
    }
}

- (UserInfo*)fetchUserInfoWithId :(NSString *)Id
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    UserInfo *user;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@",Id]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 1) {
         user = [[UserInfo alloc] initWithInfo:[result valueForKey:@"id"] andFirstName:[result valueForKey:@"firstname"] andLastName:[result valueForKey:@"lastname"] andEmail:[result valueForKey:@"email"] andMobile:[result valueForKey:@"mobile"] andAppApiKey:[result valueForKey:@"appapikey"]];
    }
    
    
    return user;
}

- (void)updateUserWithUser :(UserInfo *)user
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@",[user valueForKey:@"userId"]]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 1) {
        [result setValue:[user valueForKey:@"firstName"] forKey:@"firstname"];
        [result setValue:[user valueForKey:@"lastName"] forKey:@"lastname"];
        [result setValue:[user valueForKey:@"email"] forKey:@"email"];
        [result setValue:[user valueForKey:@"mobile"] forKey:@"mobile"];
        [self saveContext];
    }
    
}

- (void)saveToCartWithProduc : (ProductInfo *)product andUserId:(NSString *)userId
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@",userId]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 1) {
        NSObject *user = result[0];
        NSManagedObject *cartEntity = [NSEntityDescription insertNewObjectForEntityForName:@"Cart" inManagedObjectContext:context];
        [cartEntity setValue:product.pId forKey:@"productId"];
        [cartEntity setValue:product.pName forKey:@"productName"];
        [cartEntity setValue:product.pPrice forKey:@"productPrice"];
        [cartEntity setValue:product.pQuantity forKey:@"productQty"];
        [cartEntity setValue:product.pImageUrl forKey:@"productImgUrl"];
        
        [[user mutableSetValueForKey:@"products"] addObject:cartEntity];
        [self saveContext];
    }
}

- (NSArray<ProductInfo *> *)fetchcartWithUserId :(NSString *)userId
{
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSArray *products = [[NSArray alloc] init];
    NSMutableArray<ProductInfo*> *cart = [[NSMutableArray alloc] init];
    NSFetchRequest *request = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    [request setPredicate:[NSPredicate predicateWithFormat:@"id == %@",userId]];
    
    NSArray *result = [context executeFetchRequest:request error:nil];
    
    if (result.count == 1) {
        NSObject *user = result[0];
        products = [[user mutableSetValueForKey:@"products"] allObjects];
    }
    
    for (int i=0; i<products.count;i++) {
        [cart addObject:[[ProductInfo alloc] initWithInfo:[products[i] valueForKey:@"productId"] andProductName:[products[i] valueForKey:@"productName"] andProductpQuantity:[products[i] valueForKey:@"productQty"] andProductPrice:[products[i] valueForKey:@"productPrice"] andProductDiscription:@"" andProductImageUrl:[products[i] valueForKey:@"productImgUrl"]]];
    }
    
    return cart;
}

@end
