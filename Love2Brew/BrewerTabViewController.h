//
//  BrewerTabViewController.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  TabBarViewController to host detailed view of Coffee Brewer object
//  recieves brewer from FrontPageViewController segue
//  sets title of navigation bar
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewerEntity.h"

@interface BrewerTabViewController : UITabBarController

@property (strong, nonatomic) BrewerEntity *brewer;

@end
