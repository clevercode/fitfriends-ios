//
//  FFFormFieldView.h
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FFFormFieldView : UIView

@property(nonatomic, copy) NSString *name;
@property(nonatomic, strong) UILabel *label;
@property(nonatomic, strong) UITextField *textField;

@end
