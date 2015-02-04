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
-(void) downloadImageWithQueue:(dispatch_queue_t)queue andStack:(BrewerDataStack *)coreDataStack
{
    NSString *location = [NSString stringWithFormat: @"http://coffee.sreinhardt.com/Content/images/image%@.png", self.iD];
    //creates URL from string above
    self.imageLocation = [NSURL URLWithString:location];
    //perform download
    //open an async task
    dispatch_async(queue, ^{
    self.imageData = [NSData dataWithContentsOfURL:self.imageLocation];
        //callback thread - once download completed
        dispatch_async(dispatch_get_main_queue(), ^{
            //SAVE
            NSLog(@"Download complete for image %@", self.name);
            [coreDataStack saveContext];
        });
    });
}


-(void)fillBrewerWithJSON:(NSDictionary *)jsonObj
{
    //Load fields into object
    self.name = [jsonObj objectForKey:@"name"];
    self.iD = [jsonObj objectForKey:@"id"];
    self.temp = [jsonObj objectForKey:@"temp"];
    self.overview = [jsonObj objectForKey:@"overview"];
    self.history = [jsonObj objectForKey:@"history"];
    self.steps = [jsonObj objectForKey:@"steps"];
    self.howItWorks = [jsonObj objectForKey:@"howItWorks"];
    self.rating = [jsonObj objectForKey:@"rating"];

}
@end
