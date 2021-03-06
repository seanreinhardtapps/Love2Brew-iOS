//
//  BrewerDataStack.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  CoreData stack for Love2Brew application
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@interface BrewerDataStack : NSObject

+(instancetype) defaultStack;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
