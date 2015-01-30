//
//  ReminderViewController.h
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/29/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ReminderViewController : UIViewController

-(IBAction)fiveMinClicked:(id)sender;

-(IBAction)ninetySecClicked:(id)sender;

-(IBAction)twelveHourClicked:(id)sender;

-(IBAction)twentyfourHourClicked:(id)sender;

-(IBAction)cancelClicked:(id)sender;

@property (nonatomic) NSTimeInterval alarmTime;

@end
