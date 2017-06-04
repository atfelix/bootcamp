//
//  ViewController.h
//  MDC-Tutorial
//
//  Created by atfelix on 2017-05-27.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MaterialCollections.h"
#import "MaterialButtons.h"
#import "MaterialAppBar.h"


@interface ViewController : MDCCollectionViewController

@property (nonatomic) MDCAppBar *appBar;
@property (nonatomic) MDCFloatingButton *fab;

@end
