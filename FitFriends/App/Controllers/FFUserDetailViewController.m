//
//  FFUserDetailViewController.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFUserDetailViewController.h"
#import <KHGravatar/UIImageView+KHGravatar.h>
#import <BlocksKit/UIActionSheet+BlocksKit.h>

NSString * const FFUserIdUserDefaultsKey = @"ffUserId";

@interface FFUserDetailViewController ()

@property(nonatomic, strong) UIImageView *avatar;
@property(nonatomic, strong) UIButton *meButton;

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

    UIButton *meButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    meButton.translatesAutoresizingMaskIntoConstraints = NO;
    [meButton setTitle:@"Set this user as me"
              forState:UIControlStateNormal];
    [meButton setTitle:@"This user is you"
              forState:UIControlStateDisabled];
    [meButton addTarget:self
                 action:@selector(onMeButtonAction:)
       forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:meButton];
    [meButton pinToSuperviewEdges:JRTViewPinBottomEdge|JRTViewPinLeftEdge|JRTViewPinRightEdge
                            inset:20.f];
    self.meButton = meButton;

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
	NSInteger currentUserId = [[NSUserDefaults standardUserDefaults] integerForKey:FFUserIdUserDefaultsKey];
    _meButton.enabled = !(currentUserId && _user.identifier == currentUserId);
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

#pragma mark - Actions

- (void)onMeButtonAction:(UIButton *)sender
{

    UIActionSheet *actionSheet = [UIActionSheet actionSheetWithTitle:@"Are you sure this is you?"];
    [actionSheet addButtonWithTitle:@"Yes, its me."
                            handler:^{
                                NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
                                [defaults setInteger:self.user.identifier
                                              forKey:FFUserIdUserDefaultsKey];
                                [defaults synchronize];
                                [sender setEnabled:NO];
                            }];
    [actionSheet addButtonWithTitle:@"Nope."];
    [actionSheet showFromRect:[sender frame]
                       inView:self.view
                     animated:YES];
}

@end
