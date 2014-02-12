//
//  dateTimeClass.h
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 07/01/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface dateTimeClass : NSObject
+(dateTimeClass *)getCommon;
-(NSDate*) DT_AddDate:(NSDate*) dt daysToAdd:(id) numbers;
-(int) DT_FindIsBigger:(NSDate*) date1 withTo:(NSDate*) date2;
@end
