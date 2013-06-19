//
//  FFFoodLog.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-17.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFFoodLog.h"
#import "FFNSDecimalNumberValueTransformer.h"

@implementation FFFoodLog

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"consumedAt": @"consumedAt",
        @"userId": @"user_id",
        @"identifier": @"id"
    };
}

+ (NSValueTransformer *)carbsJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

+ (NSValueTransformer *)fatJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

+ (NSValueTransformer *)proteinJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

@end
