//
//  FrontPageViewController.h
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/27/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewer.h"

@interface FrontPageViewController : UITableViewController

    @property (nonatomic, strong) NSMutableArray *coffeeBrewers;

    @property (nonatomic, strong) Brewer *selectedBrewer;

    @property (strong, nonatomic) NSURL *serverURL;
    -(void) downloadBrewers;

    -(IBAction)reloadData:(id)sender;

@end
