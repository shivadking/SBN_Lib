/*
 * NSString+DateConversion.m
 *
 * Copyright 2011 Davide De Rosa
 * 
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 * 
 *     http://www.apache.org/licenses/LICENSE-2.0
 * 
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 *
 */

#import "NSString+DateConversion.h"

@implementation NSString (DateConversion)

+ (NSString *)stringWithDate:(NSDate *)date format:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSString *string = [formatter stringFromDate:date];
    [formatter release];

    return string;
}

- (NSDate *)dateValueWithFormat:(NSString *)format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = format;
    NSDate *date = [formatter dateFromString:self];
    [formatter release];
    
    return date;
}

- (NSString *)dateStringFromFormat:(NSString *)inFormat toFormat:(NSString *)outFormat
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = inFormat;
    NSDate *date = [formatter dateFromString:self];
    formatter.dateFormat = outFormat;
    NSString *dateString = [formatter stringFromDate:date];
    [formatter release];
    
    return dateString;
}

@end
