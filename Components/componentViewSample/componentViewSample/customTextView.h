//
//  customTextView.h
//  componentViewSample
//
//  Created by Mini Mac i72 on 1/22/14.
//  Copyright (c) 2014 Mini Mac i72. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol customTextViewDelegate;

@interface customTextView : UIControl{
    CGFloat width;
    CGMutablePathRef path;
    
}
@property (nonatomic, strong) UIColor *color;

@property (nonatomic, assign) BOOL checked;

@property (nonatomic, weak) id<customTextViewDelegate> delegate;



@end


@protocol customTextViewDelegate

- (void) checkView:(customTextView *)checkView didChangeToChecked:(BOOL)checked;

@end