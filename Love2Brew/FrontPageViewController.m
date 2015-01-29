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

@interface FrontPageViewController ()

@end

@implementation FrontPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImageView *tempImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FrontBackground"]];
    [tempImageView setFrame:self.tableView.frame];
    
    self.tableView.backgroundView = tempImageView;
    
     self.serverURL = [NSURL URLWithString:@"http://coffee.sreinhardt.com/api/CoffeeBrewers/"];

    if ([self.coffeeBrewers count] ==0)
    {
        [self downloadBrewers];
    }
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
    
    
    //for each element in the array, take the data from the dictionary and create a BlogPost object
    for (NSDictionary *jsonObj in dataArray)
    {
        Brewer *brewer = [Brewer brewerWithName:[jsonObj objectForKey:@"name"]];
        brewer.Id = [[jsonObj objectForKey:@"id"] integerValue];
        brewer.temp = [[jsonObj objectForKey:@"temp"] integerValue];
        brewer.overview = [jsonObj objectForKey:@"overview"];
        brewer.history = [jsonObj objectForKey:@"history"];
        brewer.steps = [jsonObj objectForKey:@"steps"];
        brewer.howItWorks = [jsonObj objectForKey:@"howItWorks"];
        brewer.rating = [[jsonObj objectForKey:@"rating"] integerValue];
        [brewer downloadImage];
        [self.coffeeBrewers addObject:brewer];
    }
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
    
    Brewer *brewer = [self.coffeeBrewers objectAtIndex:indexPath.row];
    cell.textLabel.text = brewer.name;
    
    //Set detail text label to display hot or cold temp
    if (brewer.temp == 1)
    {
        cell.detailTextLabel.text = @"Hot Temp";
    }
    else {
        cell.detailTextLabel.text = @"Cold Temp";
    }
    
    
    //Check if thumbnail is downloaded
    if (brewer.brewerImage != nil) {
        cell.imageView.image = brewer.brewerImage;
    }
    //load default image if no imagelink exists
    else {
        NSLog(@"no image");
        //cell.imageView.image = [UIImage imageNamed:@"treehouse.png"];
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedBrewer = [self.coffeeBrewers objectAtIndex:indexPath.row];
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
