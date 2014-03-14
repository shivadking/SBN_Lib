//
//  NSDate+Helpers.m
//  PMCalendar
//
//  Created by Pavel Mazurin on 7/14/12.
//  Copyright (c) 2012 Pavel Mazurin. All rights reserved.
//

#import "NSDate+SBN_Helpers.h"

@implementation NSDate (SBN_Helpers)


//
- (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed alwaysDisplayTime:(BOOL)displayTime {
    /*
	 * if the date is in today, display 12-hour time with meridian,
	 * if it is within the last 7 days, display weekday name (Friday)
	 * if within the calendar year, display as Jan 23
	 * else display as Nov 11, 2008
	 */
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateFormatter *displayFormatter = [[NSDateFormatter alloc] init];
    
	NSDate *today = [NSDate date];
    NSDateComponents *offsetComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
													 fromDate:today];
	
	NSDate *midnight = [calendar dateFromComponents:offsetComponents];
	NSString *displayString = nil;
	
	// comparing against midnight
    NSComparisonResult midnight_result = [date compare:midnight];
	if (midnight_result == NSOrderedDescending) {
		if (prefixed) {
			[displayFormatter setDateFormat:@"'at' h:mm a"]; // at 11:30 am
		} else {
			[displayFormatter setDateFormat:@"h:mm a"]; // 11:30 am
		}
	} else {
		// check if date is within last 7 days
		NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
		[componentsToSubtract setDay:-7];
		NSDate *lastweek = [calendar dateByAddingComponents:componentsToSubtract toDate:today options:0];
        NSComparisonResult lastweek_result = [date compare:lastweek];
		if (lastweek_result == NSOrderedDescending) {
            if (displayTime) {
                [displayFormatter setDateFormat:@"EEEE h:mm a"];
            } else {
                [displayFormatter setDateFormat:@"EEEE"]; // Tuesday
            }
		} else {
			// check if same calendar year
			NSInteger thisYear = [offsetComponents year];
			
			NSDateComponents *dateComponents = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
														   fromDate:date];
			NSInteger thatYear = [dateComponents year];
			if (thatYear >= thisYear) {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d"];
                }
			} else {
                if (displayTime) {
                    [displayFormatter setDateFormat:@"MMM d, yyyy h:mm a"];
                }
                else {
                    [displayFormatter setDateFormat:@"MMM d, yyyy"];
                }
			}
		}
		if (prefixed) {
			NSString *dateFormat = [displayFormatter dateFormat];
			NSString *prefix = @"'on' ";
			[displayFormatter setDateFormat:[prefix stringByAppendingString:dateFormat]];
		}
	}
	
	// use display formatter to return formatted date string
	displayString = [displayFormatter stringFromDate:date];
    
	return displayString;
}
- (NSString *)stringForDisplayFromDate:(NSDate *)date prefixed:(BOOL)prefixed {
	return [[self class] stringForDisplayFromDate:date prefixed:prefixed alwaysDisplayTime:NO];
}

- (NSString *)stringForDisplayFromDate:(NSDate *)date {
	return [self stringForDisplayFromDate:date prefixed:NO];
}

- (NSString *)stringWithFormat:(NSString *)format {
	NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
	[outputFormatter setDateFormat:format];
	NSString *timestamp_str = [outputFormatter stringFromDate:self];
	return timestamp_str;
}


//

- (NSDate *)dateWithoutTime
{
	NSCalendar *calendar = [NSCalendar currentCalendar];
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit 
                                                          | NSMonthCalendarUnit 
                                                          | NSDayCalendarUnit ) 
                                                fromDate:self];
	
	return [calendar dateFromComponents:components];
}

- (NSDate *) dateByAddingDays:(NSInteger) days months:(NSInteger) months years:(NSInteger) years
{
	NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
	dateComponents.day = days;
	dateComponents.month = months;
	dateComponents.year = years;
	
    return [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents
                                                         toDate:self
                                                        options:0];    
}

- (NSDate *) dateByAddingDays:(NSInteger) days
{
    return [self dateByAddingDays:days months:0 years:0];
}

/*-(NSDate*) dateBySubractingDays:(NSInteger) days
{
    NSDate *newDate1 = [self dateByAddingTimeInterval:-days*24*60*60];
    return newDate1;
}*/

/*-(NSDate*) dateBySubractingDays:(NSInteger) days
 {
 NSDate *newDate1 = [self dateByAddingTimeInterval:60*60*24*days];
 return newDate1;
 }*/

- (NSDate *) dateByAddingMonths:(NSInteger) months
{
    return [self dateByAddingDays:0 months:months years:0];
}

- (NSDate *) dateByAddingYears:(NSInteger) years
{
    return [self dateByAddingDays:0 months:0 years:years];
}

- (NSDate *) monthStartDate 
{
    NSDate *monthStartDate = nil;
	[[NSCalendar currentCalendar] rangeOfUnit:NSMonthCalendarUnit
                                    startDate:&monthStartDate 
                                     interval:NULL
                                      forDate:self];

	return monthStartDate;
}

