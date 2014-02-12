//
//  RadioButtonViewController.h
//  RadioButton
//
//  Created by Jeruel Fernandes on 15/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RadioButton.h"

@interface RadioButtonViewController : UIViewController <RadioButtonDelegate>

@property (strong, nonatomic) UIView *vw_Container;

#pragma mark Loading Functions
- (void)loadScreen;

#pragma mark Unloading Functions
- (void)unloadScreen;

@end
