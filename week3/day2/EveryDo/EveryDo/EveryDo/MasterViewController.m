//
//  MasterViewController.m
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "MasterViewController.h"

#import "AddTodoItemViewController.h"
#import "DetailViewController.h"
#import "TodoTableViewCell.h"
#import "TodoManager.h"
#import "TodoObject.h"

#define PrioritySegmentedControlIndex 0
#define DeadlineSegmentedControlIndex 1

@interface MasterViewController () <AddTodoItemDelegate, UITableViewDelegate>

@property (nonatomic) NSMutableArray<NSMutableArray *> *todoObjects;
@property (nonatomic) NSArray<NSString *> *sectionHeaders;
@property (nonatomic) TodoManager *manager;

@end

@implementation MasterViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UISwipeGestureRecognizer *swipeGR = [[UISwipeGestureRecognizer alloc] initWithTarget:self
                                                                                  action:@selector(handleSwipe:)];
    swipeGR.direction = UISwipeGestureRecognizerDirectionLeft | UISwipeGestureRecognizerDirectionRight;
    [self.view addGestureRecognizer:swipeGR];

    self.sectionHeaders = @[@"Outstanding Tasks", @"Completed Tasks"];
    self.manager = [[TodoManager alloc] initWithSectionCapacity:self.sectionHeaders.count];

    for (int i = 0; i < self.sectionHeaders.count; i++) {
        [self.todoObjects addObject:[[NSMutableArray alloc] init]];
    }
}


- (void)viewWillAppear:(BOOL)animated {
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)insertNewObject:(id)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main"
                                                         bundle:nil];
    
    AddTodoItemViewController *addTodoItemViewController = [storyboard instantiateViewControllerWithIdentifier:@"AddTodoItemViewController"];
    addTodoItemViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    addTodoItemViewController.modalTransitionStyle = UIModalTransitionStyleCoverVertical;

    [self presentViewController:addTodoItemViewController
                       animated:YES
                     completion:^{
                         addTodoItemViewController.delegate = self;
                     }];
}


#pragma mark - Segues

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        TodoObject *object = self.todoObjects[indexPath.section][indexPath.row];
        DetailViewController *controller = (DetailViewController *)[segue destinationViewController];
        [controller setDetailItem:object];
    }
}


#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.sectionHeaders.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.todoObjects[section].count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    TodoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TodoTableViewCell" forIndexPath:indexPath];
    cell.todoObject = self.todoObjects[indexPath.section][indexPath.row];
    [cell updateDisplay];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}


- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [self.todoObjects[indexPath.section] removeObjectAtIndex:indexPath.row];
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return (tableView.editing) ? UITableViewCellEditingStyleDelete : UITableViewCellEditingStyleNone;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(TodoTableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = (cell.todoObject.isDone) ? [[UIColor redColor] colorWithAlphaComponent:0.5] : [UIColor whiteColor];
}

-(void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)sourceIndexPath toIndexPath:(NSIndexPath *)destinationIndexPath {
    TodoObject *todo = [self.todoObjects[sourceIndexPath.section] objectAtIndex:sourceIndexPath.row];
    [self.todoObjects[sourceIndexPath.section] removeObjectAtIndex:sourceIndexPath.row];
    [self.todoObjects[destinationIndexPath.section] insertObject:todo
                                                         atIndex:destinationIndexPath.row];
    [self.tableView reloadData];
}

-(BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return self.sectionHeaders[section];
}

-(NSIndexPath *)tableView:(UITableView *)tableView targetIndexPathForMoveFromRowAtIndexPath:(NSIndexPath *)sourceIndexPath toProposedIndexPath:(NSIndexPath *)proposedDestinationIndexPath {

    NSIndexPath *indexPath;

    if (sourceIndexPath.section == proposedDestinationIndexPath.section) {
        indexPath = [NSIndexPath indexPathForRow:proposedDestinationIndexPath.row
                                       inSection:proposedDestinationIndexPath.section];
    }
    else if (sourceIndexPath.section < proposedDestinationIndexPath.section) {
        indexPath = [NSIndexPath indexPathForRow:self.todoObjects[sourceIndexPath.section].count - 1
                                       inSection:sourceIndexPath.section];
    }
    else {
        indexPath = [NSIndexPath indexPathForRow:0
                                       inSection:sourceIndexPath.section];
    }
    return indexPath;
}

#pragma mark - Utility Functions

-(void)sortByPriority {
    for (NSMutableArray *array in self.todoObjects) {
        [array sortUsingComparator:^NSComparisonResult(TodoObject *a, TodoObject *b) {
            return (NSComparisonResult)((a.priorityNumber < b.priorityNumber)
                                        - (b.priorityNumber < a.priorityNumber));
        }];
    }
}

-(void)sortByDeadline {
    for (NSMutableArray *array in self.todoObjects) {
        [array sortUsingComparator:^NSComparisonResult(TodoObject *a, TodoObject *b) {
            return [a.deadlineDate compare:b.deadlineDate];
        }];
    }
}

- (IBAction)sort:(UISegmentedControl *)sender {
    if (sender.selectedSegmentIndex == PrioritySegmentedControlIndex) {
        [self sortByPriority];
    }
    else if (sender.selectedSegmentIndex == DeadlineSegmentedControlIndex) {
        [self sortByDeadline];
    }
    [self.tableView reloadData];
}

-(void)saveTodoItem:(TodoObject *)todo {
    [self.todoObjects[0] insertObject:todo
                              atIndex:0];
    [self.tableView reloadData];
}

-(void)handleSwipe:(UISwipeGestureRecognizer *)sender {

    if (self.tableView.isEditing) {
        return;
    }

    if (sender.state == UIGestureRecognizerStateEnded) {
        CGPoint swipeLocation = [sender locationInView:self.tableView];
        NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:swipeLocation];
        TodoTableViewCell *cell = [self.tableView cellForRowAtIndexPath:indexPath];

        if (!cell || cell.todoObject.isDone) {
            return;
        }

        [self.todoObjects[0] removeObjectAtIndex:indexPath.row];

        [self.todoObjects[1] addObject:cell.todoObject];
        cell.todoObject.done = YES;

        [self.tableView reloadData];
    }
}


@end
