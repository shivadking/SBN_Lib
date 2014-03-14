//
//  NSString+Helpers.m
//  twilightFW
//
//  Created by Mini Mac i72 on 2/20/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "NSString+SBN_Helpers.h"

@implementation NSString (SBN_Helpers)


#pragma mark - General
- (NSDate *) toDateWithFormat:(NSString *) format
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:format];
    
	return [formatter dateFromString:self];
}


- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts {
	NSRange r;
	r.location = starts;
	r.length = [self length] - r.location;
    
	NSRange index = [self rangeOfString:substring options:NSLiteralSearch range:r];
	if (index.location == NSNotFound) {
		return -1;
	}
	return index.location + index.length;
}

- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b {
	NSRange r;
	r.location = a;
	r.length = b - a;
	return [self substringWithRange:r];
}

- (NSString*)trim {
	return [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
}

- (BOOL)startsWith:(NSString*)s {
	if([self length] < [s length]) return NO;
	return [s isEqualToString:[self substringFrom:0 to:[s length]]];
}

- (BOOL)containsString:(NSString *)aString
{
	NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]];
	return range.location != NSNotFound;
}

- (NSString*) escape{
    return [self stringByAddingPercentEscapesUsingEncoding:NSASCIIStringEncoding];
}

- (NSString*) reverseString
{
	NSMutableString *reversedStr;
	int len = [self length];
    
	// auto released string
	reversedStr = [NSMutableString stringWithCapacity:len];
    
	// quick-and-dirty implementation
	while ( len > 0 )
		[reversedStr appendString:[NSString stringWithFormat:@"%C",[self characterAtIndex:--len]]];
    
	return reversedStr;
}

- (BOOL)isNumeric
{
    static NSCharacterSet *csetNonDigits = nil;
    if (!csetNonDigits) {
        csetNonDigits = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    }
    
    return ([self rangeOfCharacterFromSet:csetNonDigits].location == NSNotFound);
}

-(NSString*) isNull
{
    if (self == (id)[NSNull null] || self.length == 0 )
    {
        return @"";
    }
    return self;
}

#pragma mark - Validations
//--------------------------------------------------------------
- (BOOL)validateNotEmpty
{
    return ([self length] != 0);
}

//--------------------------------------------------------------
- (BOOL)validateMinimumLength:(NSInteger)length
{
    return ([self length] >= length);
}

//--------------------------------------------------------------
- (BOOL)validateMaximumLength:(NSInteger)length
{
    return ([self length] <= length);
}

//--------------------------------------------------------------
- (BOOL)validateMatchesConfirmation:(NSString *)confirmation
{
    return [self isEqualToString:confirmation];
}

//--------------------------------------------------------------
- (BOOL)validateInCharacterSet:(NSMutableCharacterSet *)characterSet
{
    return ([self rangeOfCharacterFromSet:[characterSet invertedSet]].location == NSNotFound);
}

//--------------------------------------------------------------
- (BOOL)validateAlpha
{
    return [self validateInCharacterSet:[NSCharacterSet letterCharacterSet]];
}

//--------------------------------------------------------------
- (BOOL)validateAlphanumeric
{
    return [self validateInCharacterSet:[NSCharacterSet alphanumericCharacterSet]];
}

//--------------------------------------------------------------
- (BOOL)validateNumeric
{
    return [self validateInCharacterSet:[NSCharacterSet decimalDigitCharacterSet]];
}

//--------------------------------------------------------------
- (BOOL)validateAlphaSpace
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet letterCharacterSet];
    [characterSet addCharactersInString:@" "];
    return [self validateInCharacterSet:characterSet];
}

//--------------------------------------------------------------
- (BOOL)validateAlphanumericSpace
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@" "];
    return [self validateInCharacterSet:characterSet];
}

//--------------------------------------------------------------
// Alphanumeric characters, underscore (_), and period (.)
- (BOOL)validateUsername
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet alphanumericCharacterSet];
    [characterSet addCharactersInString:@"'_."];
    return [self validateInCharacterSet:characterSet];
}

//--------------------------------------------------------------
- (BOOL)validateEmail:(BOOL)stricterFilter
{
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

//--------------------------------------------------------------
- (BOOL)validatePhoneNumber
{
    NSMutableCharacterSet *characterSet = [NSMutableCharacterSet decimalDigitCharacterSet];
    [characterSet addCharactersInString:@"'-*+#,;. "];
    return [self validateInCharacterSet:characterSet];
}


@end
