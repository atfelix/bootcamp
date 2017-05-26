//
//  AddTodoViewController.m
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "AddTodoViewController.h"

@interface AddTodoViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UITextField *priorityNumberField;

@end

@implementation AddTodoViewController

-(void)viewDidLoad {
    [super viewDidLoad];
    self.titleField.text = self.todo.title;
    self.descriptionField.text = self.todo.todoDescription;
    self.priorityNumberField.text = [NSString stringWithFormat:@"%@", @(self.todo.priorityNumber)];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)cancel:(UIBarButtonItem *)sender {
    [self.delegate addTodoViewControllerDidCancel:self.todo];
}

-(IBAction)save:(UIBarButtonItem *)sender {
    self.todo.title = self.titleField.text;
    self.todo.todoDescription = self.descriptionField.text;
    self.todo.dateCreated = [NSDate date];
    self.todo.deadlineDate = [AddTodoViewController dateMergedFromDate:self.datePicker.date
                                                               andTime:self.timePicker.date];
    self.todo.done = NO;
    self.todo.priorityNumber = [self.priorityNumberField.text intValue];

    [self.delegate addTodoViewControllerDidSave];
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
