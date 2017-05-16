//
//  TodoTableViewCell.h
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TodoObject.h"

@interface TodoTableViewCell : UITableViewCell

@property (nonatomic) TodoObject *todoObject;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *priorityLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

-(void)updateDisplay;

@end
