//
//  AutocompleteDemoAppDelegate.h
//  AutocompleteDemo
//
//  Created by Radu on 9/9/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AutocompleteDemoViewController;

@interface AutocompleteDemoAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    AutocompleteDemoViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet AutocompleteDemoViewController *viewController;

@end

