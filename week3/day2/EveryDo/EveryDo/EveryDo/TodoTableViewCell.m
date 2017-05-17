//
//  TodoTableViewCell.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TodoTableViewCell.h"

#import "TodoObject.h"

@implementation TodoTableViewCell

-(void)updateDisplay {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";

    self.titleLabel.text = self.todoObject.title;
    self.priorityLabel.text = [NSString stringWithFormat:@"%@", @(self.todoObject.priorityNumber)];
    self.descriptionLabel.text = self.todoObject.todoDescription;
    self.dateLabel.text = [dateFormatter stringFromDate:self.todoObject.deadlineDate];
}

@end
