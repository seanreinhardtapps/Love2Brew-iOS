//
//  BrewerEntity.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  Brewer Model CoreData Entity
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "BrewerDataStack.h"


@interface BrewerEntity : NSManagedObject

@property (nonatomic, retain) NSString * history;
@property (nonatomic, retain) NSString * howItWorks;
@property (nonatomic, retain) NSData * imageData;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * overview;
@property (nonatomic, retain) NSNumber * rating;
@property (nonatomic, retain) NSString * steps;
@property (nonatomic, retain) NSNumber * temp;
@property (nonatomic, retain) NSNumber * iD;

@property (strong, nonatomic)  NSURL *imageLocation;

//message to download the objects image
-(void) downloadImageWithQueue:(dispatch_queue_t)queue andStack:(BrewerDataStack *)coreDataStack;

-(void)fillBrewerWithJSON:(NSDictionary *)jsonObj;

@end
