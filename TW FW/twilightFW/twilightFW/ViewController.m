//
//  ViewController.m
//  twilightFW
//
//  Created by Thiruvengadam Krishnasamy on 24/12/13.
//  Copyright (c) 2013 TWILIGHT SOFTWARES. All rights reserved.
//

#import "ViewController.h"
#import "defnitions.h"
#import "webService.h"
#import "SBN_RSSReader.h"
#import "DejalActivityView.h"
#import "dateTimeClass.h"
#import "SBN_Sharing.h"

@interface ViewController ()

@end

@implementation ViewController
{
    genClass *common;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    [self appDetails];
    
    [self dateProcess];
    
}

-(void) ShowLoader
{
    [DejalBezelActivityView activityViewForView:self.view];
}

-(void) HideLoader
{
    [DejalBezelActivityView removeViewAnimated:YES];
}

-(void) appDetails
{
     NSLog(@"All Details => %@",[[genClass getCommon] appNameAndVersionNumberDisplayString]);
}

#pragma mark - NSUserDefaultLibCustomizations
-(void) customized_NSUserDefaults
{
    //Allocate and resusage of NSUserDefault
    allocUserDefault;
    setUserDefault(@"hai", @"k");
    NSLog(@"String => %@",getUserDefault(@"k"));
}

#pragma mark - RSS FEED Loading Data
-(void)LoadData
{
    NSString * path = @"https://news.google.com/news/feeds?pz=1&cf=all&ned=us&hl=en&q=mortgage+rates&output=rss";
    SBN_RSSReader *sbRSS = [[SBN_RSSReader alloc] init];
    sbRSS.delegate = self;
    sbRSS.paresntClass = self;
    NSString *mainTagName = @"item";
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"title",@"link",@"description",@"pubDate", nil];
    [sbRSS SB_RSSReader_Call:path withMainTag:mainTagName withTagKeys:keys withIdentifier:@"RSSData"];
}

#pragma mark - WebService Customization
-(void) getMethods
{
    //Params Values & Params Keys
    WS_ALLOCPARAMSNEW
    WS_inputValuesAndKeys(@"51",@"LocationId");
    WS_inputValuesAndKeys(@"5",@"UserId");
    
    [[webService getCommon] webService_GetDictionary_Response:@"http://103.8.116.50:91/api/CollectionApi" withParamsValuesAndKeys:WS_parametersArr withUrlType:@"GetLocationMachineDetails?" isPostMethod:NO :^(NSMutableDictionary *resDic) {
        NSLog(@"res ==> %@",resDic);
        [self HideLoader];
        
    }];
}
-(void) postMethods
{
    //Params Values & Params Keys
    WS_ALLOCPARAMSNEW
    WS_ALLOCARRAY
    WS_inputValuesAndKeys(@"pandeyan",@"UserName");
    WS_inputValuesAndKeys(@"12345",@"password");
    
    [[webService getCommon] webService_GetDictionary_Response:@"http://103.8.116.50:91/api/LoginApi" withParamsValuesAndKeys:WS_parametersArr withUrlType:@"Login" isPostMethod:YES :^(NSMutableDictionary *resDic) {
        NSLog(@"res ==> %@",resDic);
        [self HideLoader];
    }];
}

-(void) soapMethods
{
    //SOAP
    NSString *urlString = @"http://103.8.116.50:94/TaxiMail.asmx/AirportPickUp";  //@"http://[URL]/[web_service_name.asmx]/[web_method]";
    
    //Params Values & Params Keys
    WS_ALLOCPARAMSNEW
    WS_ALLOCARRAY
    WS_inputValuesAndKeys(@"input1_value",@"airport");
    WS_inputValuesAndKeys(@"input2_value",@"flight");
    WS_inputValuesAndKeys(@"input3_value",@"date");
    WS_inputValuesAndKeys(@"input4_value",@"time");
    WS_inputValuesAndKeys(@"input5_value",@"phoneNumber");
    WS_inputValuesAndKeys(@"input6_value",@"destinationAddress");
    WS_inputValuesAndKeys(@"input7_value",@"noteForDriver");
    
    webService *web = [[webService alloc] init];
    web.delegate = self;
    web.paresntClass = self;
    [web webService_SOAP_Response:urlString withParamsValuesAndKeys:WS_parametersArr withMethodType:@"POST"];//@"POST"
    
    NSLog(@"con End => Endended");
}

#pragma mark - Delegate for SOAP Connection
-(void) getResponseData:(NSMutableData *)responseData  
{
    NSLog(@"resrPdaa => %@",responseData);
    
    NSString *mainTagName = @"Result";
    NSMutableArray *keys = [[NSMutableArray alloc] initWithObjects:@"Status",@"Message", nil];
    
    SBN_RSSReader *sbnRSS = [[SBN_RSSReader alloc] init];
    sbnRSS.delegate = self;
    sbnRSS.paresntClass = self;
    [sbnRSS SB_RSSReader_Call_NSMutableData:responseData withMainTag:mainTagName withTagKeys:keys withIdentifier:@"SOAPData"];

    //NSLog(@"fromParser curEl => %@",currentElement);
}

