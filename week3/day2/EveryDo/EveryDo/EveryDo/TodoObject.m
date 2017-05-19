//
//  TodoObject.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "TodoObject.h"

@implementation TodoObject

-(instancetype)initWithTitle:(NSString *)titleString andDescription:(NSString *)descriptionString andPriorityNumber:(NSInteger)priorityNumber andDeadlineDate:(NSDate *)date andDeadlineTime:(NSDate *)time {

    self = [super init];
    if (self) {
        _title = titleString;
        _todoDescription = descriptionString;
        _priorityNumber = priorityNumber;
        _done = NO;
        _dateCreated = [NSDate date];
        _deadlineDate = [TodoObject dateMergedFromDate:date
                                               andTime:time];
    }
    return self;
}

-(instancetype)init {
    return [self initWithTitle:@"NO TITLE"
                andDescription:@"NO DESCRIPTION"
             andPriorityNumber:-1
               andDeadlineDate:[NSDate date]
               andDeadlineTime:[NSDate distantFuture]];
}

+(NSDate *)dateMergedFromDate:(NSDate *)date andTime:(NSDate *)time {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *timeComponents = [calendar components:NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond
                                                   fromDate:time];
    NSDateComponents *dateComponents = [calendar components:NSCalendarUnitDay | NSCalendarUnitMonth | NSCalendarUnitYear
                                                   fromDate:date];
    dateComponents.hour = timeComponents.hour;
    dateComponents.minute = timeComponents.minute;
    dateComponents.second = timeComponents.second;

    return [calendar dateFromComponents:dateComponents];
}


@end
