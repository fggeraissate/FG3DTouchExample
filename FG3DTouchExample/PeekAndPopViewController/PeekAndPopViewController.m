//
//  PeekAndPopViewController.m
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 03/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import "PeekAndPopViewController.h"

#import "PreviewViewController.h"
#import "AppDelegate.h"

@interface PeekAndPopViewController () <UIViewControllerPreviewingDelegate>
@property (nonatomic, strong) id previewingContext;
@property (nonatomic, strong) UIViewController *vcPresented;
@end

@implementation PeekAndPopViewController

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
    
    if ([self is3DTouchAvailable]) {
        
        self.previewingContext = [self registerForPreviewingWithDelegate:self sourceView:self.view];
        
    } else if (self.previewingContext) {
        
        [self unregisterForPreviewingWithContext:self.previewingContext];
        self.previewingContext = nil;
    }
}

#pragma mark - UIViewControllerPreviewingDelegate

// Peek...
- (UIViewController *)previewingContext:(id<UIViewControllerPreviewing>)previewingContext
              viewControllerForLocation:(CGPoint)location {
    
    PreviewViewController *vcPreview = [PreviewViewController new];
    
    return vcPreview;
}

// ... and Pop
- (void)previewingContext:(id<UIViewControllerPreviewing>)previewingContext
     commitViewController:(UIViewController *)viewControllerToCommit {
    
    PreviewViewController *vcPreview = (PreviewViewController *)viewControllerToCommit;
    [vcPreview.label setText:@"Preview ViewController"];
    
    self.vcPresented = vcPreview;
    
    [self.navigationController pushViewController:vcPreview animated:YES ];
}

#pragma mark - PreviewViewControllerDelegate

- (void)previewViewControllerTapToDismiss:(UIViewController *)vc {
    
    self.vcPresented = nil;
}

#pragma mark - Initial Setup 

- (void)initialSetup {
    
    [self.view setBackgroundColor:[UIColor redColor]];
    
    [self.label setText:@"Press to Peek and Pop"];
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
