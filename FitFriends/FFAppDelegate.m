//
//  FFAppDelegate.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFAppDelegate.h"
#import "FFLeaderboardViewController.h"
#import <HockeySDK/HockeySDK.h>

@implementation FFAppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Hockey App
    [[BITHockeyManager sharedHockeyManager] configureWithIdentifier:@"cbf0dffd40de624ae36e9e77e70006b5"
                                                           delegate:self];
    [[BITHockeyManager sharedHockeyManager] startManager];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    self.window.backgroundColor = [UIColor whiteColor];

    FFLeaderboardViewController *rootViewController = [[FFLeaderboardViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [[UINavigationBar appearance] setTitleTextAttributes:@{UITextAttributeFont: [UIFont fontWithName:@"Avenir-Black"
                                                                                                       size:20.f]}];
    UIColor *brandRed = [UIColor colorWithRed:0.8f green:0.067f blue:0.f alpha:1.f];
    [[UINavigationBar appearance] setTintColor:brandRed];
    UIImage *navBar = [UIImage imageNamed:@"nav_bar"];
    navBar = [navBar resizableImageWithCapInsets:UIEdgeInsetsMake(1, 0, 1, 0)];
    [[UINavigationBar appearance] setBackgroundImage:navBar forBarMetrics:UIBarMetricsDefault];

    // Back Button
    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:[[UIImage imageNamed:@"back"] resizableImageWithCapInsets:UIEdgeInsetsMake(0, 18.f, 0, 0)]
                                                      forState:UIControlStateNormal
                                                    barMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonTitlePositionAdjustment:UIOffsetMake(4.f, 0.f)
                                                         forBarMetrics:UIBarMetricsDefault];
    [[UIBarButtonItem appearance] setBackButtonBackgroundVerticalPositionAdjustment:3.f
                                                                      forBarMetrics:UIBarMetricsDefault];

    // Segmented Controls
    [[UISegmentedControl appearance] setTitleTextAttributes:@{UITextAttributeFont: [UIFont fontWithName:@"Avenir-Light" size:18.f],
                                                              UITextAttributeTextColor: [UIColor blackColor],
                                                              UITextAttributeTextShadowColor: [UIColor clearColor]}
                                                   forState:UIControlStateNormal];
    [[UISegmentedControl appearance] setTitleTextAttributes:@{UITextAttributeTextColor: brandRed}
                                                   forState:UIControlStateSelected];

    self.brandRedColor = brandRed;

    self.window.rootViewController = navigationController;
    [self.window makeKeyAndVisible];
    return YES;
}

- (NSArray *)buttonColors
{
    return @[(id)[[UIColor colorWithWhite:1.f alpha:1.0] CGColor],
             (id)[[UIColor colorWithWhite:0.6f alpha:1.0] CGColor]
             ];
}

- (NSArray *)buttonHighlightedColors
{
    return @[(id)[[self brandRedColor] CGColor],
             (id)[[self brandRedColor] CGColor]
             ];
}

- (UIImage *)buttonImageHighlighted:(BOOL)highlighted
{
    CGSize imageSize = CGSizeMake(21,44); // UIButton metrics
    UIGraphicsBeginImageContextWithOptions(imageSize, NO, 0.f);
    UIBezierPath *roundedRect =
    [UIBezierPath bezierPathWithRoundedRect:CGRectMake(0, 0, imageSize.width, imageSize.height)
                             cornerRadius:5.f];
    [roundedRect addClip];

    // Gradient
    NSArray *colors = highlighted ? [self buttonHighlightedColors] : [self buttonColors];
    CGContextRef    context = UIGraphicsGetCurrentContext();
    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat         locations[] = { 0.0, 1.0 };

    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef)colors, locations);
    CGContextDrawLinearGradient(context, gradient, CGPointMake(0, 0), CGPointMake(0, 44), kNilOptions);

    // Cleanup
    CGGradientRelease(gradient);
    CGColorSpaceRelease(colorSpace);

    // Border
    [[UIColor whiteColor] setStroke];
    [roundedRect setLineWidth:2.f];
    [roundedRect strokeWithBlendMode:kCGBlendModeOverlay alpha:0.33f];

    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return [image resizableImageWithCapInsets:UIEdgeInsetsMake(5, 5, 5, 5)];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
