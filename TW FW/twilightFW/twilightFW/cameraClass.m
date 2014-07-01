//
//  cameraClass.m
//  photoShoot
//
//  Created by Thiruvengadam Krishnasamy on 08/01/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "cameraClass.h"

@implementation cameraClass
+(cameraClass *)getCommon {
    static cameraClass *__instance = nil;
    if (__instance == nil) {
        __instance = [[cameraClass alloc] init];
    }
    
    return __instance;
}

-(void) pickCamPictures:(int) caseVal
{
    UIImagePickerController *imagePicker = [UIImagePickerController new];
    imagePicker.delegate = _parentClass;
    //int caseVal = 0;
    switch (caseVal) {
        case 0:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera] )
            {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
                [_parentClass presentViewController:imagePicker animated:YES completion:nil];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Camera is not available" message:@"Your from stimulator" delegate:_parentClass cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
            break;
        case 1:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary])
            {
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                [_parentClass presentViewController:imagePicker animated:YES completion:nil];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Gallery is not available" message:@"Your from stimulator" delegate:_parentClass cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
            break;
        case 2:
        {
            if([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeSavedPhotosAlbum])
            {
                imagePicker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
                [_parentClass presentViewController:imagePicker animated:YES completion:nil];
            }else
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Album is not available" message:@"Your from stimulator" delegate:_parentClass cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
            }
        }
            break;
        case 3:
        {
            
        }
            break;
        case 4:
        {
            
        }
            break;
        default:
            break;
    }
    
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [_parentClass dismissViewControllerAnimated:YES completion:^{
        [self.delegate getImagefromCameraClass:info[UIImagePickerControllerOriginalImage]];
    }];
}
     

@end
