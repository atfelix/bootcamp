//
//  AddTodoItemViewController.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "AddTodoItemViewController.h"

@interface AddTodoItemViewController ()

@property (nonatomic) UIStatusBarStyle originalStyle;

@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *timePicker;
@property (weak, nonatomic) IBOutlet UITextField *titleTextField;
@property (weak, nonatomic) IBOutlet UITextView *descriptionTextView;
@property (weak, nonatomic) IBOutlet UIButton *saveButton;
@property (weak, nonatomic) IBOutlet UITextField *priorityTextField;

@end

@implementation AddTodoItemViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.datePicker setValue:[UIColor whiteColor]
                       forKey:@"textColor"];
    [self.timePicker setValue:[UIColor whiteColor]
                       forKey:@"textColor"];
    self.datePicker.minimumDate = [NSDate date];
    [self.view addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self
                                                                            action:@selector(dismissKeyboard:)]];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    self.originalStyle = [UIApplication sharedApplication].statusBarStyle;
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [UIApplication sharedApplication].statusBarStyle = self.originalStyle;
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

- (IBAction)saveTodoItem:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

- (IBAction)cancelTodoItem:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

-(void)dismissKeyboard:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}

@end
