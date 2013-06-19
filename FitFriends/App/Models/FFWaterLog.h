//
//  FFWaterLog.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-17.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FFWaterLog : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign, readonly) NSUInteger identifier;
@property(nonatomic, assign, readonly) NSInteger volume;
@property(nonatomic, assign, readonly) NSUInteger userId;
@property(nonatomic, copy, readonly) NSDate *consumedAt;

@end
