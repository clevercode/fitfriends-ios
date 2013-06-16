//
//  FFFormFieldView.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFFormFieldView.h"

#import <QuartzCore/QuartzCore.h>

@interface FFFormFieldView ()

@property(nonatomic, strong) CALayer *bottomBorder;

@end


@implementation FFFormFieldView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        
        UILabel *label = [[UILabel alloc] init];
        label.translatesAutoresizingMaskIntoConstraints = NO;
        label.text = @"?";
        label.font = [UIFont fontWithName:@"Avenir-Light" size:20.f];
        label.textAlignment = NSTextAlignmentRight;
        [self addSubview:label];
        self.label = label;

        UITextField *textField = [[UITextField alloc] init];
        textField.translatesAutoresizingMaskIntoConstraints = NO;
        textField.placeholder = 0;
        textField.font = [UIFont fontWithName:@"Avenir-Book"
                                                size:20.f];
        textField.keyboardType = UIKeyboardTypeDecimalPad;
        [self addSubview:textField];
        self.textField = textField;

        NSDictionary *views = NSDictionaryOfVariableBindings(label, textField);

        [self addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[label(80)]-(15)-[textField]|"
                                                 options:NSLayoutFormatAlignAllBaseline
                                                 metrics:nil
                                                   views:views]];
        [self addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[textField]|"
                                                 options:kNilOptions
                                                 metrics:nil
                                                   views:views]];
        [self addBottomBorder];
    }
    return self;
}

- (void)addBottomBorder
{
    CALayer *bottomBorder = [CALayer layer];

    bottomBorder.backgroundColor = [UIColor colorWithWhite:0.8f
                                                     alpha:1.0f].CGColor;
    self.bottomBorder = bottomBorder;

    [self.layer addSublayer:bottomBorder];
}

- (void)layoutSubviews
{
    [super layoutSubviews];

    // adjust frame of bottom border;
    UIEdgeInsets edges = UIEdgeInsetsMake(CGRectGetHeight(self.bounds)-1, 0, 0, 0);
    _bottomBorder.frame = UIEdgeInsetsInsetRect(self.bounds, edges);
}

@end
