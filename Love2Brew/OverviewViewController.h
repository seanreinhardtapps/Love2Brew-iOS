//
//  OverviewViewController.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  Overview tab page loads Coffee Brewer Image and overview text
//  Loads background image
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewerEntity.h"

@interface OverviewViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *brewerImage;
@property (weak, nonatomic) IBOutlet UITextView *overviewText;
@property (strong, nonatomic) BrewerEntity *brewer;

@end
