//
//  PreviewViewController.h
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 03/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PreviewViewControllerDelegate <NSObject>
- (void)previewViewControllerTapToDismiss:(UIViewController *)vc;
@end

@interface PreviewViewController : UIViewController

@property (nonatomic, strong) id<PreviewViewControllerDelegate>delegate;
@property (nonatomic, strong) UILabel *label;

@end
