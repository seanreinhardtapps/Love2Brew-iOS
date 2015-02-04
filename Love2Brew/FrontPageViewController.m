//
//  FrontPageViewController.m
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

#import "FrontPageViewController.h"
#import "Brewer.h"
#import "BrewerTabViewController.h"
#import "BrewerEntity.h"
#import "BrewerDataStack.h"

@interface FrontPageViewController ()

@end

@implementation FrontPageViewController

/**
 * viewDidLoad
 * set background
 * configure server url
 * fetch CoreData
 * perform download if CoreData is empty
 * param - none
 * return - void
 */
- (void)viewDidLoad {
    [super viewDidLoad];
    
    //load background image
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FrontBackground"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
    //set address of server
    self.serverURL = [NSURL URLWithString:@"http://coffee.sreinhardt.com/api/CoffeeBrewers/"];

    //use core data message to retrieve stored coffee brewer data
    [self.fetchedResultsController performFetch:nil];
    

    //if data store is empty, send message to download data
    if ([self.fetchedResultsController.fetchedObjects count] == 0)
    {
        [self downloadBrewers];
    }
}


/**
 * viewWillAppear
 * reload table when view reloads from tab view controller
 * param - animated Boolean
 * return - void
 */
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Fetch message


/**
 * fetchedResultsController
 * Performs all setup of fetchResultsController and fetches BrewerEntities
 * param - none
 * return - NSFetchResultsController object
 */
-(NSFetchedResultsController *)fetchedResultsController
{
    //Lazy initialization - only initialize when first needed, not at ViewDidLoad
    if(_fetchedResultsController !=nil)
    {
        //already initialized...
        return _fetchedResultsController;
    }
    //get reference to dataStack
    BrewerDataStack *coreDataStack = [BrewerDataStack defaultStack];
    
    //declare instance of fetch request - fetch all entities of type "BrewerEntity"
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"BrewerEntity"];
    
    //sort list...this is an Array - the array has one element -> a descriptor made by the method call to NSSortDescriptor
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"iD" ascending:YES]];

    //initialize controller
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    //set this viewController as delegate
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Download messages


/**
 * downloadBrewers
 * This message uses asynchronous threads to download coffee brewer data from server
 * param - none
 * return - none
 */
-(void) downloadBrewers
{
    //download JSON Data from server
    NSData *jsonData = [NSData dataWithContentsOfURL:self.serverURL];
    
    //Declare an error object to catch an error from JSON Derserialization
    NSError *error = nil;
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    //Grab reference to Core Stack
     BrewerDataStack *coreDataStack = [BrewerDataStack defaultStack];
    
    //declare queue
    static dispatch_queue_t queue = 0;
    if (0 == queue) {
        queue = dispatch_queue_create("com.sreinhardt.SeanReinhardtApps.Love2Brew", NULL);
    }
    NSArray *fetchResults = [self.fetchedResultsController fetchedObjects];
    long fetchCount = (long)[fetchResults count];
    
    //for each element in the array, take the data from the dictionary and create a BlogPost object
    for (NSDictionary *jsonObj in dataArray)
    {
        BrewerEntity *brewer;
        if ((long)[[jsonObj objectForKey:@"id"] integerValue] > fetchCount)
        {
            //Initialize an entity
            brewer = [NSEntityDescription insertNewObjectForEntityForName:@"BrewerEntity"  inManagedObjectContext:coreDataStack.managedObjectContext];
            
            [brewer fillBrewerWithJSON:jsonObj];
            [brewer downloadImageWithQueue:queue andStack:coreDataStack];
        }
    }
}

#pragma mark - IBActions


/**
 * reloadData
 * redownloads coffee brewer data from server and updates tableview
 * param sender: object that send the message
 * return IBAction
 */
-(IBAction)reloadData:(id)sender
{
    [self downloadBrewers];
    [self.tableView reloadData];
}

#pragma mark - Table view methods


/**
 * willDisplayCell forRowAtIndexPath
 * Sets all cells to clear fill
 * param: cell: cell to be set to clear
 * param: indexPath: location of cell in tableView
 * return: tableView
 */
//
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}


/**
 * numberOfSectionsInTableView
 * returns number of sections desired in the tableView
 * param: tableView: reference to TableView
 * return: NSInteger - number of cells
 */
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


/**
 * numberOfRowsInSection
 * Reserve one cell for each coffee brewer object
 * param: section: section number in tableview
 * return: NSInteger - number of rows per section
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.fetchedResultsController.fetchedObjects count];
}


/**
 * numberOfRowsInSection
 * Set contents of cell
 * retrieves one coffee brewer from fetch results
 * param: indexPath: location in tableView
 * return: UITableViewCell - configured cell
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //locate Brewer associated with cell
    BrewerEntity *brewer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Set Contents
    cell.textLabel.text = brewer.name;
    
    if ([brewer.temp integerValue] == 1)
    {
        cell.detailTextLabel.text = @"Hot Temp";
    }
    else {
        cell.detailTextLabel.text = @"Cold Temp";
    }
    
    //Check if thumbnail is downloaded
    if ([brewer.imageData length] != 0) {
        cell.imageView.image = [UIImage imageWithData:brewer.imageData];
    }
    
    return cell;
}


/**
 * controllerDidChangeContent
 * Delegate method of FetchResultsController
 * reload tableView data when CoreDataStack contents change
 * param: NSFetchedResultsController object
 * return: void
 */
- (void) controllerDidChangeContent: (NSFetchedResultsController *) controller
{
    [self.tableView reloadData];
}

#pragma mark - Segue


/**
 * didSelectRowAtIndexPath
 * selected cell - set brewer for dispatch to TabBarController and perform segue
 * param: indexPath - location in tableView
 * return: void
 */
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve Brewer Entity
    self.selectedBrewer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //send segue message
    [self performSegueWithIdentifier:@"showBrewer" sender:self];
}


/**
 * prepareForSegue
 * if segue is showBrewer get reference to TabBar and send a BrewerEntity to it
 * param: sender: segue Id
 * return: void
 */
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showBrewer"]){
        
        //get reference to TabBarController
        BrewerTabViewController *tabBar = [segue destinationViewController];
        //send brewer object to TabBarController
        tabBar.brewer = self.selectedBrewer;
    }
}


@end