#pragma mark - Delegate for SBN_XMLContent
-(void) getXMLContentData:(NSMutableArray *)arrWithXMLContent :(NSString *)identifierName
{
    [self HideLoader];
    NSLog(@"Idententifier => %@ DataFromXML ==> %@",identifierName,arrWithXMLContent);
}

#pragma mark - Others

-(void) ShowDefaultAlert:(NSString *) Message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:APP_TITLE message:Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    
    
}

- (IBAction)btnGet:(id)sender {
    [self ShowLoader];
    [self performSelectorInBackground:@selector(getMethods) withObject:nil];
}

- (IBAction)btnPost:(id)sender {
    [self ShowLoader];
    [self performSelectorInBackground:@selector(postMethods) withObject:nil];
}

- (IBAction)btnSOAP:(id)sender {
    [self ShowLoader];
    [self performSelectorOnMainThread:@selector(soapMethods) withObject:nil waitUntilDone:YES];
}

- (IBAction)btnXMLRead:(id)sender {
    [self ShowLoader];
    [self performSelectorInBackground:@selector(LoadData) withObject:nil];
    //[self performSelectorInBackground:@selector(LoadData) withObject:nil];
}

- (IBAction)btnShowShare:(id)sender {
    //It List All Sharing
    [[SBN_Sharing getCommon] SB_DefaultShareTapToSendTextImage:@"Text Here" andImage:[UIImage imageNamed:@"Default.png"] :self];
    
    //It List Excluded Items from Default Sharing
    //[[SBN_Sharing getCommon] SB_DefaultShareTapToSendTextImage_Limited:@"Text Here" andImage:[UIImage imageNamed:@"Default.png"] :self];
}

- (IBAction)btnSendSMS:(id)sender {
    
    NSArray *recipents = @[@"12345678", @"72345524"];
    NSString *message = [NSString stringWithFormat:@"Just sent the file to your email. Please check!"];
    [[SBN_Sharing getCommon] SB_SendSMSwithRecipients:recipents withMessage:message withParent:self];
    
    
}

- (IBAction)btnSendEmail:(id)sender {
    [[SBN_Sharing getCommon] SB_OpenDefaultEmailApp_withToAddress:@"sivablan@twilightsoftwares.com" withSubject:@"Subject" withBody:@"Hi Shiva"];
}

#pragma mark - DateTime Process
-(void) dateProcess
{
    NSDate *date = [NSDate new];
    NSLog(@"Date => %@\n\n\n",[date toStringWithFormat:@"dd/MM/YYYY"]);
    NSLog(@"dateWithoutTime => %@\n\n\n",[date dateWithoutTime]);
    NSLog(@"dateByAddingMonths => %@\n\n\n",[date dateByAddingMonths:1]);
    NSLog(@"dateByAddingDays => %@\n\n\n",[date dateByAddingDays:1]);
    NSLog(@"dateByAddingYears => %@\n\n\n",[date dateByAddingYears:1]);
    NSLog(@"dateBySubMonths => %@\n\n\n",[date dateByAddingMonths:-1]);
    NSLog(@"dateBySubDays => %@\n\n\n",[date dateByAddingDays:-1]);
    NSLog(@"dateBySubYears => %@\n\n\n",[date dateByAddingYears:-1]);
    NSLog(@"monthStartDate => %@\n\n\n",[date monthStartDate]);
    NSLog(@"midnightDate => %@\n\n\n",[date midnightDate]);
    NSLog(@"numberOfDaysInMonth => %d\n\n\n",[date numberOfDaysInMonth]);
    NSLog(@"weekday => %d\n\n\n",[date weekday]);
    NSLog(@"daysSinceDate => %d\n\n\n",[date daysSinceDate:[date dateByAddingDays:-1]]);
    
    
    NSDate *dates = [@"Fri, 28 Feb 2014 18:00:00 GMT" toDateWithFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
    NSLog(@"dates => %@\n\n\n",dates);
    
    // Usage (#import "NSString+Date.h")
    NSString* string =  [[NSDate date] toStringWithFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
     NSLog(@"curDate String => %@\n\n\n",string);
    
    NSDate* date2 = [string toDateWithFormat:@"EEE, dd MMM yyyy HH:mm:ss ZZZ"];
     NSLog(@"curDate from str => %@\n\n\n",date2);
    
    NSLog(@"curMonth=%d, curDay=%d, curYear=%d, curWeek=%d\n\n\n",[dates MonthInNumber],[[NSDate date] DayInNumber],[[NSDate date] YearInNumber],[[NSDate date] WeekInNumber]);
    
    NSLog(@"monthString=%@, dayString=%@, monthString=%@, dayString=%@\n\n\n",[dates MonthInString_Long],[dates DayInString_Long],[dates MonthInString_Short],[dates DayInString_Short]);

}


@end
