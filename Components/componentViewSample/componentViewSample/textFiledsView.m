//
//  textFiledsView.m
//  componentViewSample
//
//  Created by Mini Mac i72 on 1/22/14.
//  Copyright (c) 2014 Mini Mac i72. All rights reserved.
//

#import "textFiledsView.h"

@implementation textFiledsView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        //[self setTextColor:_color];
        [self editEnd:self];
        [self addTarget:self action:@selector(editBegin:) forControlEvents:UIControlEventEditingDidBegin];
        [self addTarget:self action:@selector(editEnd:) forControlEvents:UIControlEventEditingDidEnd];
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void) editBegin:(UITextField*) text
{
    [text setBackgroundColor:[UIColor blackColor]];
    [self setTextColor:[UIColor whiteColor]];
}


-(void) editEnd:(UITextField*) text
{
    [text setBackgroundColor:[UIColor greenColor]];
    [self setTextColor:[UIColor redColor]];
}


@end
