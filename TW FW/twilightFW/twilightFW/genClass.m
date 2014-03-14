//
//  genClass.m
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 24/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "genClass.h"
#import "defs.h"
#import "NSData+SBN_Base64.h"
#import <SystemConfiguration/SystemConfiguration.h>
#include <netdb.h>

@implementation genClass

NSCharacterSet *nonNumberSet;

+(genClass *)getCommon {
    static genClass *__instance = nil;
    if (__instance == nil) {
        __instance = [[genClass alloc] init];
        nonNumberSet = [[NSCharacterSet decimalDigitCharacterSet] invertedSet];
    }
    
    return __instance;
}

- (BOOL) isNetworkAvailable
{
    // Create zero addy
    struct sockaddr_in zeroAddress;
    bzero(&zeroAddress, sizeof(zeroAddress));
    zeroAddress.sin_len = sizeof(zeroAddress);
    zeroAddress.sin_family = AF_INET;
    
    // Recover reachability flags
    SCNetworkReachabilityRef defaultRouteReachability = SCNetworkReachabilityCreateWithAddress(NULL, (struct sockaddr *)&zeroAddress);
    SCNetworkReachabilityFlags flags;
    
    BOOL didRetrieveFlags = SCNetworkReachabilityGetFlags(defaultRouteReachability, &flags);
    CFRelease(defaultRouteReachability);
    
    if (!didRetrieveFlags)
    {
        printf("Error. Could not recover network reachability flags\n");
        return NO;
    }
    
    BOOL isReachable = ((flags & kSCNetworkFlagsReachable) != 0);
    BOOL needsConnection = ((flags & kSCNetworkFlagsConnectionRequired) != 0);
    
    BOOL isAvailNet = (isReachable && !needsConnection) ? YES : NO;
    
    if(!isAvailNet)
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"App Title Here" message:@"Internal error" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }
    return isAvailNet;
}

- (NSMutableDictionary *)appNameAndVersionNumberDisplayString {
    NSDictionary *infoDictionary = [[NSBundle mainBundle] infoDictionary];
    NSString *appDisplayName = [infoDictionary objectForKey:@"CFBundleDisplayName"];
    NSString *majorVersion = [infoDictionary objectForKey:@"CFBundleShortVersionString"];
    NSString *minorVersion = [infoDictionary objectForKey:@"CFBundleVersion"];
    
    NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
    [dic setObject:appDisplayName forKey:@"appName"];
    [dic setObject:majorVersion forKey:@"appVersion"];
    [dic setObject:minorVersion forKey:@"appBuild"];
    
    return dic;
}

#pragma mark - TextFields
+(void)setTextFieldIndentation:(id) textFields indentSize:(int) size type:(int) type
{
    UIView *spacerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, size, size)];
    switch (type) {
        case 0:
        {
            [textFields setLeftViewMode:UITextFieldViewModeAlways];
            [textFields setLeftView:spacerView];	// Do any additional setup after loading the view.
        }
            break;
        case 1:
        {
            [textFields setRightViewMode:UITextFieldViewModeAlways];
            [textFields setRightView:spacerView];	// Do any additional setup after loading the view.
        }
            break;
        case 2:
        {
            [textFields setLeftViewMode:UITextFieldViewModeAlways];
            [textFields setLeftView:spacerView];	// Do any additional setup after loading the view.
            [textFields setRightViewMode:UITextFieldViewModeAlways];
            [textFields setRightView:spacerView];	// Do any additional setup after loading the view.
        }
            break;
        default:
            break;
    }
    
}


#pragma mark - Plists
+(NSString*) getPlistPathfromfileManager:(NSString*) fileName fileType:(NSString*) filetype
{
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.%@",fileName,filetype]];
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    if (![fileManager fileExistsAtPath: path])
    {
        NSString *bundle = [[NSBundle mainBundle] pathForResource:fileName ofType:filetype];
        
        [fileManager copyItemAtPath:bundle toPath: path error:&error];
    }
    
    return path;
}


