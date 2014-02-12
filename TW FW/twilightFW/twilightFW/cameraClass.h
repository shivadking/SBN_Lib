//
//  cameraClass.h
//  photoShoot
//
//  Created by Thiruvengadam Krishnasamy on 08/01/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol TW_CameraDelegate <NSObject>

-(void) getImagefromCameraClass:(UIImage*) img;

@end

@interface cameraClass : NSObject<UIImagePickerControllerDelegate>

@property(weak)id<TW_CameraDelegate>delegate;
@property (assign) id parentClass;
+(cameraClass *)getCommon ;
-(void) pickCamPictures:(int) caseVal;
@end


//How to Use in Other Clasees
/*
 
 #import "cameraClass.h"
 
 @interface ViewController : UIViewController<UIImagePickerControllerDelegate,UIActionSheetDelegate,TW_CameraDelegate>
 
 - (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
 {
 [cameraClass getCommon].parentClass = self;
 [cameraClass getCommon].delegate = self;
 [[cameraClass getCommon] pickCamPictures:buttonIndex];
 }
 
 -(void) getImagefromCameraClass:(UIImage*) img
 {
 [_imgCamera setImage:[self imageWithImage:img scaledToSize:CGSizeMake(65, 65)]];
 }
 
 */