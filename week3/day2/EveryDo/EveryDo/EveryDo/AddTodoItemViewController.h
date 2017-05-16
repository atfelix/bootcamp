//
//  AddTodoItemViewController.h
//  EveryDo
//
//  Created by atfelix on 2017-05-16.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TodoObject;

@protocol AddTodoItemDelegate <NSObject>

-(void)saveTodoItem:(TodoObject *)todo;

@end

@interface AddTodoItemViewController : UIViewController

@property (nonatomic, weak) id<AddTodoItemDelegate> delegate;

@end
