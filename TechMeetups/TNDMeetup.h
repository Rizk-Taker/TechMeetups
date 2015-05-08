//
//  TNDMeetup.h
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/7/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TNDMeetup : NSObject

@property (strong, nonatomic) NSString * eventName;
@property (strong, nonatomic) NSString * meetupName;
@property (strong, nonatomic) NSString * attendeeLimit;
@property (strong, nonatomic) NSString * typeOfAttendee;
@property (strong, nonatomic) NSString * abilityToJoin;
@property (strong, nonatomic) NSString * url;
@property (strong, nonatomic) NSString * rsvpCount;
@property (strong, nonatomic) NSString * duration;
@property (strong, nonatomic) NSString * time;
@property (strong, nonatomic) NSAttributedString * eventDescription;
@property (strong, nonatomic) NSString * address;
@property (strong, nonatomic) NSString * lat;
@property (strong, nonatomic) NSString * lon;

@end
