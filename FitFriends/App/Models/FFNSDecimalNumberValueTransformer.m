//
//  FFNSDecimalNumberValueTransformer.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFNSDecimalNumberValueTransformer.h"

NSString * const FFNSDecimalNumberValueTransformerName = @"FFNSDecimalNumberValueTransformer";

@implementation FFNSDecimalNumberValueTransformer

+ (void)load
{
    @autoreleasepool {
        [NSValueTransformer setValueTransformer:[[FFNSDecimalNumberValueTransformer alloc] init]
                                        forName:FFNSDecimalNumberValueTransformerName];
    }
}

+ (Class)transformedValueClass
{
    return [NSDecimalNumber class];
}

+ (BOOL)allowsReverseTransformation
{
    return YES;
}

- (id)transformedValue:(id)value
{
    return [NSDecimalNumber decimalNumberWithString:value];
}

- (id)reverseTransformedValue:(id)value
{
    return [(NSDecimalNumber *)value stringValue];
}

@end
