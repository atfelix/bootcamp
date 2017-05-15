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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)calculateTip:(UIButton *)sender {
    double tipAmount = TipRate * [self.billAmountTextField.text doubleValue];
}

@end
