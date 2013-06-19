//
//  FFFormView.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FFFormFieldView.h"

@interface FFFormView : UIView

- (NSArray *)fields;
- (void)addField:(FFFormFieldView *)field named:(NSString *)name;
- (NSDictionary *)collectValues;

@end
