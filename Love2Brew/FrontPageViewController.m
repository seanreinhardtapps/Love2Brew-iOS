//
//  FrontPageViewController.m
//  Love2Brew
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
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FrontBackground"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
     self.serverURL = [NSURL URLWithString:@"http://coffee.sreinhardt.com/api/CoffeeBrewers/"];

    [self.fetchedResultsController performFetch:nil];
    self.coffeeBrewers = [NSMutableArray arrayWithArray:self.fetchedResultsController.fetchedObjects];

    
    
    if ([self.coffeeBrewers count] ==0)
    {
        [self downloadBrewers];
    }
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

-(NSFetchedResultsController *)fetchedResultsController
{
    //Lazy initialization - only initialize when first needed, not at ViewDidLoad
    if(_fetchedResultsController !=nil)
    {
        return _fetchedResultsController;
    }
    
    BrewerDataStack *coreDataStack = [BrewerDataStack defaultStack];
    NSFetchRequest *fetchRequest = [self entryListFetchRequest];
    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:coreDataStack.managedObjectContext sectionNameKeyPath:nil cacheName:nil];
    
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (NSFetchRequest *)entryListFetchRequest
{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"BrewerEntity"];
    
    //sort list
    //this is an Array - the array has one element -> a descriptor made by the method call to NSSortDescriptor
    fetchRequest.sortDescriptors = @[[NSSortDescriptor sortDescriptorWithKey:@"iD" ascending:YES]];
    return fetchRequest;
}

-(void) downloadBrewers
{
    //download JSON Data from server
    NSData *jsonData = [NSData dataWithContentsOfURL:self.serverURL];
    //Declare an error object to catch an error from JSON Derserialization
    NSError *error = nil;
    
    NSArray *dataArray = [NSJSONSerialization JSONObjectWithData:jsonData options:0 error:&error];
    
    
    //Use NSMutableArray to create array of BlogPost Objects for each coffee brewer deserialized from the stream
    self.coffeeBrewers = [NSMutableArray array];
    
    //Grab Core Stack
     BrewerDataStack *coreDataStack = [BrewerDataStack defaultStack];
    
    //for each element in the array, take the data from the dictionary and create a BlogPost object
    for (NSDictionary *jsonObj in dataArray)
    {
       
        //Initialize an entity into the core data
        BrewerEntity *brewer = [NSEntityDescription insertNewObjectForEntityForName:@"BrewerEntity"  inManagedObjectContext:coreDataStack.managedObjectContext];
        brewer.name = [jsonObj objectForKey:@"name"];
        brewer.iD = [jsonObj objectForKey:@"id"];
        brewer.temp = [jsonObj objectForKey:@"temp"];
        brewer.overview = [jsonObj objectForKey:@"overview"];
        brewer.history = [jsonObj objectForKey:@"history"];
        brewer.steps = [jsonObj objectForKey:@"steps"];
        brewer.howItWorks = [jsonObj objectForKey:@"howItWorks"];
        brewer.rating = [jsonObj objectForKey:@"rating"];
        [brewer downloadImage];
        [self.coffeeBrewers addObject:brewer];
        
        //SAVE
        [coreDataStack saveContext];
        
    }
    [coreDataStack saveContext];
    [self.tableView reloadData];
}


-(IBAction)reloadData:(id)sender
{
    [self.tableView reloadData];
}

- (void)tableView:(UITableView *)tableView
  willDisplayCell:(UITableViewCell *)cell
forRowAtIndexPath:(NSIndexPath *)indexPath
{
    [cell setBackgroundColor:[UIColor clearColor]];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [self.coffeeBrewers count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    
    //BrewerEntity *brewer = [self.coffeeBrewers objectAtIndex:indexPath.row];
    BrewerEntity *brewer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = brewer.name;
    
    //Set detail text label to display hot or cold temp
    if ([brewer.temp integerValue] == 1)
    {
        cell.detailTextLabel.text = @"Hot Temp";
    }
    else {
        cell.detailTextLabel.text = @"Cold Temp";
    }
    
    cell.imageView.image = [UIImage imageWithData:brewer.imageData];
    //Check if thumbnail is downloaded
    if ([brewer.imageData length] != 0) {
        cell.imageView.image = [UIImage imageWithData:brewer.imageData];
    }
    //load default image if no imagelink exists
    else {
        NSLog(@"no image");
        [brewer downloadImage];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //self.selectedBrewer = [self.coffeeBrewers objectAtIndex:indexPath.row];
    self.selectedBrewer = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self performSegueWithIdentifier:@"showBrewer" sender:self];
    
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([[segue identifier] isEqualToString:@"showBrewer"]){
        BrewerTabViewController *tabBar = [segue destinationViewController];
        NSLog(@"Ready to set brewer");
        tabBar.brewer = self.selectedBrewer;
        NSLog(@"Done set brewer");
    }
}


@end
