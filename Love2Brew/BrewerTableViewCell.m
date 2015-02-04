//
//  BrewerTableViewCell.m
//  Love2Brew
//
//  Created by Sean Reinhardt on 2/4/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import "BrewerTableViewCell.h"

@interface BrewerTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *brewerNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *brewerTempLabel;
@property (weak, nonatomic) IBOutlet UIImageView *brewerImageView;
@property (weak, nonatomic) IBOutlet UIImageView *tempImageView;

@end

@implementation BrewerTableViewCell

-(void)configureCellForBrewer:(BrewerEntity *)brewer
{
    self.brewerNameLabel.text = brewer.name;

    //Check if thumbnail is downloaded
    if ([brewer.imageData length] != 0) {
        self.brewerImageView.image = [UIImage imageWithData:brewer.imageData];
    }
    
    if ([brewer.temp integerValue] == 1)
    {
        self.brewerTempLabel.text = @"Hot Temp";
        
        self.tempImageView.image = [UIImage imageWithData:brewer.imageData];
    }
    else {
        self.brewerTempLabel.text = @"Cold Temp";
        self.tempImageView.image = [UIImage imageWithData:brewer.imageData];

    }
    

}

@end
