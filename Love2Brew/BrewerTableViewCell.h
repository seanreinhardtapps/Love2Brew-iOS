//
//  BrewerTableViewCell.h
//  Love2Brew
//
//  Created by Sean Reinhardt on 2/4/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BrewerEntity.h"

@interface BrewerTableViewCell : UITableViewCell

-(void)configureCellForBrewer:(BrewerEntity *)brewer;

@end
