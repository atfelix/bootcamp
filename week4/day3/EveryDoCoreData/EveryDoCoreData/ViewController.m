//
//  ViewController.m
//  EveryDoCoreData
//
//  Created by atfelix on 2017-05-25.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "AddTodoViewController.h"
#import "DisplayEditViewController.h"
#import "TodoTableViewCell.h"

@interface ViewController () <UITableViewDelegate, UITableViewDataSource, NSFetchedResultsControllerDelegate, AddTodoViewControllerProtocol>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

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
    else if ([segue.identifier isEqualToString:@"ShowDetailSegue"]) {
        DisplayEditViewController *displayEditViewController = (DisplayEditViewController *)(segue.destinationViewController);
        displayEditViewController.todo = [self.fetchedResultsController objectAtIndexPath:[self.tableView indexPathForSelectedRow]];
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.fetchedResultsController.sections[section] numberOfObjects];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TodoTableViewCell *cell =  [tableView dequeueReusableCellWithIdentifier:@"Cell"
                                                               forIndexPath:indexPath];
    Todo *todo = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.titleLabel.text = todo.title;
    return cell;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    //return self.fetchedResultsController.sections[section].name;
    return (section) ? @"Completed Tasks" : @"Outstanding Tasks";
}

-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {

    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.managedObjectContext deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];

        NSError *error = nil;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Error: %@", error.localizedDescription);
        }
    }
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

-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {

    UITableView *tableView = self.tableView;

    switch (type) {
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate: {
            Todo *changedTodo = [self.fetchedResultsController objectAtIndexPath:indexPath];
            TodoTableViewCell *cell = (TodoTableViewCell *)[tableView cellForRowAtIndexPath:indexPath];
            cell.titleLabel.text = changedTodo.title;
        }
            break;
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }
}

-(void)controller:(NSFetchedResultsController *)controller didChangeSection:(id<NSFetchedResultsSectionInfo>)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
                          withRowAnimation:UITableViewRowAnimationFade];
        default:
            break;
    }
}

@end
