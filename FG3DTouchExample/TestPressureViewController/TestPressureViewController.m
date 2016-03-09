//
//  TestPressureViewController.m
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 09/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import "TestPressureViewController.h"

@interface TestPressureViewController ()
@end

@implementation TestPressureViewController

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

#pragma mark - 3D Touch Handler

- (BOOL)is3DTouchAvailable {
    
    BOOL isAvailable = NO;
    
    if ([self.traitCollection respondsToSelector:@selector(forceTouchCapability)]) {
        
        isAvailable = (self.traitCollection.forceTouchCapability == UIForceTouchCapabilityAvailable);
    }
    
    return isAvailable;
}

#pragma mark - UITraitEnvironment Protocol

- (void)traitCollectionDidChange:(UITraitCollection *)previousTraitCollection {
    
    [super traitCollectionDidChange:previousTraitCollection];
    
    if (![self is3DTouchAvailable]) {
        
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Atention!" message:@"3D Touch not available" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction *ok = [UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            [alert dismissViewControllerAnimated:YES completion:nil];
        }];
        
        [alert addAction:ok];
        
        [self presentViewController:alert animated:YES completion:nil];
    }
}

#pragma mark - Touch

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches];
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self handleTouches:touches];
}

- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
   [self labelTextWithFloat:0.];
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self labelTextWithFloat:0.];
}

- (void)handleTouches:(NSSet<UITouch *> *)touches{
    
    if ([self is3DTouchAvailable]) {
        
        UITouch *touch = [touches.allObjects objectAtIndex:0];
        
        CGFloat force = touch.force;
        CGFloat percentage = force/touch.maximumPossibleForce;
        [self labelTextWithFloat:percentage];
    }
}

- (void)labelTextWithFloat:(CGFloat)floatNumber {
    
    [self.label setText:[NSString stringWithFormat:@"%f %%", floatNumber]];
}

#pragma mark - Initial Setup

- (void)initialSetup {
    
    [self setTitle:@"Pressure Gradient"];
    
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    [self labelTextWithFloat:0.];
}

#pragma mark - Lazzy Init

- (UILabel *)label {
    
    if (!_label) {
        
        _label = [UILabel new];
        [_label setTranslatesAutoresizingMaskIntoConstraints:NO];
        [_label setNumberOfLines:0];
        [_label setTextAlignment:NSTextAlignmentCenter];
        [_label setFont:[UIFont systemFontOfSize:50.]];
        [self.view addSubview:_label];
        
        NSString *keyLabel = @"label";
        NSDictionary *dictViews = @{keyLabel:_label};
        
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"H:|-0-[%@]-0-|", keyLabel] options:0 metrics:nil views:dictViews]];
        [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:[NSString stringWithFormat:@"V:|-0-[%@]-0-|", keyLabel] options:0 metrics:nil views:dictViews]];
    }
    
    return _label;
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
