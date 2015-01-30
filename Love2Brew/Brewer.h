//
//  Brewer.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  Model Class for the coffee brewer object
//
//  -- Depricated in place of BrewerEntity CoreData Model
//
//  Created by Sean Reinhardt on 1/27/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface Brewer : NSObject{
    int Id;
}

    //Properties
    @property (strong, nonatomic)  NSString *name;
    @property (nonatomic) int temp;
    @property (strong, nonatomic)  NSString *overview;
    @property (strong, nonatomic)  NSString *howItWorks;
    @property (strong, nonatomic)  NSString *history;
    @property (strong, nonatomic)  NSString *steps;
    @property (nonatomic) int rating;
    @property (strong, nonatomic)  NSURL *imageLocation;
    @property (strong, nonatomic) UIImage *brewerImage;

//Getter and Setter methods for Id
-(void) setId:(int)_Id;
-(int) Id;

    //Designated Constructor declaration
    -(id) initWithName:(NSString*)title;

    //Convience constructor declaration
    +(id) brewerWithName:(NSString *) _title;

//Helper method to download image associated with brewer - uses Asynchronous Thread
-(void) downloadImage;

@end
