//
//  UIBarButtonItem+FFBarButtonItem.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "UIBarButtonItem+FFBarButtonItem.h"

@implementation UIBarButtonItem (FFBarButtonItem)

- (instancetype)initWithImage:(UIImage *)image target:(id)target action:(SEL)action
{
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setImage:image forState:UIControlStateNormal];
    [button addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    button.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 0);
    button.bounds = CGRectMake(0, 0, image.size.width, image.size.height + 5.f);
    return [self initWithCustomView:button];
}

@end
