//
//  webService.m
//  twilightFW
//
//  Created by Mini Mac i72 on 1/10/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//

#import "webService.h"
#import "ASIFormDataRequest.h"
#import "defnitions.h"

@implementation webService
{
    ASIFormDataRequest *request;
}
+(webService *)getCommon {
    static webService *__instance = nil;
    if (__instance == nil) {
        __instance = [[webService alloc] init];
    }
    
    return __instance;
}

#pragma mark - WebService - PHP/DotNet

-(void)webService_GetDictionary_Response:(NSString*) serverURl withParamsValuesAndKeys:(NSMutableArray*) paramValues withUrlType:(NSString*) urlType isPostMethod:(BOOL) isPost :(void (^)(NSMutableDictionary*))result
{
    if (isPost) {
        NSString *serviceURL =[NSString stringWithFormat:@"%@/%@",serverURl,urlType];
        
        NSLog(@"URLSERVICE==>%@",serviceURL);
        
        NSLog(@"params==>%@",paramValues);
        
        NSURL *url = [NSURL URLWithString:serviceURL];
        request = [ASIFormDataRequest requestWithURL:url];
        request.delegate =self;
        
        [request setRequestMethod:@"POST"];
        for(int i=0; i<[paramValues count]; i++)
        {
            [request setPostValue:[[paramValues objectAtIndex:i] objectForKey:@"values"]  forKey:[[paramValues objectAtIndex:i] objectForKey:@"keys"]];
        }
        [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        [request addRequestHeader:@"enctype" value:@"multipart/form-data"];
        [request startSynchronous];
        
        if (request)
        {
            if ([request error])
            {
                NSLog(@"Error: %@",[[request error] localizedDescription]);
                
                [self performSelectorOnMainThread:@selector(ShowDefaultAlert:) withObject:NETWORK_ERROR waitUntilDone:YES];
                return;
                
            }
            else if ([request responseString])
            {
                NSData *data= [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSMutableDictionary * dictPins = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                //NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"str : %@",dictPins);
                
                result(dictPins);
            }
        }
        
    }else
    {
        NSString *params = @"";
        for(int i=0; i<[paramValues count]; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%@=%@",[[paramValues objectAtIndex:i] objectForKey:@"keys"],[[paramValues objectAtIndex:i] objectForKey:@"values"]];
            if(i == 0)
            {
                params = [NSString stringWithFormat:@"%@",str];
            }else
            {
                params = [NSString stringWithFormat:@"%@&%@",params,str];
            }
            
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@%@",serverURl,urlType,params]];
        
        NSLog(@"URL==>%@",url);
        
        request = [ASIHTTPRequest requestWithURL:url];
        request.delegate=self;
        [request startSynchronous];
        
        if (request)
        {
            if ([request error])
            {
                //[responseField setText:[[request error] localizedDescription]];
                NSLog(@"Error: %@",[[request error] localizedDescription]);
                
            }
            else if ([request responseString])
            {
                
                NSData *dat= [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
                NSMutableDictionary *json= [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableLeaves error:nil];
                
                result(json);
                
            }
        }else
        {
            NSLog(@"Network Error");
        }
        
    }
    
}

-(void)webService_GetArray_Response:(NSString*) serverURl withParamsValuesAndKeys:(NSMutableArray*) paramValues withUrlType:(NSString*) urlType isPostMethod:(BOOL) isPost :(void (^)(NSMutableArray*))result
{
    if (isPost) {
        NSString *serviceURL =[NSString stringWithFormat:@"%@/%@",serverURl,urlType];
        
        NSLog(@"URLSERVICE==>%@",serviceURL);
        
        NSLog(@"params==>%@",paramValues);
        
        NSURL *url = [NSURL URLWithString:serviceURL];
        request = [ASIFormDataRequest requestWithURL:url];
        request.delegate =self;
        
        [request setRequestMethod:@"POST"];
        for(int i=0; i<[paramValues count]; i++)
        {
            [request setPostValue:[[paramValues objectAtIndex:i] objectForKey:@"values"]  forKey:[[paramValues objectAtIndex:i] objectForKey:@"keys"]];
        }
        [request addRequestHeader:@"Content-Type" value:@"application/x-www-form-urlencoded"];
        [request addRequestHeader:@"enctype" value:@"multipart/form-data"];
        [request startSynchronous];
        
        if (request)
        {
            if ([request error])
            {
                NSLog(@"Error: %@",[[request error] localizedDescription]);
                
                [self performSelectorOnMainThread:@selector(ShowDefaultAlert:) withObject:NETWORK_ERROR waitUntilDone:YES];
                return;
                
            }
            else if ([request responseString])
            {
                NSData *data= [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
                
                NSMutableArray * dictPins = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
                
                //NSString *str = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
                //NSLog(@"str : %@",dictPins);
                
                result(dictPins);
            }
        }
        
    }else
    {
        NSString *params = @"";
        for(int i=0; i<[paramValues count]; i++)
        {
            NSString *str = [NSString stringWithFormat:@"%@=%@",[[paramValues objectAtIndex:i] objectForKey:@"keys"],[[paramValues objectAtIndex:i] objectForKey:@"values"]];
            if(i == 0)
            {
                params = [NSString stringWithFormat:@"%@",str];
            }else
            {
                params = [NSString stringWithFormat:@"%@&%@",params,str];
            }
            
        }
        
        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@%@",serverURl,urlType,params]];
        
        NSLog(@"URL==>%@",url);
        
        request = [ASIHTTPRequest requestWithURL:url];
        request.delegate=self;
        [request startSynchronous];
        
        if (request)
        {
            if ([request error])
            {
                //[responseField setText:[[request error] localizedDescription]];
                NSLog(@"Error: %@",[[request error] localizedDescription]);
                
            }
            else if ([request responseString])
            {
                
                NSData *dat= [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
                NSMutableArray *json= [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableLeaves error:nil];
                
                result(json);
                
            }
        }else
        {
            NSLog(@"Network Error");
        }
        
    }
    
}

-(void) getMethodGetDictionary:(NSString*) params :(void(^) (NSMutableDictionary*)) result
{
    NSURL *url = [NSURL URLWithString:params];
    
    NSLog(@"URL==>%@",url);
    
    request = [ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startSynchronous];
    
    if (request)
    {
        if ([request error])
        {
            //[responseField setText:[[request error] localizedDescription]];
            NSLog(@"Error: %@",[[request error] localizedDescription]);
            
        }
        else if ([request responseString])
        {
            
            NSData *dat= [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableDictionary *json= [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableLeaves error:nil];
            
            result(json);
            
        }
    }else
    {
        NSLog(@"Network Error");
    }
}
-(void) getMethodGetArray:(NSString*) params :(void(^) (NSMutableArray*)) result
{
    NSURL *url = [NSURL URLWithString:params];
    
    NSLog(@"URL==>%@",url);
    
    request = [ASIHTTPRequest requestWithURL:url];
    request.delegate=self;
    [request startSynchronous];
    
    if (request)
    {
        if ([request error])
        {
            //[responseField setText:[[request error] localizedDescription]];
            NSLog(@"Error: %@",[[request error] localizedDescription]);
            
        }
        else if ([request responseString])
        {
            
            NSData *dat= [[request responseString] dataUsingEncoding:NSUTF8StringEncoding];
            NSMutableArray *json= [NSJSONSerialization JSONObjectWithData:dat options:NSJSONReadingMutableLeaves error:nil];
            
            result(json);
            
        }
    }else
    {
        NSLog(@"Network Error");
    }
}

-(void) ShowDefaultAlert:(NSString *) Message
{
    UIAlertView * alert = [[UIAlertView alloc] initWithTitle:APP_TITLE message:Message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
    [alert show];
}


#pragma mark - WebServie -SOAP
-(NSMutableData*) webService_SOAP_Response:(NSString*) urlStringVal withParamsValuesAndKeys:(NSMutableArray*) paramValues withMethodType:(NSString*) method
{
    
    
    NSString *urlString = urlStringVal;  //@"http://[URL]/[web_service_name.asmx]/[web_method]";
    NSURL *url = [NSURL URLWithString:urlString];
    NSMutableURLRequest *requests = [NSMutableURLRequest requestWithURL:url];
    [requests setHTTPMethod: method];
    
    //Setting parameters section Begin
    
    NSString *params = @"";
    for(int i=0; i<[paramValues count]; i++)
    {
        NSString *str = [NSString stringWithFormat:@"%@=%@",[[paramValues objectAtIndex:i] objectForKey:@"keys"],[[paramValues objectAtIndex:i] objectForKey:@"values"]];
        if(i == 0)
        {
            params = [NSString stringWithFormat:@"%@",str];
        }else
        {
            params = [NSString stringWithFormat:@"%@&%@",params,str];
        }
        
    }
    
    NSString *reqStringFUll=params;
    NSData *requestData = [NSData dataWithBytes:[reqStringFUll UTF8String] length:[reqStringFUll length]];
    [requests setHTTPBody: requestData];
    
    //Setting parameters section ends
    
    NSURLConnection *conn=[[NSURLConnection alloc]initWithRequest:requests delegate:self ];
    NSLog(@"connt = %@",conn);
    
    return _responseData;
}

NSMutableData *_responseData;
#pragma mark NSURLConnection Delegate Methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    _responseData = [[NSMutableData alloc] init];
    
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // Append the new data to the instance variable you declared
    [_responseData appendData:data];
    // NSLog(@"res  ==> %@",_responseData);
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    
    [_delegate getResponseData:_responseData];
    
    NSLog(@"Finished Connections ==> Ended");
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    NSLog(@"Error : %@",[error localizedDescription]);
}

- (void)didReceiveMemoryWarning
{
    // Dispose of any resources that can be recreated.
}


@end
