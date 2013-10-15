//
//  AJKViewController.m
//  Calc3
//
//  Created by Alex John on 10/7/13.
//  Copyright (c) 2013 Self. All rights reserved.
//

#import "AJKViewController.h"

typedef NS_ENUM(NSInteger, Operation)
{
    NOOP,
    ADDITION,
    SUBTRACTION,
    MULTIPLICATION,
    DIVISION
};

@interface AJKViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
@property NSDecimalNumber *result;  // review weak/strong/copy attributes
@property NSDecimalNumber *argument;
@property Operation op;

@end

@implementation AJKViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    // i don't think this is a great place for this?
    self.result = [NSDecimalNumber zero];
    self.argument = [NSDecimalNumber zero];
    self.op = NOOP;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)clear
{
    self.displayLabel.text = @"0";
    self.argument = [NSDecimalNumber zero];
}

- (IBAction)allClear
{
    [self clear];
    self.result = [NSDecimalNumber zero];
    self.op = NOOP;
}

- (IBAction)digitPressed:(id)sender
{
    NSDecimalNumber *digit = [NSDecimalNumber decimalNumberWithMantissa:[sender tag]
                                                               exponent:0
                                                             isNegative:NO];

    self.argument = [self.argument decimalNumberByMultiplyingByPowerOf10:1];
    self.argument = [self.argument decimalNumberByAdding:digit];
    
    self.displayLabel.text = [self.argument stringValue];
}

- (IBAction)operationPressed:(id)sender
{
    switch (self.op) {
        case NOOP:
            if (![self.argument isEqualToNumber:[NSDecimalNumber zero]]) {
                self.result = [self.argument decimalNumberByAdding:[NSDecimalNumber zero]];
            }
            break;
        case ADDITION:
            self.result = [self.result decimalNumberByAdding:self.argument];
            break;
        case SUBTRACTION:
            self.result = [self.result decimalNumberBySubtracting:self.argument];
            break;
        case MULTIPLICATION:
            self.result = [self.result decimalNumberByMultiplyingBy:self.argument];
            break;
        case DIVISION:
            self.result = [self.result decimalNumberByDividingBy:self.argument];
            break;
    }
    
    self.argument = [NSDecimalNumber zero];
    self.displayLabel.text = [self.result stringValue];
    self.op = [sender tag];
}

@end
