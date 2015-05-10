//
//  TNDMeetupAPIClient.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/7/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDMeetupAPIClient.h"
#import "TNDMeetup.h"
#import "TNDAddressHelper.h"
#import "TNDDateHelper.h"
#import <AFNetworking/AFNetworking.h>


#define MEETUP_API_KEY @"674c1f62583369291a92a5b693e2a32"
#define MEETUP_BASE_URL @"https://api.meetup.com/2/open_events?sign=true"

@implementation TNDMeetupAPIClient

+ (instancetype)sharedInstance {
    static TNDMeetupAPIClient *sharedInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] init];
    });
    return sharedInstance;
}

- (void)displayMeetupEventsForTopic:(NSString *)topic
                           Latitude:(NSString *)lat
                          Longitude:(NSString *)lon
                    CompletionBlock:(void (^)(NSArray *meetUpEvents))completionBlock {
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    NSDictionary *urlParams = @{@"key":MEETUP_API_KEY,
                                @"topic":topic,
                                @"lat":lat,
                                @"lon":lon};
    
    [manager GET:MEETUP_BASE_URL parameters:urlParams success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSLog(@"Accessing Meetup open_events API");
        
        NSArray *meetUpCollections = responseObject[@"results"];
        NSMutableArray *meetUpEvents = [[NSMutableArray alloc] init];
        
        NSDictionary *options = @{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType};
        NSError *error = nil;
        

        for (NSDictionary *meetUpCollection in meetUpCollections) {
            
            if (meetUpCollection[@"venue"] && [meetUpEvents count] <= 40) {
                
                TNDMeetup *meetUp = [[TNDMeetup alloc] init];
                
                meetUp.eventName = meetUpCollection[@"name"];
                meetUp.meetupName = meetUpCollection[@"group"][@"name"];
                meetUp.attendeeLimit = meetUpCollection[@"rsvp_limit"];
                meetUp.typeOfAttendee = meetUpCollection[@"group"][@"who"];
                meetUp.url = meetUpCollection[@"event_url"];
                meetUp.rsvpCount = meetUpCollection[@"yes_rsvp_count"];
                meetUp.lat = meetUpCollection[@"venue"][@"lat"];
                meetUp.lon = meetUpCollection[@"venue"][@"lon"];
                meetUp.address = [TNDAddressHelper convertAddressFromDictionary:meetUpCollection];
                
                meetUp.time = [TNDDateHelper configureDateFromEpochTime:meetUpCollection[@"time"]];
               
                NSString *eventDescription = [NSString stringWithFormat:@"\n\n%@", meetUpCollection[@"description"]];
                
                NSString *eventDescriptionAsString = eventDescription;
                meetUp.eventDescription = [[NSAttributedString alloc] initWithData:[eventDescriptionAsString dataUsingEncoding:NSUTF8StringEncoding] options:options documentAttributes:nil error:&error];
                
                [meetUpEvents addObject:meetUp];
            }
        }
        
        completionBlock(meetUpEvents);
        
        NSLog(@"LAT IS %@, LON IS %@", lat, lon);
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        NSLog(@"%@", error.localizedDescription);
        
    }];

}


@end
