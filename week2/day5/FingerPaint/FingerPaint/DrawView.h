//
//  DrawView.h
//  FingerPaint
//
//  Created by atfelix on 2017-05-20.
//  Copyright © 2017 Adam Felix. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, DrawViewEditingMode) {
    DrawViewDrawMode,
    DrawViewEraseMode,
    DrawViewTextMode
};

@protocol DrawViewDelegate <NSObject>

-(UIColor *)currentStrokeColor;

@end

@interface DrawView : UIView

@property (nonatomic) id<DrawViewDelegate> delegate;

@end
