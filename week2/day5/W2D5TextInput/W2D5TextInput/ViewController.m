//
//  ViewController.m
//  W2D5TextInput
//
//  Created by atfelix on 2017-05-12.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *textField;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.textField becomeFirstResponder];
    self.textField.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)resignTapped:(id)sender {
    [self textFieldShouldReturn:self.textField];
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
}

-(void)textFieldDidEndEditing:(UITextField *)textField {
    NSLog(@"textfield ended with %@", textField.text);

}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    BOOL shouldReturn = textField.text.length > 0;

    if (shouldReturn) {
        [textField resignFirstResponder];
    }

    return shouldReturn;
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField {
    return YES;
}

@end
