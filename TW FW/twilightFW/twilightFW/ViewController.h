//
//  ViewController.h
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 24/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "webService.h"
#import "SBN_RSSReader.h"

@interface ViewController : UIViewController<webServiceSOAPDelegate,SBN_XMLDelegate>
- (IBAction)btnGet:(id)sender;
- (IBAction)btnPost:(id)sender;
- (IBAction)btnSOAP:(id)sender;
- (IBAction)btnXMLRead:(id)sender;
- (IBAction)btnShowShare:(id)sender;
- (IBAction)btnSendSMS:(id)sender;
- (IBAction)btnSendEmail:(id)sender;

@end
