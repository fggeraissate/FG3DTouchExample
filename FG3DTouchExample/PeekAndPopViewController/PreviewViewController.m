//
//  PreviewViewController.m
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 03/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import "PreviewViewController.h"

@interface PreviewViewController ()

@end

@implementation PreviewViewController

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

- (void)tapGestureAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Preview Actions (Overriding)

- (NSArray<id<UIPreviewActionItem>> *)previewActionItems {

    // setup a list of preview actions
    UIPreviewAction *action1 = [UIPreviewAction actionWithTitle:@"Action 1" style:UIPreviewActionStyleDefault handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Action 1 triggered");
    }];
    
    UIPreviewAction *action2 = [UIPreviewAction actionWithTitle:@"Destructive Action" style:UIPreviewActionStyleDestructive handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Destructive Action triggered");
    }];
    
    UIPreviewAction *action3 = [UIPreviewAction actionWithTitle:@"Selected Action" style:UIPreviewActionStyleSelected handler:^(UIPreviewAction * _Nonnull action, UIViewController * _Nonnull previewViewController) {
        NSLog(@"Selected Action triggered");
    }];
    
    // add them to an arrary
    NSArray *actions = @[action1, action2, action3];

    // and return them
    return actions;
    
    /*
    // add the array in a group
    UIPreviewActionGroup *group1 = [UIPreviewActionGroup actionGroupWithTitle:@"Action Group" style:UIPreviewActionStyleDefault actions:actions];
    NSArray *group = @[group1];
    
    // and return them
    return group;
    */
}

#pragma mark - Initial Setup

- (void)initialSetup {
    
    [self.view setBackgroundColor:[UIColor greenColor]];
    
    [self.label setText:@"Preview ViewController"];
    
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapGestureAction:)];
    [self.view addGestureRecognizer:tapGesture];
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
