//
//  customTextField.m
//  componentViewSample
//
//  Created by Mini Mac i72 on 1/22/14.
//  Copyright (c) 2014 Mini Mac i72. All rights reserved.
//

#import "customTextField.h"
#import <QuartzCore/QuartzCore.h>

@implementation customTextField

bool isBeging = YES;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        
        [self addTarget:self action:@selector(toggleBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(toggleEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return self;
}

-(void) toggleBegin:(UITextField*) text
{
    isBeging = YES;
    [self setNeedsDisplay];
    
}

-(void) toggleEnd:(UITextField*) text
{
    isBeging = NO;
    [self setNeedsDisplay];
    
}

- (void)drawRect:(CGRect)rect
{
    if(isBeging)
    {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        CALayer *layer = self.layer;
        layer.backgroundColor = [[UIColor whiteColor] CGColor];
        layer.cornerRadius = 15.0;
        layer.masksToBounds = YES;
        layer.borderWidth = 1.0;
        layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor];
        [layer setShadowColor: [[UIColor blackColor] CGColor]];
        [layer setShadowOpacity:1];
        [layer setShadowOffset: CGSizeMake(0, 2.0)];
        [layer setShadowRadius:5];
        [self setClipsToBounds:NO];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }else
    {
        self.autocorrectionType = UITextAutocorrectionTypeNo;
        self.autocapitalizationType = UITextAutocapitalizationTypeNone;
        CALayer *layer = self.layer;
        layer.backgroundColor = [[UIColor whiteColor] CGColor];
        layer.cornerRadius = 0.0;
        layer.masksToBounds = YES;
        layer.borderWidth = 0.0;
        layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor];
        [layer setShadowColor: [[UIColor blackColor] CGColor]];
        [layer setShadowOpacity:1];
        [layer setShadowOffset: CGSizeMake(0, 2.0)];
        [layer setShadowRadius:5];
        [self setClipsToBounds:NO];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
    }
    
}
- (CGRect)textRectForBounds:(CGRect)bounds {
    return CGRectMake(bounds.origin.x + 20, bounds.origin.y + 8,
                      bounds.size.width - 40, bounds.size.height - 16);
}
- (CGRect)editingRectForBounds:(CGRect)bounds {
    return [self textRectForBounds:bounds];
}
/*
 //Original Code for Rect TextBox
 - (void)drawRect:(CGRect)rect
 {
 
 self.autocorrectionType = UITextAutocorrectionTypeNo;
 self.autocapitalizationType = UITextAutocapitalizationTypeNone;
 CALayer *layer = self.layer;
 layer.backgroundColor = [[UIColor whiteColor] CGColor];
 layer.cornerRadius = 15.0;
 layer.masksToBounds = YES;
 layer.borderWidth = 1.0;
 layer.borderColor = [[UIColor colorWithRed:0 green:0 blue:0 alpha:1] CGColor];
 [layer setShadowColor: [[UIColor blackColor] CGColor]];
 [layer setShadowOpacity:1];
 [layer setShadowOffset: CGSizeMake(0, 2.0)];
 [layer setShadowRadius:5];
 [self setClipsToBounds:NO];
 [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
 [self setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
 }
 - (CGRect)textRectForBounds:(CGRect)bounds {
 return CGRectMake(bounds.origin.x + 20, bounds.origin.y + 8,
 bounds.size.width - 40, bounds.size.height - 16);
 }
 - (CGRect)editingRectForBounds:(CGRect)bounds {
 return [self textRectForBounds:bounds];
 }
 */

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
