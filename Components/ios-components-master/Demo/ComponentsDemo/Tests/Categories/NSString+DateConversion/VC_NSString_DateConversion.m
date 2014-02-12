//
//  VC_NSString_DateConversion.m
//  ComponentsDemo
//
//  Created by Davide De Rosa on 11/6/11.
//  Copyright (c) 2011 algoritmico. All rights reserved.
//

#import "VC_NSString_DateConversion.h"
#import "NSString+DateConversion.h"

@implementation VC_NSString_DateConversion

@synthesize inputDate;
@synthesize inputFormat;
@synthesize outputFormat;
@synthesize outputDate;
@synthesize convertButton;

- (void) dealloc
{
    self.inputDate = nil;
    self.inputFormat = nil;
    self.outputFormat = nil;
    self.outputDate = nil;
    self.convertButton = nil;

    [super ah_dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIScrollView *scroller = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    CGSize scrollableSize = self.view.frame.size;
    scrollableSize.height += 100;
    scroller.contentSize = scrollableSize;
    const CGFloat x = 20;
    const CGFloat width = scrollableSize.width - 2 * x;
    
    inputDate = [[UITextField alloc] initWithFrame:CGRectMake(x, 20, width, 30)];
    inputDate.placeholder = @"Input date (e.g.: 06/15/2011)";
    inputFormat = [[UITextField alloc] initWithFrame:CGRectMake(x, 60, width, 30)];
    inputFormat.placeholder = @"Input format (e.g.: MM/dd/yyyy)";
    outputFormat = [[UITextField alloc] initWithFrame:CGRectMake(x, 100, width, 30)];
    outputFormat.placeholder = @"Output format (e.g.: eee dd)";
    outputDate = [[UILabel alloc] initWithFrame:CGRectMake(x, 140, width, 50)];
    self.convertButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    
    inputDate.borderStyle = UITextBorderStyleRoundedRect;
    inputDate.delegate = self;
    inputFormat.borderStyle = UITextBorderStyleRoundedRect;
    inputFormat.delegate = self;
    outputFormat.borderStyle = UITextBorderStyleRoundedRect;
    outputFormat.delegate = self;
    convertButton.frame = CGRectMake(20, 200, width, 40);
    [convertButton setTitle:@"Convert" forState:UIControlStateNormal];
    [convertButton addTarget:self action:@selector(convertDate:) forControlEvents:UIControlEventTouchUpInside];
    
    [scroller addSubview:inputDate];
    [scroller addSubview:inputFormat];
    [scroller addSubview:outputFormat];
    [scroller addSubview:outputDate];
    [scroller addSubview:convertButton];
    
    [self.view addSubview:scroller];
    [scroller release];
}

- (void)viewDidUnload
{
    [super viewDidUnload];

    self.inputDate = nil;
    self.inputFormat = nil;
    self.outputFormat = nil;
    self.outputDate = nil;
    self.convertButton = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return NO;
}

- (void) convertDate:(id)sender
{
    outputDate.text = [inputDate.text dateStringFromFormat:inputFormat.text toFormat:outputFormat.text];

    [self.view endEditing:NO];    
}

#pragma mark - UITextFieldDelegate

- (void) textFieldDidEndEditing:(UITextField *)textField
{
    [textField resignFirstResponder];
}

@end