#pragma mark - Keyboard & Toolbars
+(UIToolbar *)getKeyboardToolbar:(id)sender type:(int) type
{
    NSString *next = @"Next";
    NSString *previous = @"Previous";
    NSString *done = @"Done";
    NSString *cancel = @"Cancel";
    NSString *clear = @"Clear";
    UIToolbar* toolbarType;
    switch (type) {
        case 0:
        {
            toolbarType = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            toolbarType.barStyle = UIBarStyleBlackTranslucent;
            toolbarType.items = [NSArray arrayWithObjects:
                                  [[UIBarButtonItem alloc]initWithTitle:previous style:UIBarButtonItemStyleBordered target:sender action:@selector(previous)],
                                  [[UIBarButtonItem alloc]initWithTitle:next style:UIBarButtonItemStyleDone target:sender action:@selector(next)],
                                  [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                  [[UIBarButtonItem alloc]initWithTitle:done style:UIBarButtonItemStyleDone target:sender action:@selector(done)],
                                  nil];
            [toolbarType sizeToFit];
            
        }
            break;
        case 1:
        {
            toolbarType = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            toolbarType.barStyle = UIBarStyleBlackTranslucent;
            toolbarType.items = [NSArray arrayWithObjects:
                                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                 [[UIBarButtonItem alloc]initWithTitle:done style:UIBarButtonItemStyleDone target:sender action:@selector(done)],
                                 nil];
            [toolbarType sizeToFit];
        }
            break;
        case 2:
        {
            toolbarType = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            toolbarType.barStyle = UIBarStyleBlackTranslucent;
            toolbarType.items = [NSArray arrayWithObjects:
                                 [[UIBarButtonItem alloc]initWithTitle:cancel style:UIBarButtonItemStyleBordered target:sender action:@selector(cancel)],
                                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                 [[UIBarButtonItem alloc]initWithTitle:done style:UIBarButtonItemStyleDone target:sender action:@selector(done)],
                                 nil];
            [toolbarType sizeToFit];
        }
            break;
        case 3:
        {
            toolbarType = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            toolbarType.barStyle = UIBarStyleBlackTranslucent;
            toolbarType.items = [NSArray arrayWithObjects:
                                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                 [[UIBarButtonItem alloc]initWithTitle:clear style:UIBarButtonItemStyleDone target:sender action:@selector(clear)],
                                 nil];
            [toolbarType sizeToFit];
        }
            break;
        case 4:
        {
            toolbarType = [[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, 320, 50)];
            toolbarType.barStyle = UIBarStyleBlackTranslucent;
            toolbarType.items = [NSArray arrayWithObjects:
                                 [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil],
                                 [[UIBarButtonItem alloc]initWithTitle:next style:UIBarButtonItemStyleDone target:sender action:@selector(next)],
                                 nil];
            [toolbarType sizeToFit];
        }
            break;
            
        default:
            toolbarType = nil;
            break;
    }
    
    return toolbarType;
    
    
}

#pragma mark - Temps
+(void)makeTost:(id)sender withMessage:(NSString *)message{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 160, 30)];
    UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(60,5, 200, 20)];
    lbl.backgroundColor = [UIColor clearColor];
    lbl.text = message;
    [lbl setTextColor:[UIColor whiteColor]];
    [view setBackgroundColor:[UIColor blackColor]];
    [view addSubview:lbl];
    [sender addSubview:view];
    [view setHidden:YES];
    [view setAlpha:1.0];
    CGPoint location;
    location.x = 160;
    location.y = 120;
    view.center = location;
    location.x = 160;
    location.y = 320;
    //[sender bringSubviewToFront:view];
    [view setHidden:NO];
    [UIView animateWithDuration:2.0 animations:^{
        view.alpha = 0.0;
        view.center = location;
    }];
}

+(NSString*) formatPhoneNumber:(NSString*) simpleNumber deleteLastChar:(BOOL)deleteLastChar {
    if(simpleNumber.length==0) return @"";
    // use regex to remove non-digits(including spaces) so we are left with just the numbers
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
    simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
    
    // check if the number is to long
    if(simpleNumber.length>10) {
        // remove last extra chars.
        simpleNumber = [simpleNumber substringToIndex:10];
    }
    
    if(deleteLastChar) {
        // should we delete the last digit?
        simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
    }
    
    // 123 456 7890
    // format the number.. if it's less then 7 digits.. then use this regex.
    if(simpleNumber.length<7)
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d+)"
                                                               withString:@"($1) $2"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    
    else   // else do this one..
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d+)"
                                                               withString:@"($1) $2-$3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    return simpleNumber;
}

