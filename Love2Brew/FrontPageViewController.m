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
    
    //load BrewerEntity objects from fetch into mutable array
    self.coffeeBrewers = [NSMutableArray arrayWithArray:self.fetchedResultsController.fetchedObjects];

    //if data store is empty, send message to download data
    if ([self.coffeeBrewers count] ==0)
    {
        [self downloadBrewers];
    }
}

//reload table when view reloads from tab view controller
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

#pragma mark - Fetch message

// Performs all setup of fetchResultsController and fetches BrewerEntities
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
    
    //sort list
    //this is an Array - the array has one element -> a descriptor made by the method call to NSSortDescriptor
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"iD" ascending:YES]];

    //initialize controller
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    //set this viewController as delegate
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

#pragma mark - Download messages

//This message uses asynchronous threads to download coffee brewer data from server
-(void) downloadBrewers
{
    //download JSON Data from server
    NSData *jsonData = [NSData dataWithContentsOfURL:self.serverURL];
    
    //Declare an error object to catch an error from JSON Derserialization
    NSError *error = nil;
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    
    //Use NSMutableArray to create array of BlogPost Objects for each coffee brewer deserialized from the stream
    //re-initializes array - overrides Brewer objects previously loaded into array
    self.coffeeBrewers = [NSMutableArray array];
    
    //Grab reference to Core Stack
     BrewerDataStack *coreDataStack = [BrewerDataStack defaultStack];
    
    //for each element in the array, take the data from the dictionary and create a BlogPost object
    for (NSDictionary *jsonObj in dataArray)
    {
       
       //declare queue
        dispatch_queue_t queue = dispatch_queue_create("com.sreinhardt.SeanReinhardtApps.Love2Brew", NULL);
        
        //open an async task
        dispatch_async(queue, ^{
            //Initialize an entity
            BrewerEntity *brewer = [NSEntityDescription insertNewObjectForEntityForName:@"BrewerEntity"  inManagedObjectContext:coreDataStack.managedObjectContext];
            
            //Load fields into object
            brewer.name = [jsonObj objectForKey:@"name"];
            brewer.iD = [jsonObj objectForKey:@"id"];
            brewer.temp = [jsonObj objectForKey:@"temp"];
            brewer.overview = [jsonObj objectForKey:@"overview"];
            brewer.history = [jsonObj objectForKey:@"history"];
            brewer.steps = [jsonObj objectForKey:@"steps"];
            brewer.howItWorks = [jsonObj objectForKey:@"howItWorks"];
            brewer.rating = [jsonObj objectForKey:@"rating"];
            
            //perform image download
            [brewer downloadImage];
            //add object to array
            [self.coffeeBrewers addObject:brewer];
            
            //callback thread - once download completed
            dispatch_async(dispatch_get_main_queue(), ^{
                //SAVE
                [coreDataStack saveContext];
                [self.tableView reloadData];
                });
        });
        
    }

}

#pragma mark - IBActions

//IBaction that calls reloadData message of tableView
-(IBAction)reloadData:(id)sender
{
    [self.tableView reloadData];
}

#pragma mark - Table view methods

//Sets all cells to clear
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}

//We only want one section in the table
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

//Create cell for each coffee brewer object
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.coffeeBrewers count];
}

//Set contents of cell
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //Grab Core Stack
    BrewerDataStack *coreDataStack = [BrewerDataStack defaultStack];
    
    //locate Brewer associated with cell
    BrewerEntity *brewer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    //Set Contents
    cell.textLabel.text = brewer.name;
    
    //Set detail text label to display hot or cold temp
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
    //send message to re-download
    else {
        NSLog(@"no image");
        [brewer downloadImage];
        [coreDataStack saveContext];
    }
    
    return cell;
}

//selected cell - send brewer to TabBarController and perform segue
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //retrieve Brewer Entity
    self.selectedBrewer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    //send segue message
    [self performSegueWithIdentifier:@"showBrewer" sender:self];
}

#pragma mark - Segue

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showBrewer"]){
        
        //get reference to TabBarController
        BrewerTabViewController *tabBar = [segue destinationViewController];
        //send brewer object to TabBarController
        tabBar.brewer = self.selectedBrewer;
    }
}


@end
