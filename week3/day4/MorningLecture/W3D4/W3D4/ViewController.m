//
//  ViewController.m
//  W3D4
//
//  Created by atfelix on 2017-05-18.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import "ViewController.h"

#import "CustomLayout.h"

@interface ViewController () <UICollectionViewDelegate,
UICollectionViewDataSource,
UICollectionViewDelegateFlowLayout>

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic) NSMutableSet<NSIndexPath *> *selectedIndexPaths;
@property (nonatomic) UICollectionViewLayout *defaultLayout;
@property (nonatomic) NSInteger itemCount;
@property (nonatomic) CustomLayout *customLayout;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addSubview:self.collectionView];
    self.defaultLayout = self.collectionView.collectionViewLayout;
    self.selectedIndexPaths = [[NSMutableSet<NSIndexPath *> alloc] init];
    self.itemCount = 200;
    self.customLayout = [[CustomLayout alloc] init];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)addItem:(UIBarButtonItem *)sender {
    [self.collectionView performBatchUpdates:^{
        self.itemCount++;
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0
                                                     inSection:0];

        [self.collectionView insertItemsAtIndexPaths:@[indexPath]];
    }
                                  completion:nil];
}

- (IBAction)deleteItem:(UIBarButtonItem *)sender {

    [self.collectionView performBatchUpdates:^{
        if (self.itemCount <= 0) {
            return;
        }
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:0
                                                     inSection:0];

        self.itemCount--;

        [self.collectionView deleteItemsAtIndexPaths:@[indexPath]];
    }
                                  completion:nil];
}

-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.itemCount;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell"
                                                                           forIndexPath:indexPath];
    cell.backgroundColor = ([self.selectedIndexPaths containsObject:indexPath]) ? [UIColor blueColor] : [UIColor purpleColor];
    return cell;
}

// Methods for notification of selection/deselection and highlight/unhighlight events.
// The sequence of calls leading to selection from a user touch is:
//
// (when the touch begins)
// 1. -collectionView:shouldHighlightItemAtIndexPath:
// 2. -collectionView:didHighlightItemAtIndexPath:
//
// (when the touch lifts)
// 3. -collectionView:shouldSelectItemAtIndexPath: or -collectionView:shouldDeselectItemAtIndexPath:
// 4. -collectionView:didSelectItemAtIndexPath: or -collectionView:didDeselectItemAtIndexPath:
// 5. -collectionView:didUnhighlightItemAtIndexPath:


- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [self.selectedIndexPaths addObject:indexPath];
    [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor redColor];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView cellForItemAtIndexPath:indexPath].backgroundColor = [UIColor blueColor];
}

- (IBAction)changeLayout:(UIBarButtonItem *)sender {
    if (self.collectionView.collectionViewLayout == self.customLayout) {
        [self.collectionView setCollectionViewLayout:self.defaultLayout
                                            animated:YES];
    }
    else {
        [self.collectionView setCollectionViewLayout:self.customLayout
                                            animated:YES];
    }
}

@end
