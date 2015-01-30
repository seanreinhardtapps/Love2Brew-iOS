//
//  StepsViewController.m
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  History tab page loads Steps text
//  Loads background image
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import "StepsViewController.h"

@interface StepsViewController ()

@end

@implementation StepsViewController

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
    self.stepsText.text = self.brewer.steps;
    self.navigationItem.title = self.brewer.name;

}


@end
