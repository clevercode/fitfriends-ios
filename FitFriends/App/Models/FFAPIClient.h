//
//  FFAPIClient.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "AFHTTPClient.h"

@interface FFAPIClient : AFHTTPClient

+ (instancetype)sharedClient;

@end
