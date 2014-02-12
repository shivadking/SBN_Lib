//
//  SBN_Sharing.m
//  twilightFW
//
//  Created by Mini Mac i72 on 1/17/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "SBN_Sharing.h"

@implementation SBN_Sharing

UIViewController *locParent;

+(SBN_Sharing *)getCommon {
    static SBN_Sharing *__instance = nil;
    if (__instance == nil) {
        __instance = [[SBN_Sharing alloc] init];
    }
    
    return __instance;
}

#pragma mark - Share Text & Images to Default App

- (void) SB_DefaultShareTapToSendTextImage:(NSString *)string andImage:(UIImage *)image :(UIViewController*) parent
{
    NSMutableArray *sharingItems = [NSMutableArray new];
    
    if (string) {
        [sharingItems addObject:string];
    }
    if (image) {
        [sharingItems addObject:image];
    }
    
    UIActivityViewController *activityController = [[UIActivityViewController alloc] initWithActivityItems:sharingItems applicationActivities:nil];
    [parent presentViewController:activityController animated:YES completion:nil];
}

-(void) SB_DefaultShareTapToSendTextImage_Limited:(NSString *)string andImage:(UIImage *)image :(UIViewController*) parent
{
    
    NSLog(@"shareButton pressed");
    
    NSString *texttoshare = string; //this is your text string to share
    UIImage *imagetoshare = image; //this is your image to share
    NSArray *activityItems = @[texttoshare, imagetoshare];
    UIActivityViewController *activityVC = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:nil];
    activityVC.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypePrint];
    [parent presentViewController:activityVC animated:TRUE completion:nil];
}

#pragma mark - SMS Send

- (void) SB_SendSMSwithRecipients:(NSArray*) recipents withMessage:(NSString*) message withParent:(UIViewController*) parent {
    
    locParent = parent;
    
    if(![MFMessageComposeViewController canSendText]) {
        UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:Share_Error_Title_ToOpen message:Share_Error_Message_ToOpen delegate:nil cancelButtonTitle:Share_Error_Button_Ok_ToOpen otherButtonTitles:nil];
        [warningAlert show];
        return;
    }
    
    //NSArray *recipents = @[@"12345678", @"72345524"];
    //NSString *message = [NSString stringWithFormat:@"Just sent the %@ file to your email. Please check!", file];
    
    MFMessageComposeViewController *messageController = [[MFMessageComposeViewController alloc] init];
    messageController.messageComposeDelegate = self;
    [messageController setRecipients:recipents];
    [messageController setBody:message];
    
    // Present message view controller on screen
    [locParent presentViewController:messageController animated:YES completion:nil];
}

- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult) result
{
    switch (result) {
        case MessageComposeResultCancelled:
            break;
            
        case MessageComposeResultFailed:
        {
            UIAlertView *warningAlert = [[UIAlertView alloc] initWithTitle:Share_Error_Title_FailToSend message:Share_Error_Message_FailToSend delegate:nil cancelButtonTitle:Share_Error_Button_Ok_FailToSend otherButtonTitles:nil];
            [warningAlert show];
            break;
        }
            
        case MessageComposeResultSent:
            break;
            
        default:
            break;
    }
    
    [locParent dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Default Phone/ SMS/ Email/ MAP/ Browser
-(void) SB_OpenDefaultPhoneApp_withPhoneNum:(NSString*) Phone_Number
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",Phone_Number]]];
}

-(void) SB_OpenDefaultSMSApp_withPhoneNum:(NSString*) Phone_Number
{

    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"sms://%@",Phone_Number]]];
}

-(void) SB_OpenDefaultEmailApp_withToAddress:(NSString*) toAddress
{
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:[NSString stringWithFormat:@"mailto://%@",toAddress]]];
}

-(void) SB_OpenDefaultEmailApp_withToAddress:(NSString*) toAddress withSubject:(NSString*) subject withBody:(NSString*) bodyText
{
    NSString *recipients = [NSString stringWithFormat:@"mailto:%@?subject=%@",toAddress,subject];
    NSString *body = [NSString stringWithFormat:@"&body=%@",bodyText];
    
    NSString *email = [NSString stringWithFormat:@"%@%@", recipients, body];
    email = [email stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:email]];
}

-(void) SB_OpenDefaultMapApp_withAddress:(NSString*) addressText
{
    //NSString* addressText = @"1 Infinite Loop, Cupertino, CA 95014";
    
    // URL encode the spaces
    
    addressText =  [addressText stringByAddingPercentEscapesUsingEncoding: NSASCIIStringEncoding];
    
    NSString* urlText = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@", addressText];
    
    // lets throw this text on the log so we can view the url in the event we have an issue
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:urlText]];
}

-(void) SB_OpenDefaultBrowerApp_withURL:(NSString*) url
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}




@end
