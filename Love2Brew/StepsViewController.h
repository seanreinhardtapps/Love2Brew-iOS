//
//  StepsViewController.h
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewerEntity.h"
#import "BrewerTabViewController.h"

@interface StepsViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *stepsText;
@property (strong, nonatomic) BrewerEntity *brewer;



@end
