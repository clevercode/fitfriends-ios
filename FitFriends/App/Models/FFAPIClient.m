//
//  FFAPIClient.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFAPIClient.h"
#import <AFNetworking/AFJSONRequestOperation.h>

NSString * const kFFAPIBaseURLString = @"https://fitfriends.herokuapp.com/";

@implementation FFAPIClient

+ (instancetype)sharedClient
{
    static FFAPIClient *_sharedClient;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[FFAPIClient alloc] initWithBaseURL:[NSURL URLWithString:kFFAPIBaseURLString]];
    });
    return _sharedClient;
}

- (id)initWithBaseURL:(NSURL *)url
{
    self = [super initWithBaseURL:url];
    if (self)
    {
        [self registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [self setDefaultHeader:@"Accept" value:@"application/json"];
    }
    return self;
}

@end
