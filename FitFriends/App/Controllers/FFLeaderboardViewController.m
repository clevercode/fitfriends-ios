//
//  FFLeaderboardViewController.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFLeaderboardViewController.h"
#import "FFUserStatsCell.h"
#import "FFUser.h"
#import "FFAPIClient.h"
#import "FFUserDetailViewController.h"
#import "FFNewLogViewController.h"
#import "UIBarButtonItem+FFBarButtonItem.h"
#import <BlocksKit/BlocksKit.h>
#import <ActionSheetPicker/ActionSheetDatePicker.h>

static NSString * const CellIdentifier = @"UserStatsCell";

@interface FFLeaderboardViewController ()

@property(nonatomic) UINavigationBar *navigationBar;
@property(nonatomic) UITableView *tableView;
@property(nonatomic) NSArray *friends;

@end

@implementation FFLeaderboardViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.friends = @[];
        self.title = @"Fit Friends";
        self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                                 target:self
                                                                                 action:@selector(onAddAction:)];

        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemOrganize
                                                                                target:self
                                                                                action:@selector(onSelectDateAction:)];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.tableView.rowHeight = 90.f;
    [self.tableView registerClass:[FFUserStatsCell class]
           forCellReuseIdentifier:CellIdentifier];
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self
                       action:@selector(onRefreshAction:)
             forControlEvents:UIControlEventValueChanged];
    self.refreshControl = refreshControl;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if ([_friends count] == 0)
    {
        [self loadData];
    }
}

#pragma mark -

- (void)loadData
{
    [self.refreshControl beginRefreshing];
    [[FFAPIClient sharedClient] getPath:@"users"
                             parameters:nil
                                success:^(AFHTTPRequestOperation *operation, NSArray *users) {
                                    self.friends = [users map:^id(NSDictionary *json) {
                                        return [MTLJSONAdapter modelOfClass:[FFUser class]
                                                         fromJSONDictionary:json
                                                                      error:NULL];
                                    }];
                                    [self.tableView reloadData];
                                    [self.refreshControl endRefreshing];
                                } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"API Error"
                                                                                    message:error.userInfo[NSLocalizedDescriptionKey]
                                                                                   delegate:nil
                                                                          cancelButtonTitle:@"Darn"
                                                                          otherButtonTitles:nil];
                                    [alert show];
                                    [self.refreshControl endRefreshing];
                                }];
}

#pragma mark - Actions

- (void)onAddAction:(id)sender
{
    NSInteger userId = [[NSUserDefaults standardUserDefaults] integerForKey:@"ffUserId"];
    if (!userId)
    {
        [UIAlertView showAlertViewWithTitle:@"Who are you?"
                                    message:@"Sign in to continue."
                          cancelButtonTitle:@"Okay"
                          otherButtonTitles:nil
                                    handler:nil];
        return;
    }
    FFNewLogViewController *newLogViewController = [[FFNewLogViewController alloc] init];
    UINavigationController *navigationController = [[UINavigationController alloc] initWithRootViewController:newLogViewController];
    [self presentViewController:navigationController
                       animated:YES
                     completion:nil];
}

- (void)onSelectDateAction:(id)sender
{
    id picker = [ActionSheetDatePicker showPickerWithTitle:@"Select a day"
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                        target:self
                                        action:@selector(onPickDate:)
                                        origin:self.view];
    [[picker pickerView] setTintColor:self.view.window.tintColor];
}

- (void)onPickDate:(id)sender
{
    
}

- (void)onRefreshAction:(id)sender
{
    [self loadData];
}

#pragma mark - UITableViewDataSource protocol methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFUserStatsCell *cell = (FFUserStatsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                               forIndexPath:indexPath];
    FFUser *user = _friends[indexPath.row];
    [cell setAvatarWithEmail:user.email];
    cell.water = [NSString stringWithFormat:@"%doz", user.todaysWaterInOunces];
    cell.carbs = [NSString stringWithFormat:@"%@", user.todaysCarbs];
    cell.weight = [NSString stringWithFormat:@"%@%%", user.percentLost];

    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_friends count];
}

#pragma mark - UITableViewDelegate protocol methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFUser *user = _friends[indexPath.row];
    FFUserDetailViewController *detailViewController = [[FFUserDetailViewController alloc] init];
    detailViewController.user = user;
    [self.navigationController pushViewController:detailViewController animated:YES];
}

@end
