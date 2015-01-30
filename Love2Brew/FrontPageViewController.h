//
//  FrontPageViewController.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  TableViewController for the Main Page
//  Retrieves stored coffee brewer entitities from CoreDataStack
//  Downloads from server if data stack is empty
//  loads coffee brewers into table
//  launches TabbedViewController when a row is selected
//  sends associated coffee brewer via segue
//
//  Created by Sean Reinhardt on 1/27/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewerEntity.h"

@interface FrontPageViewController : UITableViewController <NSFetchedResultsControllerDelegate>

    //handler to retrieve stored coffee brewer data
    @property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;

    //List of brewers - loaded from data stack
    @property (nonatomic, strong) NSMutableArray *coffeeBrewers;

    //Property - Brewer object that will be sent to TabBarController
    @property (nonatomic, strong) BrewerEntity *selectedBrewer;

    //URL of server
    @property (strong, nonatomic) NSURL *serverURL;

    //Helper to download brewers from server
    -(void) downloadBrewers;

    //IBAction handler for refresh button
    -(IBAction)reloadData:(id)sender;

@end
