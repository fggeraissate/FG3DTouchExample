//
//  ChooseViewController.m
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 07/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import "ChooseViewController.h"

#import "PeekAndPopViewController.h"
#import "TestPressureViewController.h"

@interface ChooseViewController ()
@property (nonatomic, strong) UIButton *buttonPeekAndPop;
@property (nonatomic, strong) UIButton *buttonTestPressure;
@end

@implementation ChooseViewController

#pragma mark - Lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initialSetup];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void)buttonPeekAndPopAction:(id)sender {
    
    [self.navigationController pushViewController:[PeekAndPopViewController new] animated:YES];
}

- (void)buttonTestPressureAction:(id)sender {
    
    [self.navigationController pushViewController:[TestPressureViewController new] animated:YES];
}

#pragma mark - Initial Setup

- (void)initialSetup {
    
    [self setTitle:@"Menu"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubviews];
}

- (void)addSubviews {
    
    [self.view addSubview:self.buttonPeekAndPop];
    [self.view addSubview:self.buttonTestPressure];
    
    NSString *k_buttonPeekAndPop = @"buttonPeekAndPop";
    NSString *k_buttonTestPressure = @"buttonTestPressure";
    NSDictionary *dictView = @{k_buttonPeekAndPop: self.buttonPeekAndPop,
                               k_buttonTestPressure: self.buttonTestPressure};
    
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", k_buttonPeekAndPop] options:0 metrics:nil views:dictView]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", k_buttonTestPressure] options:0 metrics:nil views:dictView]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-[%@(==%@)]-0-|", k_buttonPeekAndPop, k_buttonTestPressure, k_buttonPeekAndPop] options:0 metrics:nil views:dictView]];
}

#pragma mark - Lazzy Init

- (UIButton *)buttonPeekAndPop {
    
    if (!_buttonPeekAndPop) {
        
        _buttonPeekAndPop = [self buttonWithTitle:@"Peek and Pop" selector:@selector(buttonPeekAndPopAction:)];
        [_buttonPeekAndPop setBackgroundColor:[UIColor grayColor]];
    }
    
    return _buttonPeekAndPop;
}

- (UIButton *)buttonTestPressure {
    
    if (!_buttonTestPressure) {
        
        _buttonTestPressure = [self buttonWithTitle:@"Test Pressure" selector:@selector(buttonTestPressureAction:)];
        [_buttonTestPressure setBackgroundColor:[UIColor lightGrayColor]];
    }
    
    return _buttonTestPressure;
}

#pragma mark - Handler

- (UIButton *)buttonWithTitle:(NSString *)title selector:(SEL)selector {
    
    UIButton *button = [UIButton new];
    [button setTranslatesAutoresizingMaskIntoConstraints:NO];
    [button addTarget:self action:selector forControlEvents:UIControlEventTouchUpInside];
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont boldSystemFontOfSize:30.]];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    return button;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
