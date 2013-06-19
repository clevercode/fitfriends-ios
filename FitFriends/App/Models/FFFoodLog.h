//
//  FFFoodLog.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-17.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FFFoodLog : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign, readonly) NSUInteger identifier;
@property(nonatomic, assign, readonly) NSUInteger userId;
@property(nonatomic, copy, readonly) NSDate *consumedAt;

@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSDecimalNumber *carbs;
@property(nonatomic, copy, readonly) NSDecimalNumber *fat;
@property(nonatomic, copy, readonly) NSDecimalNumber *protein;


@end
