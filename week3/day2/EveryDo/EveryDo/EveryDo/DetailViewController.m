//
//  DetailViewController.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "DetailViewController.h"

#import "TodoObject.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(TodoObject *)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}


- (void)configureView {

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"dd/MM/yyyy";

    if (self.detailItem) {
        self.titleLabel.text = self.detailItem.title;
        self.textView.text = self.detailItem.todoDescription;
        self.priorityLabel.text = [NSString stringWithFormat:@"%@", @(self.detailItem.priorityNumber)];
        self.dateCreatedLabel.text = [dateFormatter stringFromDate:self.detailItem.dateCreated];
        self.dataFinishedLabel.text = [dateFormatter stringFromDate:self.detailItem.dateFinished];
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
