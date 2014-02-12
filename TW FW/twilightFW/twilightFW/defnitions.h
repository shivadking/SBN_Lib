//
//  defnitions.h
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 28/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#ifndef twilightFW_defnitions_h

#define twilightFW_defnitions_h

#define NETWORK_ERROR @"Network Error"

#define APP_TITLE @"Apple Title"


#pragma mark - Logs
#define XLog(FORMAT, ...)  printf("%s [Line %d]: %s\n",__PRETTY_FUNCTION__, __LINE__,[[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]);


#pragma mark - Push & Pops
#define pushViewAnim(x) [self.navigationController pushViewController:x animated:YES];
#define pushView(x) [self.navigationController pushViewController:x animated:NO];
#define popViewAnim [self.navigationController popViewControllerAnimated:YES];
#define popView [self.navigationController popViewControllerAnimated:YES];
#define presentViewAnim(x) [self presentViewController:x animated:YES completion:nil];
#define presentView(x) [self presentViewController:x animated:NO completion:nil];
#define dismissViewAnim [self dismissViewControllerAnimated:YES completion:nil];
#define dismissView [self dismissViewControllerAnimated:NO completion:nil];



#pragma mark - Local Storages
//NSuser Defaults Process
#define allocUserDefault NSUserDefaults *dVal = [NSUserDefaults standardUserDefaults]
#define getUserDefault(key) [dVal objectForKey:key]
#define setUserDefault(values,key) [dVal setObject:values forKey:key]


#pragma mark - DateFormatings
/*
 The formats are as follows. Exactly the components shown here must be present, with exactly this punctuation. Note that the "T" appears literally in the string, to indicate the beginning of the time element, as specified in ISO 8601.
 Year:
 YYYY (eg 1997)
 Year and month:
 YYYY-MM (eg 1997-07)
 Complete date:
 YYYY-MM-DD (eg 1997-07-16)
 Complete date plus hours and minutes:
 YYYY-MM-DDThh:mmTZD (eg 1997-07-16T19:20+01:00)
 Complete date plus hours, minutes and seconds:
 YYYY-MM-DDThh:mm:ssTZD (eg 1997-07-16T19:20:30+01:00)
 Complete date plus hours, minutes, seconds and a decimal fraction of a
 second
 YYYY-MM-DDThh:mm:ss.sTZD (eg 1997-07-16T19:20:30.45+01:00)
 where:
 
 YYYY = four-digit year
 MM   = two-digit month (01=January, etc.)
 DD   = two-digit day of month (01 through 31)
 hh   = two digits of hour (00 through 23) (am/pm NOT allowed)
 mm   = two digits of minute (00 through 59)
 ss   = two digits of second (00 through 59)
 s    = one or more digits representing a decimal fraction of a second
 TZD  = time zone designator (Z or +hh:mm or -hh:mm)
 */
#define DT_basicDate @"yyyyMMdd";
#define DT_basicDateTime @"yyyyMMdd";
#define DT_ @"yyyyMMdd";
#define DT_ @"yyyyMMdd";
#define DT_ @"yyyyMMdd";
#define DT_ @"yyyyMMdd";

