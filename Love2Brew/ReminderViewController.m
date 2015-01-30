//
//  ReminderViewController.m
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  ViewController for the Reminder Page
//  Displays options for a reminder - launches a notification
//
//  Created by Sean Reinhardt on 1/29/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import "ReminderViewController.h"

@interface ReminderViewController ()

@end

@implementation ReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //set background image
    UIImage *backgroundImage = [UIImage imageNamed:@"FrontBackground"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
}

#pragma mark - IBAction handlers

-(IBAction)fiveMinClicked:(id)sender
{
    self.alarmTime = 60*5;
    [self setReminder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)ninetySecClicked:(id)sender
{
    self.alarmTime = 90;
    [self setReminder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)twelveHourClicked:(id)sender
{
    self.alarmTime = 60*60*12;
    [self setReminder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)twentyfourHourClicked:(id)sender
{
    self.alarmTime = 60*60*24;
    [self setReminder];
    [self dismissViewControllerAnimated:YES completion:nil];

}

-(IBAction)cancelClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - setReminder message

-(void)setReminder
{
    //initialize a Local Notification object
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    //set fireDate to time set in property
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.alarmTime];
    //set message in notification
    localNotification.alertBody = @"Coffee is Ready!";
    //schedule notification into system
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
