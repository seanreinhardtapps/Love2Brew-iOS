//
//  Brewer.m
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/27/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import "Brewer.h"

/**********************************************************************************************
 Brewer Class
 Model of Brewer - contains data and methods related to a coffee brewer
 ***********************************************************************************************/
@implementation Brewer

//Designated Constructor definition
-(id) initWithName:(NSString*)name {
    //call super to use init from NSObject and assign pointer to self
    self = [super init];
    
    //validate instanciation sucessful
    if (self)
    {
        self.name = name;
    }
    return self;
}

//Convience constructor declaration
+(id) brewerWithName:(NSString *) name{
    return [[self alloc] initWithName:name];
}

-(int) Id
{
    return Id;
}

-(void) setId:(int)_Id
{
    Id = _Id;
    
}

-(void) downloadImage
{
    NSString *location = [NSString stringWithFormat: @"http://coffee.sreinhardt.com/Content/images/image%d.png", self.Id];
    self.imageLocation = [NSURL URLWithString:location];
    dispatch_queue_t queue = dispatch_queue_create("com.sreinhardt.SeanReinhardtApps.Love2Brew", NULL);
    dispatch_async(queue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:self.imageLocation];
        self.brewerImage = [UIImage imageWithData:imageData];
        
    });
    
}

@end
