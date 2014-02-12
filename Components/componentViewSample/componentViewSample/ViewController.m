//
//  ViewController.m
//  componentViewSample
//
//  Created by Mini Mac i72 on 1/22/14.
//  Copyright (c) 2014 Mini Mac i72. All rights reserved.
//

#import "ViewController.h"
#import "customTextView.h"
#import "textFiledsView.h"
#import "customTextField.h"

@interface ViewController ()

@end

@implementation ViewController

textFiledsView *textS, *textS2;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    customTextView *textF = [[customTextView alloc] initWithFrame:CGRectMake(20, 20, 50, 50)];
    textF.color = [UIColor greenColor];
    textF.backgroundColor = [UIColor blackColor];
    textF.delegate = self;
    textF.checked = YES;
    [self.view addSubview:textF];
    
    
    textS = [[textFiledsView alloc] initWithFrame:CGRectMake(20, 100, 280, 30)];
    textS.delegate = self;
    [self.view addSubview:textS];
    
    textS2 = [[textFiledsView alloc] initWithFrame:CGRectMake(20, 150, 280, 30)];
    textS2.delegate = self;
    [self.view addSubview:textS2];
    
    customTextField *custom = [[customTextField alloc] initWithFrame:CGRectMake(20, 190, 280, 30)];
    custom.delegate = self;
    [self.view addSubview:custom];

    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(BOOL) textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    NSLog(@"dfasd");
    return YES;
}

@end
