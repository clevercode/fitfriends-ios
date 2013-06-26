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

- (NSInteger)todaysWaterInOunces
{
    NSDecimalNumber *ml = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d",self.todaysWater]];
    NSDecimalNumber *conversion = [NSDecimalNumber decimalNumberWithString:@"0.033814"];
    NSDecimalNumber *ounces = [ml decimalNumberByMultiplyingBy:conversion];
    ounces = [ounces decimalNumberByRoundingAccordingToBehavior:nil];
    return [ounces integerValue];
}

#pragma mark - MTLJSONSerializing protocol methods

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
        @"identifier": @"id",
        @"startWeight": @"start_weight",
        @"goalWeight": @"goal_weight",
        @"currentWeight": @"current_weight",
        @"todaysCarbs": @"todays_carbs",
        @"todaysWater": @"todays_water",
        @"percentLost": @"percentage_lost"
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

+ (NSValueTransformer *)percentLostJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}

+ (NSValueTransformer *)todaysCarbsJSONTransformer
{
    return [NSValueTransformer valueTransformerForName:FFNSDecimalNumberValueTransformerName];
}


@end
