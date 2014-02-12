//
//  ViewController.m
//  SocialNetworkConnection
//
//  Created by Thiruvengadam Krishnasamy on 27/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)facebookpost:(id)sender {
    
    
}

- (IBAction)twitterpost:(id)sender {
    
    SLComposeViewController *tweetSheet =[SLComposeViewController
    composeViewControllerForServiceType:SLServiceTypeTwitter];
    [tweetSheet setInitialText:@"My test tweet"];
    [self presentModalViewController:tweetSheet animated:YES];
    
    
}
@end
