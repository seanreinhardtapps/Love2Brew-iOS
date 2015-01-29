//
//  BrewerEntity.h
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


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


-(void) downloadImage;


@end