/*
 static DateTimeFormatter	basicDate()
 Returns a basic formatter for a full date as four digit year, two digit month of year, and two digit day of month (yyyyMMdd).
 static DateTimeFormatter	basicDateTime()
 Returns a basic formatter that combines a basic date and time, separated by a 'T' (yyyyMMdd'T'HHmmss.SSSZ).
 static DateTimeFormatter	basicDateTimeNoMillis()
 Returns a basic formatter that combines a basic date and time without millis, separated by a 'T' (yyyyMMdd'T'HHmmssZ).
 static DateTimeFormatter	basicOrdinalDate()
 Returns a formatter for a full ordinal date, using a four digit year and three digit dayOfYear (yyyyDDD).
 static DateTimeFormatter	basicOrdinalDateTime()
 Returns a formatter for a full ordinal date and time, using a four digit year and three digit dayOfYear (yyyyDDD'T'HHmmss.SSSZ).
 static DateTimeFormatter	basicOrdinalDateTimeNoMillis()
 Returns a formatter for a full ordinal date and time without millis, using a four digit year and three digit dayOfYear (yyyyDDD'T'HHmmssZ).
 static DateTimeFormatter	basicTime()
 Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit millis, and time zone offset (HHmmss.SSSZ).
 static DateTimeFormatter	basicTimeNoMillis()
 Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and time zone offset (HHmmssZ).
 static DateTimeFormatter	basicTTime()
 Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit millis, and time zone offset prefixed by 'T' ('T'HHmmss.SSSZ).
 static DateTimeFormatter	basicTTimeNoMillis()
 Returns a basic formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and time zone offset prefixed by 'T' ('T'HHmmssZ).
 static DateTimeFormatter	basicWeekDate()
 Returns a basic formatter for a full date as four digit weekyear, two digit week of weekyear, and one digit day of week (xxxx'W'wwe).
 static DateTimeFormatter	basicWeekDateTime()
 Returns a basic formatter that combines a basic weekyear date and time, separated by a 'T' (xxxx'W'wwe'T'HHmmss.SSSZ).
 static DateTimeFormatter	basicWeekDateTimeNoMillis()
 Returns a basic formatter that combines a basic weekyear date and time without millis, separated by a 'T' (xxxx'W'wwe'T'HHmmssZ).
 static DateTimeFormatter	date()
 Returns a formatter for a full date as four digit year, two digit month of year, and two digit day of month (yyyy-MM-dd).
 static DateTimeFormatter	dateElementParser()
 Returns a generic ISO date parser for parsing dates.
 static DateTimeFormatter	dateHour()
 Returns a formatter that combines a full date and two digit hour of day.
 static DateTimeFormatter	dateHourMinute()
 Returns a formatter that combines a full date, two digit hour of day, and two digit minute of hour.
 static DateTimeFormatter	dateHourMinuteSecond()
 Returns a formatter that combines a full date, two digit hour of day, two digit minute of hour, and two digit second of minute.
 static DateTimeFormatter	dateHourMinuteSecondFraction()
 Returns a formatter that combines a full date, two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (yyyy-MM-dd'T'HH:mm:ss.SSS).
 static DateTimeFormatter	dateHourMinuteSecondMillis()
 Returns a formatter that combines a full date, two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (yyyy-MM-dd'T'HH:mm:ss.SSS).
 static DateTimeFormatter	dateOptionalTimeParser()
 Returns a generic ISO datetime parser where the date is mandatory and the time is optional.
 static DateTimeFormatter	dateParser()
 Returns a generic ISO date parser for parsing dates with a possible zone.
 static DateTimeFormatter	dateTime()
 Returns a formatter that combines a full date and time, separated by a 'T' (yyyy-MM-dd'T'HH:mm:ss.SSSZZ).
 static DateTimeFormatter	dateTimeNoMillis()
 Returns a formatter that combines a full date and time without millis, separated by a 'T' (yyyy-MM-dd'T'HH:mm:ssZZ).
 static DateTimeFormatter	dateTimeParser()
 Returns a generic ISO datetime parser which parses either a date or a time or both.
 static DateTimeFormatter	forFields(Collection<DateTimeFieldType> fields, boolean extended, boolean strictISO)
 Returns a formatter that outputs only those fields specified.
 static DateTimeFormatter	hour()
 Returns a formatter for a two digit hour of day.
 static DateTimeFormatter	hourMinute()
 Returns a formatter for a two digit hour of day and two digit minute of hour.
 static DateTimeFormatter	hourMinuteSecond()
 Returns a formatter for a two digit hour of day, two digit minute of hour, and two digit second of minute.
 static DateTimeFormatter	hourMinuteSecondFraction()
 Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (HH:mm:ss.SSS).
 static DateTimeFormatter	hourMinuteSecondMillis()
 Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and three digit fraction of second (HH:mm:ss.SSS).
 static DateTimeFormatter	localDateOptionalTimeParser()
 Returns a generic ISO datetime parser where the date is mandatory and the time is optional.
 static DateTimeFormatter	localDateParser()
 Returns a generic ISO date parser for parsing local dates.
 static DateTimeFormatter	localTimeParser()
 Returns a generic ISO time parser for parsing local times.
 static DateTimeFormatter	ordinalDate()
 Returns a formatter for a full ordinal date, using a four digit year and three digit dayOfYear (yyyy-DDD).
 static DateTimeFormatter	ordinalDateTime()
 Returns a formatter for a full ordinal date and time, using a four digit year and three digit dayOfYear (yyyy-DDD'T'HH:mm:ss.SSSZZ).
 static DateTimeFormatter	ordinalDateTimeNoMillis()
 Returns a formatter for a full ordinal date and time without millis, using a four digit year and three digit dayOfYear (yyyy-DDD'T'HH:mm:ssZZ).
 static DateTimeFormatter	time()
 Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit fraction of second, and time zone offset (HH:mm:ss.SSSZZ).
 static DateTimeFormatter	timeElementParser()
 Returns a generic ISO time parser.
 static DateTimeFormatter	timeNoMillis()
 Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and time zone offset (HH:mm:ssZZ).
 static DateTimeFormatter	timeParser()
 Returns a generic ISO time parser for parsing times with a possible zone.
 static DateTimeFormatter	tTime()
 Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, three digit fraction of second, and time zone offset prefixed by 'T' ('T'HH:mm:ss.SSSZZ).
 static DateTimeFormatter	tTimeNoMillis()
 Returns a formatter for a two digit hour of day, two digit minute of hour, two digit second of minute, and time zone offset prefixed by 'T' ('T'HH:mm:ssZZ).
 static DateTimeFormatter	weekDate()
 Returns a formatter for a full date as four digit weekyear, two digit week of weekyear, and one digit day of week (xxxx-'W'ww-e).
 static DateTimeFormatter	weekDateTime()
 Returns a formatter that combines a full weekyear date and time, separated by a 'T' (xxxx-'W'ww-e'T'HH:mm:ss.SSSZZ).
 static DateTimeFormatter	weekDateTimeNoMillis()
 Returns a formatter that combines a full weekyear date and time without millis, separated by a 'T' (xxxx-'W'ww-e'T'HH:mm:ssZZ).
 static DateTimeFormatter	weekyear()
 Returns a formatter for a four digit weekyear.
 static DateTimeFormatter	weekyearWeek()
 Returns a formatter for a four digit weekyear and two digit week of weekyear.
 static DateTimeFormatter	weekyearWeekDay()
 Returns a formatter for a four digit weekyear, two digit week of weekyear, and one digit day of week.
 static DateTimeFormatter	year()
 Returns a formatter for a four digit year.
 static DateTimeFormatter	yearMonth()
 Returns a formatter for a four digit year and two digit month of year.
 static DateTimeFormatter	yearMonthDay()
 Returns a formatter for a four digit year, two digit month of year, and two digit day of month.
 */



#endif


