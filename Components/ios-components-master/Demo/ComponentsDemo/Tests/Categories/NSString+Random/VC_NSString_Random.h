//
//  VC_NSString_Random.h
//  ComponentsDemo
//
//  Created by Davide De Rosa on 11/15/11.
//  Copyright (c) 2011 algoritmico. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VC_NSString_Random : UIViewController

@property (nonatomic, strong) UITextField *outputField;

- (void) generateString;

@end
