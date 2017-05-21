//
//  ViewController.m
//  BillSplitter
//
//  Created by atfelix on 2017-05-20.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UISlider *sizeOfDinnerPartySlider;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


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

- (IBAction)handleButtonTap:(UIButton *)sender {

    NSDecimalNumber *partySize = [[NSDecimalNumber alloc] initWithInt:(int)self.sizeOfDinnerPartySlider.value];

    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:self.amountTextField.text];
    NSDecimalNumber *tip = amount;

    amount = [amount decimalNumberByDividingBy:partySize];
    tip = [amount decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithString:@"0.15"]];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;

    self.paymentLabel.text = [numberFormatter stringFromNumber:amount];
    self.tipLabel.text = [numberFormatter stringFromNumber:tip];
}

@end
