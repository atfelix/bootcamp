//
//  ViewController.m
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "AddTodoViewController.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, AddTodoViewControllerProtocol>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSError *error = nil;

    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddSegue"]) {
        AddTodoViewController *todoVC = (AddTodoViewController *)(segue.destinationViewController);
        todoVC.delegate = self;
        Todo *todo = (Todo *) [[Todo alloc] initWithContext:self.managedObjectContext];
        todoVC.todo = todo;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                           forIndexPath:indexPath];
}

-(void)addTodoViewControllerDidCancel:(Todo *)todoToDelete {
    [self.managedObjectContext deleteObject:todoToDelete];
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}

-(void)addTodoViewControllerDidSave {
    NSError *error = nil;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Error: %@", error.localizedDescription);
    }
    [self dismissViewControllerAnimated:YES
                             completion:nil];
}


-(NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController) {
        return _fetchedResultsController;
    }

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Todo"
                                              inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];

    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"done"
                                                                   ascending:YES];
    [fetchRequest setSortDescriptors:[NSArray arrayWithObjects:sortDescriptor, nil]];

    _fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest
                                                                    managedObjectContext:self.managedObjectContext
                                                                      sectionNameKeyPath:@"done"
                                                                               cacheName:nil];
    _fetchedResultsController.delegate = self;

    return _fetchedResultsController;
}



@end