+(void) print
{
    NSLog(@"HI");
}


#pragma mark - Validations
+(BOOL)isEmail:(NSString*)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}

+(int) isPassword:(NSString*) txt rangeFrom:(int) x rangeTo:(int) y containNumbers:(BOOL) num containsLetters:(BOOL) letters
{
    if(txt.length<x || txt.length>y)
    {
        return 1;
    }else if (!(([txt rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound) && ([txt stringByTrimmingCharactersInSet:nonNumberSet].length > 0)))
    {
        return 2;
    }
    return 0;
}

+(BOOL) isComparePassword:(NSString*) pass1 passStr:(NSString*) pass2
{
    if(![pass1 isEqualToString:pass2])
    {
        return NO;
    }
    return YES;
}

+(BOOL) isRangeText:(NSString*) txt rangeFrom:(int) x rangeTo:(int) y
{
    if(txt.length<x || txt.length>y)
    {
        return NO;
    }
    return YES;
}

+(BOOL) isRangeNumber:(int) num rangeFrom:(int) x rangeTo:(int) y
{
    if((num <= x) || (num > y))
    {
        return NO;
    }
    return YES;
}

+(BOOL) isMaxLength:(int) num range:(int) x
{
    if(num < x)
    {
        return NO;
    }
    return YES;
}

+(BOOL) isContainsString:(NSString*) str
{
    if(![str rangeOfCharacterFromSet:[NSCharacterSet letterCharacterSet]].location != NSNotFound)
    {
        return NO;
    }
    
    return YES;
}

+(BOOL) isContainsNumber:(NSString*) num
{
    if(![num stringByTrimmingCharactersInSet:nonNumberSet].length > 0)
    {
        return NO;
    }
    
    return YES;
}

+(BOOL) isEmpty:(id) txt
{
    if([txt isEqualToString:@""])
    {
        return YES;
    }
    return NO;
}

+(BOOL) isUrl: (NSString *) candidate {
    NSString *urlRegEx =
    @"(http|https)://((\\w)*|([0-9]*)|([-|_])*)+([\\.|/]((\\w)*|([0-9]*)|([-|_])*))+";
    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}

#pragma mark - UTILITES
+(int)GetIntFromString:(NSString *)string
{
    //NSLog(@"CLASS==> %@",[string class]);
    if([string isKindOfClass:[NSString class]])
    {
        if (validStr(string)) {
            return [string integerValue];
        }
    }
    else if([string isKindOfClass:[NSNumber class]])
    {
        NSNumber *number =(NSNumber *)string;
        return [number intValue];
    }
    
    return 0;
}
+(NSString *)GetStringFromString:(NSString *)string
{
    if([string isKindOfClass:[NSString class]])
    {
        if (validStr(string)) {
            return string;
        }
    }
    
    return @"";
}
+(float)GetFloatFromString:(NSString *)string
{
    if([string isKindOfClass:[NSString class]])
    {
        if (validStr(string)) {
            return [string floatValue];
        }
    }
    else if([string isKindOfClass:[NSNumber class]])
    {
        NSNumber *number =(NSNumber *)string;
        return [number floatValue];
    }
    return 0;
}

#pragma mark - Conversions
- (NSString *)formatString:(NSString *)string {  // 9,999,999
    // Strip out the commas that may already be here:
    NSString *newString = [string stringByReplacingOccurrencesOfString:@"," withString:@""];
    if ([newString length] == 0) {
        return nil;
    }
    
    // Check for illegal characters
    NSCharacterSet *disallowedCharacters = [[NSCharacterSet characterSetWithCharactersInString:@"0123456789."] invertedSet];
    NSRange charRange = [newString rangeOfCharacterFromSet:disallowedCharacters];
    if ( charRange.location != NSNotFound) {
        return nil;
    }
    
    // Split the string into the integer and decimal portions
    NSArray *numberArray = [newString componentsSeparatedByString:@"."];
    if ([numberArray count] > 2) {
        // There is more than one decimal point
        return nil;
    }
    
    // Get the integer
    NSString *integer           = [numberArray objectAtIndex:0];
    NSUInteger integerDigits    = [integer length];
    if (integerDigits == 0) {
        return nil;
    }
    
    // Format the integer.
    // You can do this by first converting to a number and then back to a string,
    // but I would rather keep it as a string instead of doing the double conversion.
    // If performance is critical, I would convert this to a C string to do the formatting.
    NSMutableString *formattedString = [[NSMutableString alloc] init];
    if (integerDigits < 4) {
        [formattedString appendString:integer];
    } else {
        // integer is 4 or more digits
        NSUInteger startingDigits = integerDigits % 3;
        if (startingDigits == 0) {
            startingDigits = 3;
        }
        [formattedString setString:[integer substringToIndex:startingDigits]];
        for (NSUInteger index = startingDigits; index < integerDigits; index = index + 3) {
            [formattedString appendFormat:@",%@", [integer substringWithRange:NSMakeRange(index, 3)]];
        }
    }
    
    // Add the decimal portion if there
    if ([numberArray count] == 2) {
        [formattedString appendString:@"."];
        NSString *decimal = [numberArray objectAtIndex:1];
        if ([decimal length] > 0) {
            [formattedString appendString:decimal];
        }
    }
    
    return formattedString;
}
-(NSString*) formatPhoneNumber:(NSString*) simpleNumber deleteLastChar:(BOOL)deleteLastChar {  // (123) 456-7891
    if(simpleNumber.length==0) return @"";
    // use regex to remove non-digits(including spaces) so we are left with just the numbers
    NSError *error = NULL;
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"[\\s-\\(\\)]" options:NSRegularExpressionCaseInsensitive error:&error];
    simpleNumber = [regex stringByReplacingMatchesInString:simpleNumber options:0 range:NSMakeRange(0, [simpleNumber length]) withTemplate:@""];
    
    // check if the number is to long
    if(simpleNumber.length>10) {
        // remove last extra chars.
        simpleNumber = [simpleNumber substringToIndex:10];
    }
    
    if(deleteLastChar) {
        // should we delete the last digit?
        simpleNumber = [simpleNumber substringToIndex:[simpleNumber length] - 1];
    }
    
    // 123 456 7890
    // format the number.. if it's less then 7 digits.. then use this regex.
    if(simpleNumber.length<7)
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d+)"
                                                               withString:@"($1) $2"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    
    else   // else do this one..
        simpleNumber = [simpleNumber stringByReplacingOccurrencesOfString:@"(\\d{3})(\\d{3})(\\d+)"
                                                               withString:@"($1) $2-$3"
                                                                  options:NSRegularExpressionSearch
                                                                    range:NSMakeRange(0, [simpleNumber length])];
    return simpleNumber;
}

