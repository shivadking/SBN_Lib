//
//  SBN_Sharing.h
//  twilightFW
//
//  Created by Mini Mac i72 on 1/17/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MessageUI/MessageUI.h>

#define Share_Error_Title_ToOpen @"Error"
#define Share_Error_Message_ToOpen @"Your device doesn't support SMS!"
#define Share_Error_Button_Ok_ToOpen @"Ok"

#define Share_Error_Title_FailToSend @"Error"
#define Share_Error_Message_FailToSend @"Failed to send SMS!"
#define Share_Error_Button_Ok_FailToSend @"Ok"

@interface SBN_Sharing : NSObject<MFMessageComposeViewControllerDelegate>
+(SBN_Sharing *)getCommon;
- (void) SB_DefaultShareTapToSendTextImage:(NSString *)string andImage:(UIImage *)image :(UIViewController*) parent;
-(void) SB_DefaultShareTapToSendTextImage_Limited:(NSString *)string andImage:(UIImage *)image :(UIViewController*) parent;
- (void) SB_SendSMSwithRecipients:(NSArray*) recipents withMessage:(NSString*) message withParent:(UIViewController*) parent;

-(void) SB_OpenDefaultPhoneApp_withPhoneNum:(NSString*) Phone_Number;
-(void) SB_OpenDefaultSMSApp_withPhoneNum:(NSString*) Phone_Number;
-(void) SB_OpenDefaultEmailApp_withToAddress:(NSString*) toAddress;
-(void) SB_OpenDefaultEmailApp_withToAddress:(NSString*) toAddress withSubject:(NSString*) subject withBody:(NSString*) bodyText;
-(void) SB_OpenDefaultMapApp_withAddress:(NSString*) addressText;
-(void) SB_OpenDefaultBrowerApp_withURL:(NSString*) url;
@end
