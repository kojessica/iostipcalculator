//
//  TipViewController.m
//  tipcalculator
//
//  Created by Jessica Ko on 2/20/14.
//  Copyright (c) 2014 Jessica Ko. All rights reserved.
//

#import "TipViewController.h"
#import "settingsViewController.h"

@interface TipViewController ()
@property (weak, nonatomic) IBOutlet UITextField *billTextField;
@property (weak, nonatomic) IBOutlet UILabel *tipLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *tipControl;

- (IBAction)onTap:(id)sender;
- (void)updateValues;

@end

@implementation TipViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.title = @"Tip Calculator";
    }
    return self;
}

- (void)viewDidLoad
{
    [label setFont:[UIFont fontWithName:@"ProximaNovaRegular" size:30]];
    [super viewDidLoad];
    //load new default tip
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    int defaultTipValue = [defaults integerForKey:@"defaultTip"];
    self.tipControl.selectedSegmentIndex = defaultTipValue;
    
    [self updateValues];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Settings" style:UIBarButtonItemStylePlain target:self action:@selector(onSettingsButton)];
}

- (void)viewWillAppear:(BOOL)animated {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultTipValue = [defaults integerForKey:@"defaultTip"];
    self.tipControl.selectedSegmentIndex = defaultTipValue;
    [self updateValues];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onTap:(id)sender {
    [self.view endEditing:YES];
    [self updateValues];
}

- (void)updateValues {
    //get the default currency
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    int defaultCurrency = [defaults integerForKey:@"currency"];
    
    float billAmount = [self.billTextField.text floatValue];
    NSArray *tipValues = @[@(0.1), @(0.15), @(0.2)];
    float tipAmount = billAmount * [tipValues[self.tipControl.selectedSegmentIndex] floatValue];
    float totalAmount = tipAmount + billAmount;
    
    if (defaultCurrency == 2) {
        self.tipLabel.text = [NSString stringWithFormat:@"¥%0.2f", tipAmount];
        self.totalLabel.text = [NSString stringWithFormat:@"¥%0.2f", totalAmount];
    } else {
        self.tipLabel.text = [NSString stringWithFormat:@"$%0.2f", tipAmount];
        self.totalLabel.text = [NSString stringWithFormat:@"$%0.2f", totalAmount];
    }
}

- (void)onSettingsButton {
    [self.navigationController pushViewController:[[settingsViewController alloc] init] animated:YES];
}

@end
