//
//  STTweet.m
//  SaveTweets
//
//  Created by Rose on 8/8/14.
//  Copyright (c) 2014 LadyMartel. All rights reserved.
//

#import "STTweet.h"

@implementation STTweet
+(STTweet *)tweetFromTwitterDictionary:(NSDictionary *) jsonDict{
  STTweet * newTweet = [[STTweet alloc]init];
  
  newTweet.text = [jsonDict objectForKey:@"text"];
  newTweet.username = [[jsonDict objectForKey:@"user"] objectForKey:@"screen_name"];
  newTweet.tweetID = (NSInteger)[jsonDict objectForKey:@"id"];
  
  return newTweet;
}


+(STTweet *)tweetFromCoreDataDictionary:(NSDictionary *) jsonDict{
  STTweet * newTweet = [[STTweet alloc]init];
  newTweet.text = [jsonDict objectForKey:@"text"];
  newTweet.username = [jsonDict objectForKey:@"username"];
  newTweet.tweetID = (NSInteger)[jsonDict objectForKey:@"id"];
  
  return newTweet;
}




@end
