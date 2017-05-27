//
//  AddReceiptViewController.m
//  Receipts++
//
//  Created by atfelix on 2017-05-26.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "AddReceiptViewController.h"

#import "AppDelegate.h"

@interface AddReceiptViewController () <UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UITextField *amountField;
@property (weak, nonatomic) IBOutlet UITextField *descriptionField;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;

@end

@implementation AddReceiptViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.allowsMultipleSelection = YES;
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

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"AddCell"
                                                            forIndexPath:indexPath];
    cell.textLabel.text = @[@"Personal", @"Family", @"Business"][indexPath.row];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.accessoryType = UITableViewCellAccessoryNone;
}

- (IBAction)cancel:(UIButton *)sender {
    [self.delegate addReceiptViewControllerDidCancel:self.receipt];
}

- (IBAction)save:(UIButton *)sender {
    self.receipt.amount = [self.amountField.text doubleValue];
    self.receipt.note = self.descriptionField.text;
    self.receipt.timeStamp = self.datePicker.date;

    NSMutableSet *tags = [[NSMutableSet alloc] init];

    for (int i = 0; i < 3; i++) {
        UITableViewCell *cell = [self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:i
                                                                                         inSection:0]];
        if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
            Tag *tag = (Tag *)[NSEntityDescription insertNewObjectForEntityForName:@"Tag"
                                                            inManagedObjectContext:[self.delegate managedObjectContext]];
            tag.tagName = cell.textLabel.text;
            [tags addObject:tag];
        }
    }

    self.receipt.tags = tags;
    [self.delegate addReceiptViewControllerDidSave];
}

+(NSString *)getCellTitle:(NSIndexPath *)indexPath {
    return @[@"Personal", @"Family", @"Business"][indexPath.row];
}

@end
