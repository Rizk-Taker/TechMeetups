//
//  TNDDataStore.h
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/8/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import <Foundation/Foundation.h>
@class CLLocationManager;

@interface TNDDataStore : NSObject

@property (strong, nonatomic) NSMutableArray *meetUps;

+ (instancetype)sharedDataStore;

- (void) getMeetUpsAroundUserLocationWithLatitude: (NSString *)lat andLongitude: (NSString *)lon
                                         ForTopic: (NSString *)topic;

@end
