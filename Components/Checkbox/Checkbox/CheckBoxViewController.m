//
//  CheckBoxViewController.m
//  Checkbox
//
//  Created by Jeruel Fernandes on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "CheckBoxViewController.h"

@implementation CheckBoxViewController

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
    
    UILabel *lbl_Question           = [[UILabel alloc] initWithFrame:CGRectMake(0,5,320,30)];
    lbl_Question.backgroundColor    = [UIColor clearColor];
    lbl_Question.text               = @"Which sports do you like?";
    lbl_Question.textAlignment      = UITextAlignmentCenter;
    [vw_Container addSubview:lbl_Question];
    
    CheckBox *cb1                   = [[CheckBox alloc] initWithFrame:CGRectMake(10, 40, 150, 30)];
    [cb1 setID:0 AndSelected:YES AndTitle:@"Motorsport"];
    cb1.delegate                    = self;
    [vw_Container addSubview:cb1];
    
    CheckBox *cb2                   = [[CheckBox alloc] initWithFrame:CGRectMake(10, 80, 150, 30)];
    [cb2 setID:1 AndSelected:NO AndTitle:@"Football"];
    cb2.delegate                    = self;
    [vw_Container addSubview:cb2];
    
    CheckBox *cb3                   = [[CheckBox alloc] initWithFrame:CGRectMake(10, 120, 150, 30) AndID:2 AndSelected:YES AndTitle:@"Pool"];
    cb3.delegate                    = self;
    [vw_Container addSubview:cb3];
    
    NSLog(@"State - %d", [cb1 currentState]);
    NSLog(@"State - %d", [cb2 currentState]);
    NSLog(@"State - %d", [cb3 currentState]);
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

- (void)stateChangedForID:(NSUInteger)index WithCurrentState:(BOOL)currentState
{
    NSLog(@"Index %d - State %d", index, currentState);
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
