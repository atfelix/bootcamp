//
//  ViewController.m
//  TipCalculator
//
//  Created by atfelix on 2017-05-15.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *billAmountTextField;
@property (weak, nonatomic) IBOutlet UITextField *tipPercentageField;
@property (weak, nonatomic) IBOutlet UILabel *tipAmountLabel;
@property (weak, nonatomic) IBOutlet UISlider *tipPercentageSlider;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.tipPercentageField.text = [NSString stringWithFormat:@"%.0f", self.tipPercentageSlider.value];
    [self registerKeyboardNotifications];
    self.billAmountTextField.delegate = self;

    [self.billAmountTextField addTarget:self
                                 action:@selector(textFieldDidChange:)
                       forControlEvents:UIControlEventEditingChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    [self updateTipLabel];
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

- (IBAction)adjustTipPercentage:(UISlider *)sender {
    self.tipPercentageField.text = [NSString stringWithFormat:@"%.0f", sender.value];
    [self calculateTip:nil];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    BOOL existingTextHasDecimalSeparator = [textField.text rangeOfString:@"."].location != NSNotFound;
    BOOL replacementTextHasDecimalSeparator = [string rangeOfString:@"."].location != NSNotFound;
    BOOL replacementTextHasAlphabeticCharacter = [string rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound;

    if (string.length == 0) {
        return YES;
    }
    else if (replacementTextHasAlphabeticCharacter) {
        return NO;
    }
    else if (existingTextHasDecimalSeparator && replacementTextHasDecimalSeparator) {
        return NO;
    }
    else if ([textField.text rangeOfString:@"."].location == textField.text.length - 3) {
        return NO;
    }
    else {
        return YES;
    }
}

-(float)getTipPercentage {
    return self.tipPercentageSlider.value / 100.0;
}

-(float)getBillAmount {
    return [self.billAmountTextField.text doubleValue];
}

-(void)textFieldDidChange:(UITextField *)textField {
    [self updateTipLabel];
}

-(void)updateTipLabel {
    self.tipAmountLabel.text = [NSString stringWithFormat:@"$%.2f", [self getTipPercentage] * [self getBillAmount]];
}

@end
