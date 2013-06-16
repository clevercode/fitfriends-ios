//
//  FFUser.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFUser.h"
#import "FFNSDecimalNumberValueTransformer.h"

@implementation FFUser

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"startWeight": @"start_weight",
        @"goalWeight": @"goal_weight",
        @"currentWeight": @"current_weight"
    };
}

+ (NSValueTransformer *)startWeightJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

+ (NSValueTransformer *)goalWeightJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

+ (NSValueTransformer *)currentWeightJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

@end
