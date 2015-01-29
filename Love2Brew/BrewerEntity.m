//
//  BrewerEntity.m
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import "BrewerEntity.h"


@implementation BrewerEntity

@synthesize imageLocation;

@dynamic history;
@dynamic howItWorks;
@dynamic imageData;
@dynamic name;
@dynamic overview;
@dynamic rating;
@dynamic steps;
@dynamic temp;
@dynamic iD;

-(void) downloadImage
{
    NSString *location = [NSString stringWithFormat: @"http://coffee.sreinhardt.com/Content/images/image%@.png", self.iD];
    self.imageLocation = [NSURL URLWithString:location];
    dispatch_queue_t queue = dispatch_queue_create("com.sreinhardt.SeanReinhardtApps.Love2Brew", NULL);
    dispatch_async(queue, ^{
        self.imageData = [NSData dataWithContentsOfURL:self.imageLocation];
        
    });
    
}

@end
