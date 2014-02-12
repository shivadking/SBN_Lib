//
//  CheckBoxViewController.h
//  Checkbox
//
//  Created by Jeruel Fernandes on 14/04/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CheckBox.h"

@interface CheckBoxViewController : UIViewController <CheckBoxDelegate>

@property (strong, nonatomic) UIView *vw_Container;

#pragma mark Loading Functions
- (void)loadScreen;

#pragma mark Unloading Functions
- (void)unloadScreen;

@end
