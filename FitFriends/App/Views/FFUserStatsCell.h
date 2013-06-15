//
//  FFUserStatsCell.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFUserStatsCell : UITableViewCell

@property(nonatomic) NSString *water;
@property(nonatomic) NSString *carbs;
@property(nonatomic) NSString *weight;

- (void)setAvatarWithEmail:(NSString *)email;

@end
