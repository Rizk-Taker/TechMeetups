//
//  TNDAddressHelper.m
//  TechMeetups
//
//  Created by Nicolas Rizk on 5/8/15.
//  Copyright (c) 2015 Nicolas Rizk. All rights reserved.
//

#import "TNDAddressHelper.h"

@implementation TNDAddressHelper

+ (NSString *) convertAddressFromDictionary: (NSDictionary *)dictionary {
    
    NSDictionary *venue = dictionary[@"venue"];
    
    NSString *state = [venue[@"state"] uppercaseString];
    
    NSString *address = [NSString stringWithFormat:@"%@\n%@\n%@, %@, %@", venue[@"name"], venue[@"address_1"], venue[@"city"], state, venue[@"country"]];
    
    return address;
}

@end
