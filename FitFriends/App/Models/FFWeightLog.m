//
//  FFWeightLog.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-17.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFWeightLog.h"
#import "FFNSDecimalNumberValueTransformer.h"

@implementation FFWeightLog

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"measuredAt": @"measured_at",
        @"userId": @"user_id",
        @"identifier": @"id"
    };
}

+ (NSValueTransformer *)weightJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

@end