- (NSDate *) midnightDate
{
    NSDate *midnightDate = nil;
	[[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit
                                    startDate:&midnightDate
                                     interval:NULL
                                      forDate:self];
    
	return midnightDate;
}

- (NSUInteger) numberOfDaysInMonth
{
    return [[NSCalendar currentCalendar] rangeOfUnit:NSDayCalendarUnit 
                                              inUnit:NSMonthCalendarUnit 
                                             forDate:self].length;
}

- (NSUInteger) weekday
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *weekdayComponents = [gregorian components:NSWeekdayCalendarUnit fromDate:self];
    
    return [weekdayComponents weekday];
}

- (NSString *) toStringWithFormat:(NSString *) format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
	return [formatter stringFromDate:self];
}

- (NSInteger) daysSinceDate:(NSDate *) date
{
    return round([self timeIntervalSinceDate:date] / (60 * 60 * 24));
}

- (BOOL) isBefore:(NSDate *) date
{
	return [self timeIntervalSinceDate:date] < 0;
}

- (BOOL) isAfter:(NSDate *) date
{
	return [self timeIntervalSinceDate:date] > 0;
}

NSDateComponents *components;
-(NSDateComponents*) cal:(NSDate*) date
{
    components = [[NSCalendar currentCalendar] components:NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit fromDate:date];
    return components;
}

-(NSInteger) MonthInNumber
{
    return [[self cal:self] month];
}
-(NSInteger) DayInNumber
{
    return [[self cal:self] day];
}
-(NSInteger) YearInNumber
{
    return [[self cal:self] year];
}
-(NSInteger) HourInNumber
{
    return [[self cal:self] hour];
}
-(NSInteger) MinuteInNumber
{
    return [[self cal:self] minute];
}
-(NSInteger) SecondsInNumber
{
    return [[self cal:self] second];
}

-(NSInteger) WeekInNumber
{
    return [[self cal:self] second];
}

NSDateFormatter *formatter;
-(void) callFormatter:(NSString*) formatStr
{
    formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:formatStr];
}

- (NSString *) MonthInString_Long
{
    [self callFormatter:FORMAT_MONTH];
	return [formatter stringFromDate:self];
}
- (NSString *) DayInString_Long
{
    [self callFormatter:FORMAT_DAY];
	return [formatter stringFromDate:self];
}
- (NSString *) MonthInString_Short
{
    [self callFormatter:FORMAT_MONTH_SHORT];
	return [formatter stringFromDate:self];
}
- (NSString *) DayInString_Short
{
    [self callFormatter:FORMAT_DAY_SHORT];
	return [formatter stringFromDate:self];
}

#pragma mark - Check isThisMonth etc

-(BOOL) isCurrentMonth
{
    return [self checkValidations:0 :self];
}
-(BOOL) isCurrentYear
{
    return [self checkValidations:1 :self];
}
-(BOOL) isCurrentDay
{
    return [self checkValidations:2 :self];
}
-(BOOL) isPreviousMonth
{
    return [self checkValidations:3 :self];
}
-(BOOL) isPreviousYear
{
    return [self checkValidations:4 :self];
}
-(BOOL) isPreviousDay
{
    return [self checkValidations:5 :self];
}
-(BOOL) isNextMonth
{
    return [self checkValidations:6 :self];
}
-(BOOL) isNextYear
{
    return [self checkValidations:7 :self];
}
-(BOOL) isNextDay
{
    return [self checkValidations:8 :self];
}
-(BOOL) isCurrentWeek
{
    return [self checkValidations:9 :self];
}
-(BOOL) isNextWeek
{
    return [self checkValidations:10 :self];
}
-(BOOL) isPreviousWeek
{
    return [self checkValidations:11 :self];
}
-(BOOL) checkValidations:(int) type :(NSDate*) userDate
{
    [self cal:userDate];
    int userMonth = [components month];
    int userDay = [components day];
    int userYear = [components year];
    int userWeek = [components week];
    
    [self cal:[NSDate date]];
    int curMonth = [components month];
    int curDay = [components day];
    int curYear = [components year];
    int curWeek = [components week];
    
    switch (type) {
        case 0://isCurMonth
            if(userYear == curYear && userMonth == curMonth)
                return YES;
            break;
        case 1://isCurYear
            if(userYear == curYear)
                return YES;
            break;
        case 2://isCurDay
            if(userDay == curDay)
                return YES;
            break;
        case 3://isPrevMonth
            if(userYear == curYear && userMonth == curMonth-1)
                return YES;
            break;
        case 4://isPrevYear
            if(userYear == curYear-1)
                return YES;
            break;
        case 5://isPrevDay
            if(userDay == curDay-1)
                return YES;
            break;
        case 6://isNextMonth
            if(userYear == curYear && userMonth == curMonth+1)
                return YES;
            break;
        case 7://isNextYear
            if(userYear == curYear+1)
                return YES;
            break;
        case 8://isNextDay
            if(userDay == curDay+1)
                return YES;
            break;
        case 9://isCurrentWeek
            if(userYear == curYear && userMonth == curMonth && userWeek == curWeek)
                return YES;
            break;
        case 10://isNextWeek
            if(userYear == curYear && userMonth == curMonth && userWeek == curWeek+1)
                return YES;
            break;
        case 11://isPreviousWeek
            if(userYear == curYear && userMonth == curMonth && userWeek == curWeek-1)
                return YES;
            break;
        default:
            break;
    }
    
    return NO;
}


