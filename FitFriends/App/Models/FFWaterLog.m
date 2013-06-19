//
//  FFWaterLog.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-17.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFWaterLog.h"

@implementation FFWaterLog

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"consumedAt": @"consumed_at",
        @"userId": @"user_id",
        @"identifier": @"id"
    };
}

@end
