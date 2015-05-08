//
//  TNDMeetupAPIClient.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/7/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDMeetupAPIClient.h"
#import <AFNetworking/AFNetworking.h>

#define MEETUP_API_KEY @""
#define MEETUP_BASE_URL @"https://api.meetup.com/2/open_events?sign=true"

@implementation TNDMeetupAPIClient

+ (instancetype)sharedProxy {
    static TNDMeetupAPIClient *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)displayMeetupEventsForTopic:(NSString *)topic
                           Latitude:(NSString *)lat
                          Longitude:(NSString *)lon {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *urlParams = @{@"key":MEETUP_API_KEY,
                                @"topic":topic,
                                @"lat":lat,
                                @"lon":lon};
    
    [manager GET:MEETUP_BASE_URL parameters:urlParams success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Accessing Meetup open_events API");
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@", error.localizedDescription);
        
    }];

}


@end
