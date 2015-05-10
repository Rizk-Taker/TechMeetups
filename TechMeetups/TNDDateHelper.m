//
//  TNDDateHelper.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/9/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDDateHelper.h"

@implementation TNDDateHelper

+ (NSString *)configureDateFromEpochTime: (NSString *)epochTime {
    
    NSTimeInterval seconds = [epochTime doubleValue];
    
    NSDate *epochNSDate = [[NSDate alloc] initWithTimeIntervalSince1970:seconds];
    
    NSDateFormatter *dayFormat = [[NSDateFormatter alloc] init];
    [dayFormat setDateFormat:@"EE, MMMM dd"];
    
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"hh:mm"];
    
    
    NSString *dayDateString = [dayFormat stringFromDate:epochNSDate];
    NSString *timeDateString = [timeFormat stringFromDate:epochNSDate];
    
    if ([timeDateString hasPrefix:@"0"]) {
        timeDateString = [timeDateString substringFromIndex:1];
    }
    
    return [NSString stringWithFormat:@"%@ at %@", dayDateString, timeDateString];
    
}
@end
