//
//  HistoryViewController.m
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  History tab page loads history text and How it Works text
//  Loads background image
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import "HistoryViewController.h"
#import "BrewerTabViewController.h"

@interface HistoryViewController ()

@end

@implementation HistoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //Load background image
    UIImage *backgroundImage = [UIImage imageNamed:@"FrontBackground"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    //reference to TabBarController hosting tab
    BrewerTabViewController *tabBar = (BrewerTabViewController *)self.tabBarController;
    //receive brewer object from TabBarController
    self.brewer = tabBar.brewer;
    
    //load information from object
    self.historyText.text = self.brewer.history;
    self.howitworksText.text = self.brewer.howItWorks;
    self.navigationItem.title = self.brewer.name;
}


@end
