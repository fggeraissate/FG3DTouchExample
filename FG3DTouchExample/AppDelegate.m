//
//  AppDelegate.m
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 03/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import "AppDelegate.h"

#import "PreviewViewController.h"
#import "ChooseViewController.h"
#import "PeekAndPopViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) UIApplicationShortcutItem *shortcutItemLaunched;

@property (nonatomic, strong) NSDictionary *dictVc;
@property (nonatomic, strong) UINavigationController *navVc;
@end

@implementation AppDelegate

#pragma mark - AppDelegate Methods

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // 1) Setting rootViewController
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window setRootViewController:self.navVc];
    [self.window makeKeyAndVisible];
    
    // 2) Create a dynamic shortcut
    
    [self createDynamicShortcut];
    
    // 3) Check if a shortcut was launched. If it does, this will block "performActionForShortcutItem:completionHandler" from being called.
    
    BOOL shouldPerformAdditionalDelegateHandling = ![self checkIfAShortcutWasLaunched:launchOptions];

    return shouldPerformAdditionalDelegateHandling;
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    
    if (self.shortcutItemLaunched != nil) {
        
        [self lauchVcWithShortcutItem:self.shortcutItemLaunched];
        self.shortcutItemLaunched = nil;
    }
}

/*
 Called when the user activates your application by selecting a shortcut on the home screen, except when
 application(_:,willFinishLaunchingWithOptions:) or application(_:didFinishLaunchingWithOptions) returns `false`.
 You should handle the shortcut in those callbacks and return `false` if possible. In that case, this
 callback is used if your application is already launched in the background.
 */

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler {
    
    BOOL handledShortCutItem = [self lauchVcWithShortcutItem:shortcutItem];
    
    completionHandler(handledShortCutItem);
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Lazzy Init

- (NSDictionary *)dictVc {
    
    if (!_dictVc) {
        
        PreviewViewController *vcPreview1 = [PreviewViewController new];
        [vcPreview1.label setText:@"Preview ViewController 1"];
        
        PreviewViewController *vcPreview2 = [PreviewViewController new];
        [vcPreview2.label setText:@"Preview ViewController 2"];
        
        PreviewViewController *vcPreview3 = [PreviewViewController new];
        [vcPreview3.label setText:@"Preview ViewController 3"];
        
        PreviewViewController *vcPreview4 = [PreviewViewController new];
        [vcPreview4.label setText:@"Preview ViewController 4"];
        
        _dictVc = @{@"type1": vcPreview1,
                    @"type2": vcPreview2,
                    @"type3": vcPreview3,
                    @"type4": vcPreview4};
    }
    
    return _dictVc;
}

- (UINavigationController *)navVc {
    
    if (!_navVc) {
        _navVc = [[UINavigationController alloc] initWithRootViewController:[ChooseViewController new]];
    }
    
    return _navVc;
}

#pragma mark - View Controller

- (BOOL)lauchVcWithShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    
    if (shortcutItem.type == nil) {
        return NO;
    }
    
    UIViewController *vcLaunched = [self viewControllerToBeLauched:shortcutItem];
    
    if (vcLaunched == nil) {
        return NO;
    }
    
    [self.navVc popToRootViewControllerAnimated:NO];
    [self.navVc pushViewController:[PeekAndPopViewController new] animated:NO];
    [self.navVc pushViewController:vcLaunched animated:NO];

    return YES;
}

- (UIViewController *)viewControllerToBeLauched:(UIApplicationShortcutItem *)shortcutItem {
    
    UIViewController *vcLaunched;
    
    if (shortcutItem) {
        NSLog(@"We've launched from shortcut item: %@", shortcutItem.localizedTitle);
        vcLaunched = [self.dictVc objectForKey:shortcutItem.type];
        
    } else {
        NSLog(@"We've launched properly.");
    }
    
    return vcLaunched;
}

#pragma mark - Check If a Shortcut Was Launched

- (BOOL)checkIfAShortcutWasLaunched:(NSDictionary *)launchOptions {
    
    BOOL aShortcutWasLaunched = NO;
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    
    // If a shortcut was launched, display its information and take the appropriate action
    if (shortcutItem != nil) {
        
        self.shortcutItemLaunched = shortcutItem;
        
        aShortcutWasLaunched = YES;
    }
    
    return aShortcutWasLaunched;
}

#pragma mark - Dynamic Shortcut Items

- (void)createDynamicShortcut {
    
    NSArray *shortcutItems = [UIApplication sharedApplication].shortcutItems;
    
    // Install initial versions of our extra dynamic shortcuts.
    if (shortcutItems == nil || shortcutItems.count == 0) {
        
        // Update the application providing the initial 'dynamic' shortcut items.
        [[UIApplication sharedApplication] setShortcutItems:[self arrayOfDynamicShortcutItems]];
    }
}

- (NSArray *)arrayOfDynamicShortcutItems {
    
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon3"];

    UIApplicationShortcutItem *shortcutItem1 = [[UIApplicationShortcutItem alloc]
                                                initWithType:@"type1"
                                                localizedTitle:@"Dynamic Title 1"];
    
    UIMutableApplicationShortcutItem *shortcutItem2 = [[UIMutableApplicationShortcutItem alloc]
                                               initWithType:@"type2"
                                               localizedTitle:@"Dynamic Title 2"
                                               localizedSubtitle:@"Dynamic Subtitle 2"
                                               icon:icon2
                                               userInfo:nil];
    
    UIMutableApplicationShortcutItem *shortcutItem3 = [[UIMutableApplicationShortcutItem alloc]
                                               initWithType:@"type3"
                                               localizedTitle:@"Dynamic Title 3"
                                               localizedSubtitle:@"Dynamic Subtitle 3"
                                               icon:icon3
                                               userInfo:nil];
    
    NSArray *array = @[shortcutItem1, shortcutItem2, shortcutItem3];
    
    return array;
}

@end
