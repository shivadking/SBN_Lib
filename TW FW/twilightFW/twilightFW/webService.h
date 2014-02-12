//
//  webService.h
//  twilightFW
//
//  Created by Mini Mac i72 on 1/10/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import <Foundation/Foundation.h>
//WS_ALLOCPARAMSNEW
#define WS_ALLOCPARAMSNEW NSMutableArray *addarrValues = [[NSMutableArray alloc] init]; NSMutableDictionary *dics;
#define WS_ALLOCARRAY addarrValues = [[NSMutableArray alloc] init];
#define WS_allocDic dics = [[NSMutableDictionary alloc] init];
#define WS_inputValues(x) [dics setObject:x forKey:@"values"];
#define WS_inputKeys(y) [dics setObject:y forKey:@"keys"];
#define WS_addInputValueToArray [addarrValues addObject:dics];
#define WS_inputValuesAndKeys(x,y)  WS_allocDic WS_inputValues(x) WS_inputKeys(y) WS_addInputValueToArray
#define WS_parametersArr addarrValues

@protocol webServiceSOAPDelegate <NSObject>

-(void) getResponseData:(NSMutableData*) responseData;

@end

@interface webService : NSObject
+(webService *)getCommon;
-(void)webService_GetDictionary_Response:(NSString*) serverURl withParamsValuesAndKeys:(NSMutableArray*) paramValues withUrlType:(NSString*) urlType isPostMethod:(BOOL) isPost :(void (^)(NSMutableDictionary*))result;
-(void)webService_GetArray_Response:(NSString*) serverURl withParamsValuesAndKeys:(NSMutableArray*) paramValues withUrlType:(NSString*) urlType isPostMethod:(BOOL) isPost :(void (^)(NSMutableArray*))result;

-(void) getMethodGetDictionary:(NSString*) params :(void(^) (NSMutableDictionary*)) result;
-(void) getMethodGetArray:(NSString*) params :(void(^) (NSMutableArray*)) result;

-(NSMutableData*) webService_SOAP_Response:(NSString*) urlStringVal withParamsValuesAndKeys:(NSMutableArray*) paramValues withMethodType:(NSString*) method;

@property (weak) id<webServiceSOAPDelegate> delegate;
@property (assign) id paresntClass;

@end
