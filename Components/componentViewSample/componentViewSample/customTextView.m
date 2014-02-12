//
//  customTextView.m
//  componentViewSample
//
//  Created by Mini Mac i72 on 1/22/14.
//  Copyright (c) 2014 Mini Mac i72. All rights reserved.
//

#import "customTextView.h"

@implementation customTextView

@synthesize color;



- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        width = self.frame.size.width / 8.0;
        
        path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, width, self.frame.size.height / 2);
        CGPathAddLineToPoint(path, NULL, self.frame.size.width * 0.4, self.frame.size.height - width);
        CGPathAddLineToPoint(path, NULL, self.frame.size.width - width, width);
        
        self.backgroundColor = [UIColor whiteColor];
        self.color = [UIColor blackColor];
        
        // toggle action
        //[self addTarget:self action:@selector(toggleChecked) forControlEvents:UIControlEventTouchUpInside];
    }
    return self;
}

-(void) setChecked:(BOOL)checked
{
    NSLog(@"Checke Clicked");
}

- (void) drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    // background
    CGContextSetFillColorWithColor(context, self.backgroundColor.CGColor);
    CGContextFillRect(context, rect);
    
    // check mark
 
        CGContextSetStrokeColorWithColor(context, color.CGColor);
        CGContextSetShouldAntialias(context, YES);
        CGContextSetLineCap(context, kCGLineCapRound);
        CGContextSetLineWidth(context, width);
        
        CGContextBeginPath(context);
        CGContextAddPath(context, path);
        CGContextStrokePath(context);
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
