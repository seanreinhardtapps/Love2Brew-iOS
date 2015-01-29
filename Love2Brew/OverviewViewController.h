//
//  OverviewViewController.h
//  Love2Brew
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Brewer.h"

@interface OverviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *brewerImage;
@property (weak, nonatomic) IBOutlet UITextView *overviewText;
@property (strong, nonatomic) Brewer *brewer;

@end
