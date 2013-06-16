//
//  FFUserDetailViewController.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFUserDetailViewController.h"
#import <KHGravatar/UIImageView+KHGravatar.h>

@interface FFUserDetailViewController ()

@property(nonatomic, strong) UIImageView *avatar;

@end

@implementation FFUserDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];

    UIImageView *avatar = [[UIImageView alloc] init];
    avatar.translatesAutoresizingMaskIntoConstraints = NO;

    // Constrain to square
    [avatar addConstraint:
     [NSLayoutConstraint constraintWithItem:avatar
                                  attribute:NSLayoutAttributeHeight
                                  relatedBy:NSLayoutRelationEqual
                                     toItem:avatar
                                  attribute:NSLayoutAttributeWidth
                                 multiplier:1.f
                                   constant:0.f]];
    [view addSubview:avatar];
    self.avatar = avatar;

    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.translatesAutoresizingMaskIntoConstraints = NO;
    nameLabel.text = self.user.name;
    nameLabel.font = [UIFont fontWithName:@"Avenir-Light"
                                     size:24.f];
    [view addSubview:nameLabel];

    NSDictionary *views = NSDictionaryOfVariableBindings(avatar,
                                                         nameLabel);

    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[avatar]"
                                             options:kNilOptions
                                             metrics:nil
                                               views:views]];
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[avatar(100)]-(20)-[nameLabel]-|"
                                             options:NSLayoutFormatAlignAllCenterY
                                             metrics:nil
                                               views:views]];

    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [self.avatar setImageWithGravatarEmailAddress:self.user.email];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSString *)title
{
    return self.user.name;
}

@end
