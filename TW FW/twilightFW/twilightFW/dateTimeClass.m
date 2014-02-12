//
//  dateTimeClass.m
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 07/01/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "dateTimeClass.h"

@implementation dateTimeClass

+(dateTimeClass *)getCommon {
    static dateTimeClass *__instance = nil;
    if (__instance == nil) {
        __instance = [[dateTimeClass alloc] init];
    }
    
    return __instance;
}

-(NSString*) DT_ConvertDateToString:(NSDate*) dt withFormatString:(NSString*) formats
{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:formats];  //@"yyyy-MM-dd"    
    NSString *theDate = [dateFormat stringFromDate:dt];    
    return theDate;
}

-(NSDate*) DT_ConvertStringToDate:(NSString*) str withFormatString:(NSString*) formats
{
    NSDateFormatter *dateFormater=[[NSDateFormatter alloc]init];
    //04/14/2013
    [dateFormater setDateFormat:formats];//@"MM/dd/yyyy'T'HH:mm:ss"];
    NSDate *date =[dateFormater dateFromString:str];
    return date;
}

-(NSDate*) DT_MinusDate:(NSDate*) dt daysToMinus:(id) numbers
{
    int daysToSubtract = 0;
    if([numbers isKindOfClass:[NSString class]])
    {
        daysToSubtract = [numbers intValue];
    }else if([numbers isKindOfClass:[NSNumber class]])
    {
        daysToSubtract = (int)numbers;
    }
    NSDate *newDate1 = [dt dateByAddingTimeInterval:-daysToSubtract*24*60*60];
    
    return newDate1;
}

-(NSDate*) DT_AddDate:(NSDate*) dt daysToAdd:(id) numbers
{
    int daysToAdd = 0;
    if([numbers isKindOfClass:[NSString class]])
    {
        daysToAdd = [numbers intValue];
    }else if([numbers isKindOfClass:[NSNumber class]])
    {
        daysToAdd = (int)numbers;
    }
    NSDate *newDate1 = [dt dateByAddingTimeInterval:60*60*24*daysToAdd];
    
    return newDate1;
}

-(int) DT_DiffernceBetweenTwoDates:(NSDate*) date1 withTo:(NSDate*) date2
{
    NSTimeInterval secondsBetween = [date2 timeIntervalSinceDate:date1];
    
    int numberOfDays = secondsBetween / 86400;
    
    NSLog(@"There are %d days in between the two dates.", numberOfDays);
    return numberOfDays;
}

-(int) DT_FindIsBigger:(NSDate*) date1 withTo:(NSDate*) date2
{
    NSTimeInterval secondsBetween = [date1 timeIntervalSinceDate:date2];
    
    int numberOfDays = secondsBetween / 86400;
    
    NSLog(@"There are %d days in between the two dates.", numberOfDays);
    if(numberOfDays == 0)
    {
        return 0;
    }else if(numberOfDays>0)
    {
        return 1;
    }else
    {
        return 2;
    }
    
}

@end