-(NSString*)convertDictionaryJsonString:(NSDictionary*) dic
{
    //NSDictionary *myDictionary = [NSDictionary dictionaryWithObject:@"hai" forKey:@"keys"];
    NSError *error;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:0 error:nil];
    if (!jsonData) {
        //NSLog(@&quot;JSON error: %@&quot;, error);
    } else {
        NSString *JSONString = [[NSString alloc] initWithBytes:[jsonData bytes] length:[jsonData length] encoding:NSUTF8StringEncoding];
        NSLog(@"JSON OUTPUT: %@",JSONString);
        return JSONString;
    }
    return NULL;
}

+(UIImage *)resizeImage:(UIImage *)imageToCompress scaledToSize:(CGSize)newSize {
    
    UIGraphicsBeginImageContextWithOptions(newSize, NO, 0.0);
    [imageToCompress drawInRect:CGRectMake(0, 0, newSize.width, newSize.height)];
    UIImage *newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    const CGFloat margin = 2.0f;
    CGSize size = CGSizeMake([newImage size].width + 2*margin, [newImage size].height + 2*margin);
    UIGraphicsBeginImageContext(size);
    
    [[UIColor whiteColor] setFill];
    [[UIBezierPath bezierPathWithRect:CGRectMake(0, 0, size.width, size.height)] fill];
    
    CGRect rect = CGRectMake(margin, margin, size.width-2*margin, size.height-2*margin);
    [newImage drawInRect:rect blendMode:kCGBlendModeNormal alpha:1.0];
    
    UIImage *testImg =  UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return testImg;
}

