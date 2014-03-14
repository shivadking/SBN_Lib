//
//  NSString+Helpers.h
//  twilightFW
//
//  Created by Mini Mac i72 on 2/20/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (SBN_Helpers)
/**
 * Returns string representation of the current (self) String formatted with given format.
 *
 * i.e.  will return "14-07-2012" - "dd-MM-yyyy"
 */
- (NSDate *) toDateWithFormat:(NSString *) format;
- (NSInteger)indexOf:(NSString*)substring from:(NSInteger)starts;
- (NSString*)substringFrom:(NSInteger)a to:(NSInteger)b;
- (NSString*)trim ;
- (BOOL)startsWith:(NSString*)s ;
- (BOOL)containsString:(NSString *)aString;
- (NSString*) escape;
- (NSString*) reverseString;
- (BOOL)isNumeric;
-(NSString*) isNull;

#pragma mark - Validations
//--------------------------------------------------------------
- (BOOL)validateNotEmpty;
//--------------------------------------------------------------
- (BOOL)validateMinimumLength:(NSInteger)length;
//--------------------------------------------------------------
- (BOOL)validateMaximumLength:(NSInteger)length;
//--------------------------------------------------------------
- (BOOL)validateMatchesConfirmation:(NSString *)confirmation;
//--------------------------------------------------------------
- (BOOL)validateInCharacterSet:(NSMutableCharacterSet *)characterSet;
//--------------------------------------------------------------
- (BOOL)validateAlpha;
//--------------------------------------------------------------
- (BOOL)validateAlphanumeric;
//--------------------------------------------------------------
- (BOOL)validateNumeric;
//--------------------------------------------------------------
- (BOOL)validateAlphaSpace;
//--------------------------------------------------------------
- (BOOL)validateAlphanumericSpace;
//--------------------------------------------------------------
// Alphanumeric characters, underscore (_), and period (.)
- (BOOL)validateUsername;
//--------------------------------------------------------------
- (BOOL)validateEmail:(BOOL)stricterFilter;
//--------------------------------------------------------------
- (BOOL)validatePhoneNumber;

@end
