//
//  ViewController.m
//  BillSplitter
//
//  Created by atfelix on 2017-05-20.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UISlider *sizeOfDinnerPartySlider;
@property (weak, nonatomic) IBOutlet UITextField *amountTextField;
@property (weak, nonatomic) IBOutlet UILabel *paymentLabel;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.amountTextField.delegate = self;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)handleButtonTap:(UIButton *)sender {
    [self calculateLabelValues:self.amountTextField withReplacementString:@"" andSliderValue:(int)self.sizeOfDinnerPartySlider.value];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    [self calculateLabelValues:textField withReplacementString:string andSliderValue:(int)self.sizeOfDinnerPartySlider.value];
    return YES;
}

-(void)calculateLabelValues:(UITextField *)textField withReplacementString:(NSString *)string andSliderValue:(int)value{

    if (textField.text.length == 0 && string.length == 0) {
        return;
    }

    NSDecimalNumber *partySize = [[NSDecimalNumber alloc] initWithInt:value];

    NSDecimalNumber *amount = [NSDecimalNumber decimalNumberWithString:[textField.text stringByAppendingString:string]];
    NSDecimalNumber *tip = amount;

    amount = [amount decimalNumberByDividingBy:partySize];
    tip = [amount decimalNumberByMultiplyingBy:[[NSDecimalNumber alloc] initWithString:@"0.15"]];

    NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
    numberFormatter.numberStyle = NSNumberFormatterCurrencyStyle;

    self.paymentLabel.text = [numberFormatter stringFromNumber:amount];
    self.tipLabel.text = [numberFormatter stringFromNumber:tip];
}

- (IBAction)handleSlideChange:(UISlider *)sender {
    [self calculateLabelValues:self.amountTextField withReplacementString:@"" andSliderValue:(int)sender.value];
}

@end
