//
//  ReminderViewController.m
//  Love2Brew
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
    
    UIImage *backgroundImage = [UIImage imageNamed:@"FrontBackground"];
    UIImageView *backgroundImageView=[[UIImageView alloc]initWithFrame:self.view.frame];
    backgroundImageView.image=backgroundImage;
    [self.view insertSubview:backgroundImageView atIndex:0];
    
}

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

-(void)setReminder
{
    UILocalNotification *localNotification = [[UILocalNotification alloc] init];
    localNotification.fireDate = [NSDate dateWithTimeIntervalSinceNow:self.alarmTime];
    localNotification.alertBody = @"Coffee is Ready!";
    [[UIApplication sharedApplication] scheduleLocalNotification:localNotification];
}

@end
