//
//  TNDDataStore.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/8/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDDataStore.h"
#import "TNDMeetupAPIClient.h"

@implementation TNDDataStore

+ (instancetype)sharedDataStore {
    
    static TNDDataStore *_sharedDataStore = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedDataStore = [[TNDDataStore alloc] init];
    });
    
    return _sharedDataStore;
}

- (void) getMeetUpsAroundUserLocationWithLatitude: (NSString *)lat
                                     andLongitude: (NSString *)lon
                                         ForTopic: (NSString *)topic {
    
    [[TNDMeetupAPIClient sharedInstance] displayMeetupEventsForTopic:topic
                                                            Latitude:lat
                                                           Longitude:lon CompletionBlock:^(NSArray *meetUpEvents) {
                                                               
                                                               self.meetUps = [NSMutableArray arrayWithArray:meetUpEvents];
                                                           }];
    
}

@end