#pragma mark - Map Common
-(NSString*)getAddressFromLatLong : (NSString *)latLng {
    //latLng = here send Latitude & longitude with comma separate like as @"26.00,75.00"
    NSString *esc_addr =  [latLng stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    if (dataArray.count == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Not an valid address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
    }else{
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"formatted_address"];
            return jsonStr1;
        }
    }
    return nil;
    
}

+(NSMutableArray*)getLatLongfromAddress : (NSString *)addressText {
    
    //addressText = here send Address  like as @"Jaipur Rajasthan"
    
    NSString *stringAdress = [addressText stringByReplacingOccurrencesOfString:@" " withString:@"+"];
    
    NSString *esc_addr =  [stringAdress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSString *req = [NSString stringWithFormat:@"http://maps.google.com/maps/api/geocode/json?sensor=false&address=%@", esc_addr];
    
    NSString *result = [NSString stringWithContentsOfURL:[NSURL URLWithString:req] encoding:NSUTF8StringEncoding error:NULL];
    
    NSMutableDictionary *data = [NSJSONSerialization JSONObjectWithData:[result dataUsingEncoding:NSUTF8StringEncoding]options:NSJSONReadingMutableContainers error:nil];
    
    NSMutableArray *dataArray = (NSMutableArray *)[data valueForKey:@"results" ];
    
    if (dataArray.count == 0) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"Error" message:@"Please Enter a valid address" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil, nil];
        [alert show];
        
    }else{
        
        for (id firstTime in dataArray) {
            NSString *jsonStr1 = [firstTime valueForKey:@"geometry"];
            NSMutableArray *Location = [jsonStr1 valueForKey:@"location"];
            NSString *latitude = [Location  valueForKey:@"lat"];
            NSLog(@"Data Return %@",latitude);
            return Location;
            
        }
    }
    return nil;
  
}

-(void) printPDF_fileFromLocalBundle:(NSString*) pdfStreem
{
    NSData *streamData = [NSData dataFromBase64String:pdfStreem];
    
    NSArray *docDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *docDirectory = [docDirectories objectAtIndex:0];
    NSString *fileName = [docDirectory stringByAppendingPathComponent:@"Reports.PDF"];
    [streamData writeToFile:fileName atomically:NO];
    
    NSString *resourceDocPath = [[NSString alloc] initWithString:[[[[NSBundle mainBundle] resourcePath] stringByDeletingLastPathComponent] stringByAppendingPathComponent:@"Documents"]];
    NSString *path = [resourceDocPath stringByAppendingPathComponent:@"Reports.PDF"];
    NSData *myData = [NSData dataWithContentsOfFile: path];
    NSLog(@"Path => %@",path);
    //sdfsadfsdaf
    
	UIPrintInteractionController *pic = [UIPrintInteractionController sharedPrintController];
	if(pic && [UIPrintInteractionController canPrintData: myData] ) {
		
		pic.delegate = self;
		
		UIPrintInfo *printInfo = [UIPrintInfo printInfo];
		printInfo.outputType = UIPrintInfoOutputGeneral;
		printInfo.jobName = [path lastPathComponent];
		printInfo.duplex = UIPrintInfoDuplexLongEdge;
		pic.printInfo = printInfo;
		pic.showsPageRange = YES;
		pic.printingItem = myData;
		
		void (^completionHandler)(UIPrintInteractionController *, BOOL, NSError *) = ^(UIPrintInteractionController *pic, BOOL completed, NSError *error) {
			//self.content = nil;
			if (!completed && error) {
				NSLog(@"FAILED! due to error in domain %@ with error code %u", error.domain, error.code);
			}
		};
		
		[pic presentAnimated:YES completionHandler:completionHandler];
		
	}else
    {
        //[[kCommon getCommon] toastWithMessage:@"No printer available"];
        NSLog(@"No printer available");
        
    }
}



@end