#pragma mark - Others
- (NSDate *)beginningOfWeek {
	// largely borrowed from "Date and Time Programming Guide for Cocoa"
	// we'll use the default calendar and hope for the best
    
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *weekdayComponents = [calendar components:NSWeekdayCalendarUnit fromDate:self];
    
	/*
	 Create a date components to represent the number of days to subtract from the current date.
	 The weekday value for Sunday in the Gregorian calendar is 1, so subtract 1 from the number of days to subtract from the date in question.  (If today's Sunday, subtract 0 days.)
	 */
	NSDateComponents *componentsToSubtract = [[NSDateComponents alloc] init];
	[componentsToSubtract setDay: 0 - ([weekdayComponents weekday] - 1)];
	NSDate *beginningOfWeek = [calendar dateByAddingComponents:componentsToSubtract toDate:self options:0];
    
	//normalize to midnight, extract the year, month, and day components and create a new date from those components.
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
											   fromDate:beginningOfWeek];
	return [calendar dateFromComponents:components];
}

- (NSDate *)beginningOfDay {
	NSCalendar *calendar = [NSCalendar currentCalendar];
	// Get the weekday component of the current date
	NSDateComponents *components = [calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit)
											   fromDate:self];
	return [calendar dateFromComponents:components];
}

// Returns time string in 24-hour mode from the given NSDate
-(NSString *)time24FromDate:(NSDate *)date withTimeZone:(NSTimeZone *)timeZone
{
	NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
	[dateFormatter setDateFormat:@"HH:mm"];
	[dateFormatter setTimeZone:timeZone];
	[dateFormatter setLocale:[NSLocale systemLocale]];
	NSString* time = [dateFormatter stringFromDate:date];
    
	if (time.length > 5) {
		NSRange range;
		range.location = 3;
		range.length = 2;
		int hour = [[time substringToIndex:2] intValue];
		NSString *minute = [time substringWithRange:range];
		range = [time rangeOfString:@"AM"];
		if (range.length==0)
			hour += 12;
		time = [NSString stringWithFormat:@"%02d:%@", hour, minute];
	}
    
	return time;
}

// Returns a proper NSDate given a time string in 24-hour mode
-(NSDate *)dateFromTime24:(NSString *)time24String withTimeZone:(NSTimeZone *)timeZone
{
	int hour = [[time24String substringToIndex:2] intValue];
	int minute = [[time24String substringFromIndex:3] intValue];
	NSDateFormatter *dateFormatter= [[NSDateFormatter alloc] init];
	[dateFormatter setTimeZone:timeZone];
    
	NSDate *result;
	if ([self userSetTwelveHourMode]) {
		[dateFormatter setDateFormat:@"hh:mm aa"];
		if (hour > 12) {
			result = [dateFormatter dateFromString:[NSString stringWithFormat:@"%02d:%02d PM", hour - 12, minute]];
		} else {
			result = [dateFormatter dateFromString:[NSString stringWithFormat:@"%02d:%02d AM", hour, minute]];
		}
	} else {
		[dateFormatter setDateFormat:@"HH:mm"];
		result = [dateFormatter dateFromString:[NSString stringWithFormat:@"%02d:%02d", hour, minute]];
	}
    
	return result;
}

// Tests whether the user has set the 12-hour or 24-hour mode in their settings.
-(BOOL)userSetTwelveHourMode
{
	NSDateFormatter *testFormatter = [[NSDateFormatter alloc] init];
	[testFormatter setTimeStyle:NSDateFormatterShortStyle];
	NSString *testTime = [testFormatter stringFromDate:[NSDate date]];
	return [testTime hasSuffix:@"M"] || [testTime hasSuffix:@"m"];
}

// Converts a 24-hour time string to 12-hour time string
+(NSString *)time12FromTime24:(NSString *)time24String
{
	NSDateFormatter *testFormatter = [[NSDateFormatter alloc] init];
	int hour = [[time24String substringToIndex:2] intValue];
	int minute = [[time24String substringFromIndex:3] intValue];
    
	NSString *result = [NSString stringWithFormat:@"%02d:%02d %@", hour % 12, minute, hour > 12 ? [testFormatter PMSymbol] : [testFormatter AMSymbol]];
	return result;
}

@end
