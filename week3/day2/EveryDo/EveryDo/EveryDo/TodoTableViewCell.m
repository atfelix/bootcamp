//
//  TodoTableViewCell.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TodoTableViewCell.h"

#import "TodoObject.h"

static NSString *reuseIdentifier = @"TodoTableViewCell";

@implementation TodoTableViewCell

-(void)updateDisplay {
    self.titleLabel.text = self.todoObject.title;
    self.priorityLabel.text = [NSString stringWithFormat:@"%@", @(self.todoObject.priorityNumber)];
    self.descriptionLabel.text = self.todoObject.todoDescription;
}

@end
