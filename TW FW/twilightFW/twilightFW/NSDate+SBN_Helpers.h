//
//  NSDate+Helpers.h
//  PMCalendar
//
//  Created by Pavel Mazurin on 7/14/12.
//  Copyright (c) 2012 Pavel Mazurin. All rights reserved.
//

//Formating
// @"EEE, dd MMM yyyy HH:mm:ss ZZZ" ===> @"Fri, 21 Feb 2014 01:30:00 GMT"

#import <Foundation/Foundation.h>
#define FORMAT_MONTH @"MMMM"
#define FORMAT_DAY @"EEEE"
#define FORMAT_MONTH_SHORT @"MMM"
#define FORMAT_DAY_SHORT @"EEE"
/**
 * NSDate convenience methods which shortens some of frequently used formatting and date altering methods.
 */
@interface NSDate (SBN_Helpers)

/**
 * Returns current (self) date without time components. Effectively, it's just a beginning of a day.
 */
- (NSDate *) dateWithoutTime;

/**
 * Returns a date object shifted by a given number of days from the current (self) date.
 */
- (NSDate *) dateByAddingDays:(NSInteger) days;

/**
 * Returns a date object subracted date by a given number of days from the current (self) date.
 */
//- (NSDate *) dateBySubractingDays:(NSInteger) days;

/**
 * Returns a date object shifted by a given number of months from the current (self) date.
 */
- (NSDate *) dateByAddingMonths:(NSInteger) months;

/**
 * Returns a date object shifted by a given number of years from the current (self) date.
 */
- (NSDate *) dateByAddingYears:(NSInteger) years;

/**
 * Returns a date object shifted by a given number of days, months and years from the current (self) date.
 */
- (NSDate *) dateByAddingDays:(NSInteger) days months:(NSInteger) months years:(NSInteger) years;

/**
 * Returns start of month for the current (self) date.
 */
- (NSDate *) monthStartDate;

/**
 * Returns start of day for the current (self) date.
 */
- (NSDate *) midnightDate;

/**
 * Returns the number of days in the current (self) month.
 */
- (NSUInteger) numberOfDaysInMonth;

/**
 * Returns the weekday of the current (self) date.
 * 
 * Returns 1 for Sunday, 2 for Monday ... 7 for Saturday
 */
- (NSUInteger) weekday;

/**
 * Returns the number of days since given date.
 */
- (NSInteger) daysSinceDate:(NSDate *) date;

/**
 * Returns string representation of the current (self) date formatted with given format.
 *
 * i.e. "dd-MM-yyyy" will return "14-07-2012"
 */
- (NSString *) toStringWithFormat:(NSString *) format;

/**
 * Checks if a given date is before or after the current (self) date.
 */
- (BOOL) isBefore:(NSDate *) date;
- (BOOL) isAfter:(NSDate *) date;

/**
 * Get Month, Year, Day Hour, Minutes, Seconds in Number formats for the Given (self) date
 * Eg: 02  2014   23 .....   23 55 02
 */
-(NSInteger) MonthInNumber;
-(NSInteger) DayInNumber;
-(NSInteger) YearInNumber;
-(NSInteger) HourInNumber;
-(NSInteger) MinuteInNumber;
-(NSInteger) SecondsInNumber;
-(NSInteger) WeekInNumber;
/**
 * Get Month, Year, Day in String formats for the Given (self) date
 * Eg: Feb  wednesday
 */
- (NSString *) MonthInString_Long;
- (NSString *) DayInString_Long;
- (NSString *) MonthInString_Short;
- (NSString *) DayInString_Short;

/**
 * Its reture is current, previous, next for Month, Year, day, week'
 * Eg: 02/01/2014 - isCurrentMonth - Result : Yes / No
 */
-(BOOL) isCurrentMonth;
-(BOOL) isCurrentYear;
-(BOOL) isCurrentDay;
-(BOOL) isPreviousMonth;
-(BOOL) isPreviousYear;
-(BOOL) isPreviousDay;
-(BOOL) isNextMonth;
-(BOOL) isNextYear;
-(BOOL) isNextDay;
-(BOOL) isCurrentWeek;
-(BOOL) isNextWeek;
-(BOOL) isPreviousWeek;

//Others
- (NSDate *)beginningOfWeek;

@end
