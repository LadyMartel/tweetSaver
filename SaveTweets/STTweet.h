//
//  STTweet.h
//  SaveTweets
//
//  Created by Rose on 8/8/14.
//  Copyright (c) 2014 LadyMartel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface STTweet : NSObject

+(STTweet *)tweetFromTwitterDictionary:(NSDictionary *) jsonDict;
+(STTweet *)tweetFromCoreDataDictionary:(NSDictionary *) jsonDict;

@property (strong, nonatomic) NSString * text;
@property (strong, nonatomic) NSString * username;
@property NSInteger tweetID;

@end
