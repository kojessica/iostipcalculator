//
//  settingsViewController.m
//  tipcalculator
//
//  Created by Jessica Ko on 2/20/14.
//  Copyright (c) 2014 Jessica Ko. All rights reserved.
//

#import "settingsViewController.h"

@interface settingsViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *defaultTipControl;
@property (weak, nonatomic) IBOutlet UILabel *testoutput;
- (IBAction)onTapSettings:(id)sender;
@end

@implementation settingsViewController
@synthesize currencyPicker;
NSArray *currencyList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    currencyList = [[NSArray alloc] initWithObjects:@"Canadian Dollars", @"US Dollars", @"Japanese Yen", nil];
    [self.currencyPicker selectRow:1 inComponent:0 animated:NO];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultCurrency = [defaults integerForKey:@"currency"];
    [self.currencyPicker selectRow:defaultCurrency inComponent:0 animated:NO];
    
    int defaultTipValue = [defaults integerForKey:@"defaultTip"];
    self.defaultTipControl.selectedSegmentIndex = defaultTipValue;

    //for testing saved index value
    self.testoutput.text = [NSString stringWithFormat:@"%d", defaultTipValue];
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [currencyList count];
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [currencyList objectAtIndex:row];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //self.testoutput.text = [currencyList objectAtIndex:row];
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:row forKey:@"currency"];
    [defaults synchronize];
    
    //for testing new currency value
    self.testoutput.text = [NSString stringWithFormat:@"%d", row];
}

- (IBAction)onTapSettings:(id)sender {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setInteger:self.defaultTipControl.selectedSegmentIndex forKey:@"defaultTip"];
    [defaults synchronize];
    
    //for testing new index value
    self.testoutput.text = [NSString stringWithFormat:@"%d", self.defaultTipControl.selectedSegmentIndex];
}

- (void)viewWillAppear:(BOOL)animated {
    NSLog(@"view will appear");
}

- (void)viewDidAppear:(BOOL)animated {
    NSLog(@"view did appear");
}

- (void)viewWillDisappear:(BOOL)animated {
    NSLog(@"view will disappear");
}

- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"view did disappear");
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
