//
//  FFUserStatsCell.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFUserStatsCell.h"
#import <KHGravatar/UIImageView+KHGravatar.h>

@interface FFUserStatsCell()

@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UILabel *waterLabel;
@property(nonatomic, strong) UILabel *carbsLabel;
@property(nonatomic, strong) UILabel *weightLabel;

@end

@implementation FFUserStatsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

        UIImageView *avatar = [[UIImageView alloc] init];
        avatar.translatesAutoresizingMaskIntoConstraints = NO;
        avatar.backgroundColor = [UIColor blackColor];
        [self.contentView addSubview:avatar];
        self.avatar = avatar;

        UIImageView *waterIcon = [self makeIcon:@"water"];
        [self.contentView addSubview:waterIcon];
        
        UILabel *waterLabel = [self makeLabel];
        [self.contentView addSubview:waterLabel];
        self.waterLabel = waterLabel;

        UIImageView *carbsIcon = [self makeIcon:@"bread"];
        [self.contentView addSubview:carbsIcon];
        
        UILabel *carbsLabel = [self makeLabel];
        [self.contentView addSubview:carbsLabel];
        self.carbsLabel = carbsLabel;

        UIImageView *weightIcon = [self makeIcon:@"scale"];
        [self.contentView addSubview:weightIcon];
        
        UILabel *weightLabel = [self makeLabel];
        [self.contentView addSubview:weightLabel];
        self.weightLabel = weightLabel;

        NSDictionary *views = NSDictionaryOfVariableBindings(avatar,
                                                             waterIcon, waterLabel,
                                                             carbsIcon, carbsLabel,
                                                             weightIcon, weightLabel);

        [self.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(20)-[avatar]-(>=10)-"
                                                          "[waterIcon]-(5)-[waterLabel(34)]-(15)-"
                                                          "[carbsIcon]-(5)-[carbsLabel(24)]-(15)-"
                                                          "[weightIcon]-(5)-[weightLabel(34)]-|"
                                                 options:NSLayoutFormatAlignAllCenterY
                                                 metrics:nil
                                                   views:views]];

        [self.contentView addConstraints:
         [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-(20)-[avatar]-(20)-|"
                                                 options:kNilOptions
                                                 metrics:nil
                                                   views:views]];
        [avatar addConstraint:
         [NSLayoutConstraint constraintWithItem:avatar
                                      attribute:NSLayoutAttributeWidth
                                      relatedBy:NSLayoutRelationEqual
                                         toItem:avatar
                                      attribute:NSLayoutAttributeHeight
                                     multiplier:1.f
                                       constant:0.f]];
    }
    return self;
}

#pragma mark - View helpers

- (UILabel *)makeLabel
{
    UILabel *label = [[UILabel alloc] init];
    label.translatesAutoresizingMaskIntoConstraints = NO;
    label.text = @"?";
    label.font = [UIFont fontWithName:@"Avenir-Light"
                                 size:16.f];
    label.textAlignment = NSTextAlignmentLeft;
    label.minimumScaleFactor = 0.8f;
    label.adjustsFontSizeToFitWidth = YES;

    return label;
}

- (UIImageView *)makeIcon:(NSString *)name
{
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:name]];
    icon.translatesAutoresizingMaskIntoConstraints = NO;

    return icon;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setAvatarWithEmail:(NSString *)email
{

    [_avatar setImageWithGravatarEmailAddress:email];
}

- (NSString *)water
{
    return self.waterLabel.text;
}

- (void)setWater:(NSString *)water
{
    self.waterLabel.text = water;
}

- (NSString *)carbs
{
    return self.carbsLabel.text;
}

- (void)setCarbs:(NSString *)carbs
{
    self.carbsLabel.text = carbs;
}

- (NSString *)weight
{
    return self.weightLabel.text;
}

- (void)setWeight:(NSString *)weight
{
    self.weightLabel.text = weight;
}


@end
