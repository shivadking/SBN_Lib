//
//  SBN_RSSReader.h
//  xmlParsings
//
//  Created by Mini Mac i72 on 1/14/14.
//  Copyright (c) 2014 TWILIGHT SOFTWARES. All rights reserved.
//  Dev @ sivabalan@twilightsoftwares.com

#import <Foundation/Foundation.h>

@protocol SBN_XMLDelegate <NSObject>

-(void) getXMLContentData :(NSMutableArray*) arrWithXMLContent :(NSString*) identifierName;

@end


@interface SBN_RSSReader : NSObject<NSXMLParserDelegate>
{
    UIActivityIndicatorView * activityIndicator;
	NSXMLParser * rssParser;
	NSMutableArray *arrFeedData;
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
}
- (void)SB_RSSReader_Call:(NSString *)URL withMainTag:(NSString*) MainTagName withTagKeys:(NSMutableArray*) keyArray withIdentifier:(NSString*) identifierName;
- (void)SB_RSSReader_Call_NSMutableData:(NSMutableData*) _responseData withMainTag:(NSString*) MainTagName withTagKeys:(NSMutableArray*) keyArray withIdentifier:(NSString*) identifierName;

@property (weak) id<SBN_XMLDelegate> delegate;
@property (assign) id paresntClass;
@end
