//
//  ViewController.m
//  TipCalculator
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#define TipRate 0.15

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tipAmountLabel.text = @"$";
    [self registerKeyboardNotifications];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", [self.tipPercentageField.text doubleValue] * [self.billAmountTextField.text doubleValue] / 100.0];
    [self.view endEditing:YES];
}

-(void)registerKeyboardNotifications {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardShowsOnScreen:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardHidesOffScreen:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidShowOnScreen:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardDidHideOffScreen:)
                                                 name:UIKeyboardDidHideNotification
                                               object:nil];
}

-(void)keyboardShowsOnScreen:(NSNotification *)notification {
    CGRect rect = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];

    if (CGRectContainsPoint(rect, self.billAmountTextField.frame.origin)) {
        self.billAmountTextField.frame = CGRectMake(self.billAmountTextField.frame.origin.x,
                                                    self.billAmountTextField.frame.origin.y - rect.size.height,
                                                    self.billAmountTextField.frame.size.width,
                                                    self.billAmountTextField.frame.size.height);
    }

    if (CGRectContainsPoint(rect, self.tipPercentageField.frame.origin)) {
        self.tipPercentageField.frame = CGRectMake(self.tipPercentageField.frame.origin.x,
                                                    self.tipPercentageField.frame.origin.y - rect.size.height,
                                                    self.tipPercentageField.frame.size.width,
                                                    self.tipPercentageField.frame.size.height);
    }
}

-(void)keyboardHidesOffScreen:(NSNotification *)notification {
}

-(void)keyboardDidShowOnScreen:(NSNotification *)notification {
}

-(void)keyboardDidHideOffScreen:(NSNotification *)notification {
}

- (IBAction)dismissKeyboard:(UITapGestureRecognizer *)sender {
    [self.view endEditing:YES];
}


@end
