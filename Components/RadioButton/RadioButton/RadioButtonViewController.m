//
//  RadioButtonViewController.m
//  RadioButton
//
//  Created by Jeruel Fernandes on 15/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "RadioButtonViewController.h"

@implementation RadioButtonViewController

@synthesize vw_Container;

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    
    [self loadScreen];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    [self unloadScreen];
}

#pragma mark Loading Functions

- (void)loadScreen
{
    vw_Container            = [[UIView alloc] initWithFrame:CGRectMake(0,0,320,480)];
    [self.view addSubview:vw_Container];
    
    UILabel *lbl_QuestionOne        = [[UILabel alloc] initWithFrame:CGRectMake(0,5,320,30)];
    lbl_QuestionOne.backgroundColor = [UIColor clearColor];
    lbl_QuestionOne.text            = @"Which sport is your favourite?";
    lbl_QuestionOne.textAlignment   = UITextAlignmentCenter;
    [vw_Container addSubview:lbl_QuestionOne];
    
    RadioButton *rb1                   = [[RadioButton alloc] initWithFrame:CGRectMake(10, 40, 150, 30)];
    [rb1 setGroupID:0 AndID:0 AndTitle:@"Motorsport"];
    rb1.delegate                    = self;
    [vw_Container addSubview:rb1];
    
    RadioButton *rb2                   = [[RadioButton alloc] initWithFrame:CGRectMake(10, 80, 150, 30)];
    [rb2 setGroupID:0 AndID:1 AndTitle:@"Football"];
    rb2.delegate                    = self;
    [vw_Container addSubview:rb2];
    
    UILabel *lbl_QuestionTwo        = [[UILabel alloc] initWithFrame:CGRectMake(0,120,320,30)];
    lbl_QuestionTwo.backgroundColor = [UIColor clearColor];
    lbl_QuestionTwo.text            = @"What is your gender?";
    lbl_QuestionTwo.textAlignment   = UITextAlignmentCenter;
    [vw_Container addSubview:lbl_QuestionTwo];
    
    RadioButton *rb3                   = [[RadioButton alloc] initWithFrame:CGRectMake(10, 155, 150, 30)];
    [rb3 setGroupID:1 AndID:0 AndTitle:@"Male"];
    rb3.delegate                    = self;
    [vw_Container addSubview:rb3];    
    
    RadioButton *rb4                   = [[RadioButton alloc] initWithFrame:CGRectMake(10, 195, 150, 30)];
    [rb4 setGroupID:1 AndID:1 AndTitle:@"Female"];
    rb4.delegate                    = self;
    [vw_Container addSubview:rb4]; 
}

#pragma mark Unloading Functions

- (void)unloadScreen
{
    if(vw_Container != nil)
    {
        [vw_Container removeFromSuperview];
        vw_Container = nil;
    }
}

#pragma mark Delegate Functions

- (void)stateChangedForGroupID:(NSUInteger)indexGroup WithSelectedButton:(NSUInteger)indexID
{
    NSLog(@"Group %d - Button %d", indexGroup, indexID);
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
