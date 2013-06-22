//
//  FFFormView.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFFormView.h"

@interface FFFormView () {
    NSMutableArray *_fields;
}

@end

@implementation FFFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.translatesAutoresizingMaskIntoConstraints = NO;
        _fields = [[NSMutableArray alloc] init];
    }
    return self;
}

- (void)addField:(FFFormFieldView *)field named:(NSString *)name
{
    field.name = name;
    [self addSubview:field];
    [_fields addObject:field];
}

- (NSArray *)fields
{
    return [_fields copy];
}

- (NSDictionary *)collectValues
{
    NSMutableDictionary *valuesDictionary;
    valuesDictionary = [[NSMutableDictionary alloc] initWithCapacity:[_fields count]];
    for (FFFormFieldView *field in _fields)
    {
        NSString *value;
        if (field.textField.text.length > 0)
        {
            value = field.textField.text;
        }
        else if (field.textField.placeholder.length > 0)
        {
            value = field.textField.placeholder;
        }
        valuesDictionary[field.name] = value;
    }

    return valuesDictionary;
}

@end
