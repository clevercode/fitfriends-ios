//
//  FFNewLogViewController.m
//  FitFriends
//
//  Created by Andrew Smith on 2013-06-16.
//  Copyright (c) 2013 cleverCode. All rights reserved.
//

#import "FFNewLogViewController.h"
#import "FFFormView.h"
#import "UIImage+FFTinting.h"
#import "UIBarButtonItem+FFBarButtonItem.h"

@interface FFNewLogViewController ()

@property(nonatomic, strong) FFFormView *waterForm;
@property(nonatomic, strong) FFFormView *foodForm;
@property(nonatomic, strong) FFFormView *weightForm;

@end

@implementation FFNewLogViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Log Something";
        self.navigationItem.leftBarButtonItem =
            [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"cancel"]
                                            target:self
                                            action:@selector(onCancelAction:)];
        self.navigationItem.rightBarButtonItem =
            [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"done"]
                                            target:self
                                            action:@selector(onDoneAction:)];
    }
    return self;
}

- (void)loadView
{
    UIScrollView *view = [[UIScrollView alloc] init];
    view.backgroundColor = [UIColor whiteColor];
    
    UISegmentedControl *typeControl = [[UISegmentedControl alloc] initWithItems:@[@"Water", @"Food", @"Weight"]];
    typeControl.segmentedControlStyle = UISegmentedControlStyleBar;
    typeControl.tintColor = [UIColor whiteColor];
    typeControl.translatesAutoresizingMaskIntoConstraints = NO;
    typeControl.selectedSegmentIndex = 0;
    [typeControl addTarget:self
                    action:@selector(onTypeChangeAction:)
          forControlEvents:UIControlEventValueChanged];

    [view addSubview:typeControl];

    FFFormView *waterForm = [self makeWaterForm];
    self.waterForm = waterForm;
    [view addSubview:waterForm];

    FFFormView *foodForm = [self makeFoodForm];
    foodForm.hidden = YES;
    self.foodForm = foodForm;
    [view addSubview:foodForm];

    FFFormView *weightForm = [self makeWeightForm];
    weightForm.hidden = YES;
    self.weightForm = weightForm;
    [view addSubview:weightForm];


    NSDictionary *views = NSDictionaryOfVariableBindings(typeControl,
                                                         waterForm,
                                                         foodForm,
                                                         weightForm);

    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[typeControl(280)]-|"
                                             options:kNilOptions
                                             metrics:nil
                                               views:views]];

    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[typeControl]-(40)-[foodForm]-|"
                                             options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                             metrics:nil
                                               views:views]];
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[typeControl]-(40)-[weightForm]"
                                             options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                             metrics:nil
                                               views:views]];
    [view addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:[typeControl]-(40)-[waterForm]"
                                             options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                             metrics:nil
                                               views:views]];


    self.view = view;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(onKeyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [[[self formForSegmentIndex:0].fields[0] textField] becomeFirstResponder];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSUInteger)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskPortrait;
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationPortrait;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark -

- (FFFormView *)formForSegmentIndex:(NSUInteger)idx
{
    switch (idx) {
        case 0:
            return _waterForm;
        case 1:
            return _foodForm;
        case 2:
            return _weightForm;
        default:
            return nil;
    }
}

#pragma mark - View Helpers

- (FFFormView *)makeWaterForm
{
    FFFormView *waterForm = [[FFFormView alloc] init];
    waterForm.translatesAutoresizingMaskIntoConstraints = NO;

    FFFormFieldView *waterVolumeField = [[FFFormFieldView alloc] init];
    waterVolumeField.label.text = @"fl oz";
    waterVolumeField.textField.placeholder = @"0.0";
    [waterForm addField:waterVolumeField];
    [waterVolumeField pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];

    return waterForm;
}

- (FFFormView *)makeFoodForm
{
    FFFormView *foodForm = [[FFFormView alloc] init];
    foodForm.translatesAutoresizingMaskIntoConstraints = NO;

    FFFormFieldView *name = [[FFFormFieldView alloc] init];
    name.label.text = @"name";
    name.textField.keyboardType = UIKeyboardTypeASCIICapable;
    [foodForm addField:name];

    FFFormFieldView *fat = [[FFFormFieldView alloc] init];
    fat.label.text = @"fat";
    fat.textField.placeholder = @"0.0";
    [foodForm addField:fat];

    FFFormFieldView *carbs = [[FFFormFieldView alloc] init];
    carbs.label.text = @"carbs";
    carbs.textField.placeholder = @"0.0";
    [foodForm addField:carbs];

    FFFormFieldView *protein = [[FFFormFieldView alloc] init];
    protein.label.text = @"protein";
    protein.textField.placeholder = @"0.0";
    [foodForm addField:protein];

    NSDictionary *views = NSDictionaryOfVariableBindings(name,
                                                         fat,
                                                         carbs,
                                                         protein);

    [foodForm addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[name]-(15)-[fat]-(15)-[carbs]-(15)-[protein]|"
                                             options:NSLayoutFormatAlignAllLeft|NSLayoutFormatAlignAllRight
                                             metrics:nil
                                               views:views]];
    [foodForm addConstraints:
     [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[name]|"
                                             options:kNilOptions
                                             metrics:nil
                                               views:views]];

    return foodForm;
}

- (FFFormView *)makeWeightForm
{
    FFFormView *weightForm = [[FFFormView alloc] init];
    weightForm.translatesAutoresizingMaskIntoConstraints = NO;

    FFFormFieldView *weight = [[FFFormFieldView alloc] init];
    weight.label.text = @"lbs";
    weight.textField.placeholder = @"0.0";
    [weightForm addField:weight];
    [weight pinToSuperviewEdgesWithInset:UIEdgeInsetsZero];

    return weightForm;
}

#pragma mark - Keyboard Notifications

- (void)onKeyboardWillShow:(NSNotification *)notification
{
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentInset = contentInsets;
    scrollView.scrollIndicatorInsets = contentInsets;

    /*
    // If active text field is hidden by keyboard, scroll it so it's visible
    // Your application might not need or want this behavior.
    CGRect aRect = self.view.frame;
    aRect.size.height -= kbSize.height;
    if (!CGRectContainsPoint(aRect, activeField.frame.origin) ) {
        CGPoint scrollPoint = CGPointMake(0.0, activeField.frame.origin.y-kbSize.height);
        [scrollView setContentOffset:scrollPoint animated:YES];
    }
    */
}

- (void)onKeyboardWillHide:(NSNotification *)notification
{
    UIScrollView *scrollView = (UIScrollView *)self.view;
    scrollView.contentInset = UIEdgeInsetsZero;
    scrollView.scrollIndicatorInsets = UIEdgeInsetsZero;
}

#pragma mark - Actions

- (void)onCancelAction:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)onDoneAction:(id)sender
{
}

- (void)onTypeChangeAction:(UISegmentedControl *)sender
{
    _waterForm.hidden = _foodForm.hidden = _weightForm.hidden = YES;

    FFFormView *form = [self formForSegmentIndex:[sender selectedSegmentIndex]];
    form.hidden = NO;
    [[form.fields[0] textField] becomeFirstResponder];

}

@end
