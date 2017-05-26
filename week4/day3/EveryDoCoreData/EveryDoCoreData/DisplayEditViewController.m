//
//  DisplayEditViewController.m
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DisplayEditViewController.h"

#import "AppDelegate.h"
#import "AddTodoViewController.h"

@interface DisplayEditViewController ()

@property (weak, nonatomic) IBOutlet UITextField *titleField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *editButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;

@end

@implementation DisplayEditViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.titleField.text = self.todo.title;
    self.descriptionField.text = self.todo.todoDescription;
    self.datePicker.date = self.todo.deadlineDate;
    self.timePicker.date = self.todo.deadlineDate;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)editButtonTapped:(UIBarButtonItem *)sender {
    self.titleField.enabled = YES;
    self.descriptionField.editable = YES;
    self.datePicker.enabled = YES;
    self.timePicker.enabled = YES;
    self.editButton.enabled = NO;
    self.doneButton.enabled = YES;
}

- (IBAction)doneButtonTapped:(UIBarButtonItem *)sender {
    self.titleField.enabled = NO;
    self.descriptionField.editable = NO;
    self.datePicker.enabled = NO;
    self.timePicker.enabled = NO;
    self.editButton.enabled = YES;
    self.doneButton.enabled = NO;

    self.todo.title = self.titleField.text;
    self.todo.todoDescription = self.descriptionField.text;
    self.todo.deadlineDate = [AddTodoViewController dateMergedFromDate:self.datePicker.date
                                                               andTime:self.timePicker.date];

    AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    [delegate saveContext];
}

@end
