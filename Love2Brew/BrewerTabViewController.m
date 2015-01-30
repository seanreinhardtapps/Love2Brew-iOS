//
//  BrewerTabViewController.m
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

#import "BrewerTabViewController.h"

@interface BrewerTabViewController ()

@end

@implementation BrewerTabViewController

@synthesize brewer;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Set Navigation Bar Title with Name of Coffee Brewer
    self.navigationItem.title = self.brewer.name;
    
}


@end
