//
//  FFUser.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import <Mantle/Mantle.h>

@interface FFUser : MTLModel <MTLJSONSerializing>

@property(nonatomic, copy, readonly) NSString *name;
@property(nonatomic, copy, readonly) NSString *email;
@property(nonatomic, copy, readonly) NSDecimalNumber *startWeight;
@property(nonatomic, copy, readonly) NSDecimalNumber *goalWeight;
@property(nonatomic, copy, readonly) NSDecimalNumber *currentWeight;
@property(nonatomic, assign, readonly) NSUInteger height;

@end
