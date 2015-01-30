//
//  BrewerEntity.m
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  Implementation of Brewer Model CoreData Entity
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

//retrieves png image from server for brewer
-(void) downloadImage
{
    NSString *location = [NSString stringWithFormat: @"http://coffee.sreinhardt.com/Content/images/image%@.png", self.iD];
    //creates URL from string above
    self.imageLocation = [NSURL URLWithString:location];
    //perform download
    self.imageData = [NSData dataWithContentsOfURL:self.imageLocation];
}

@end
