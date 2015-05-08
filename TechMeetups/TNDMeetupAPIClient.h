//
//  TNDMeetupAPIClient.h
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/7/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDMeetupAPIClient : NSObject

+ (instancetype)sharedProxy;

- (void)displayMeetupEventsForTopic: (NSString *)topic
                           Latitude: (NSString *)lat
                          Longitude: (NSString *)lon;

@end
