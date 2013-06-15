//
//  FFLeaderboardViewController.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-15.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFLeaderboardViewController.h"
#import "FFUserStatsCell.h"
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
        self.friends = @[@"fullsailor@me.com", @"mail@zdn.me", @"mail@alyssanicoll.com"];
    }
    return self;
}

- (void)loadView
{
    UIView *view = [[UIView alloc] init];

    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    navigationBar.translatesAutoresizingMaskIntoConstraints = NO;
    navigationBar.titleTextAttributes = @{UITextAttributeFont: [UIFont fontWithName:@"Avenir-Black"
                                                                               size:20.f]};
    navigationBar.tintColor = [UIColor colorWithRed:0.8f green:0.067f blue:0.f alpha:1.f];
    [view addSubview:navigationBar];

    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.title = @"Fit Friends";
    navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                                                                      target:self
                                                                                      action:@selector(onAddAction:)];

    navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"calendar"]
                                                                        style:UIBarButtonItemStyleBordered
                                                                       target:self
                                                                       action:@selector(onSelectDateAction:)];

    [navigationBar setItems:@[navigationItem]];
    self.navigationBar = navigationBar;

    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    tableView.translatesAutoresizingMaskIntoConstraints = NO;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.allowsSelection = NO;
    tableView.rowHeight = 90.f;
    [view addSubview:tableView];
    self.tableView = tableView;

    NSDictionary *views = NSDictionaryOfVariableBindings(navigationBar,
                                                         tableView);

    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[navigationBar]|"
                                             options:kNilOptions
                                             metrics:nil
                                               views:views]];
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[navigationBar][tableView]|"
                                             options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                             metrics:nil
                                               views:views]];


    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_tableView registerClass:[FFUserStatsCell class]
       forCellReuseIdentifier:CellIdentifier];
	// Do any additional setup after loading the view.
}

#pragma mark - Actions

- (void)onAddAction:(id)sender
{
    
}

- (void)onSelectDateAction:(id)sender
{
    [ActionSheetDatePicker showPickerWithTitle:@"Select a day"
                                datePickerMode:UIDatePickerModeDate
                                  selectedDate:[NSDate date]
                                        target:self
                                        action:@selector(onPickDate:)
                                        origin:self.view];
}

- (void)onPickDate:(id)sender
{
    
}

#pragma mark - UITableViewDataSource protocol methods

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    FFUserStatsCell *cell = (FFUserStatsCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier
                                                                               forIndexPath:indexPath];
    [cell setAvatarWithEmail:_friends[indexPath.row]];
    cell.water = @"100";
    cell.carbs = @"19";
    cell.weight = @"-4%";

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

@end
