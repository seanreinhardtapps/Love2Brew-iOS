//
//  HistoryViewController.m
//  Love2Brew
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
    
    UIImage *backgroundImage = [UIImage imageNamed:@"FrontBackground"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
    BrewerTabViewController *tabBar = (BrewerTabViewController *)self.tabBarController;
    self.brewer = tabBar.brewer;
    
    self.historyText.text = self.brewer.history;
    self.howitworksText.text = self.brewer.howItWorks;
    self.navigationItem.title = self.brewer.name;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
