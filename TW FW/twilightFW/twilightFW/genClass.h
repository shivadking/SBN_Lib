//
//  genClass.h
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 24/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface genClass : NSObject
+(genClass *)getCommon;
- (NSMutableDictionary *)appNameAndVersionNumberDisplayString;
+(void)makeTost:(id)sender withMessage:(NSString *)message;
+(void) print;


#pragma mark - Keyboard & Toolbars
+(UIToolbar *)getKeyboardToolbar:(id)sender type:(int) type;
    // S - Space, P - Previous, N - Next, D - Done, C - Cancel, Cl - Clear
    // type: 0 - (P,N,S,D), 1 - (S,D), 2 - (C,S,D), 3 - (S,Cl), 4 - (S,N)
@end
