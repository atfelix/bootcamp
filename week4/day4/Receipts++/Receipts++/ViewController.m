//
//  ViewController.m
//  Receipts++
//
//  Created by atfelix on 2017-05-26.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "AppDelegate.h"
#import "Receipt+CoreDataClass.h"
#import "Receipt+CoreDataProperties.h"
#import "Tag+CoreDataClass.h"
#import "Tag+CoreDataProperties.h"

@import CoreData;

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UIButton *addReceiptButton;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) NSArray *sections;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.addReceiptButton.backgroundColor = [UIColor blueColor];
    self.addReceiptButton.tintColor = [UIColor whiteColor];
    AppDelegate *appDelegate = (AppDelegate *)([UIApplication sharedApplication].delegate);
    self.managedObjectContext = appDelegate.persistentContainer.viewContext;
}


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    NSError *error = nil;
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Tag"];
    self.sections = [self.managedObjectContext executeFetchRequest:fetchRequest
                                                             error:&error];
    if (error) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    [self.tableView reloadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                           forIndexPath:indexPath];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddReceiptSegue"]) {

    }
}

@end
