//
//  HistoryViewController.h
//  Love2Brew
//  SEANREINHARDTAPPS
//  Hosted at: https://github.com/seanreinhardtapps/Love2Brew-iOS
//
//  History tab page loads history text and How it Works text
//  Loads background image
//
//  Created by Sean Reinhardt on 1/28/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewerEntity.h"

@interface HistoryViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextView *historyText;
@property (weak, nonatomic) IBOutlet UITextView *howitworksText;
@property (strong, nonatomic) BrewerEntity *brewer;


@end
