//
//  AppDelegate.m
//  FG3DTouchExample
//
//  Created by Fernanda Geraissate on 03/03/16.
//  Copyright © 2016 Fernanda G. Geraissate. All rights reserved.
//

#import "AppDelegate.h"

#import "PeekAndPopViewController.h"
#import "PreviewViewController.h"

@interface AppDelegate ()
@property (nonatomic, strong) NSDictionary *dictVc;
@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    [self createDynamicShortcut];
    
    UIApplicationShortcutItem *shortcutItem = [launchOptions valueForKey:UIApplicationLaunchOptionsShortcutItemKey];
    UIViewController *vc = [PeekAndPopViewController new];
    [self baseVc:vc lauchVcWithShortcutItem:shortcutItem];
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    [self.window setRootViewController:vc];
    [self.window makeKeyAndVisible];

    return YES;
}

- (void)application:(UIApplication *)application performActionForShortcutItem:(nonnull UIApplicationShortcutItem *)shortcutItem completionHandler:(nonnull void (^)(BOOL))completionHandler {
    
    // react to shortcut item selections
    NSLog(@"A shortcut item was pressed. It was %@.", shortcutItem.localizedTitle);
    
    UIViewController *vc = self.window.rootViewController;
    [self baseVc:vc lauchVcWithShortcutItem:shortcutItem];
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

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Lazzy Init

- (NSDictionary *)dictVc {
    
    if (!_dictVc) {
        
        PreviewViewController *vcPreview1 = [PreviewViewController new];
        [vcPreview1.label setText:@"Preview ViewController 1 \n\n Press to return"];
        
        PreviewViewController *vcPreview2 = [PreviewViewController new];
        [vcPreview2.label setText:@"Preview ViewController 2 \n\n Press to return"];
        
        PreviewViewController *vcPreview3 = [PreviewViewController new];
        [vcPreview3.label setText:@"Preview ViewController 3 \n\n Press to return"];
        
        _dictVc = @{@"type1": vcPreview1,
                    @"type2": vcPreview2,
                    @"type3": vcPreview3};
    }
    
    return _dictVc;
}

#pragma mark - View Controller

- (void)baseVc:(UIViewController *)vcBase lauchVcWithShortcutItem:(UIApplicationShortcutItem *)shortcutItem {
    
    UIViewController *vcLaunched = [self viewControllerToBeLauched:shortcutItem];
    
    if (vcBase!=nil && vcLaunched!=nil) {
        [vcBase showViewController:vcLaunched sender:vcBase];
    }
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

#pragma mark - Dynamic Shortcut Items

- (void)createDynamicShortcut {
    
    NSArray *arrayDynamicShortcutItems = [self arrayOfDynamicShortcutItemsWithIcons];
    //    NSArray *arrayDynamicShortcutItems = [self arrayOfDynamicShortcutItems];
    
    /*
    // Do this in case we have also static shortcut items
    NSArray *existingItems = [UIApplication sharedApplication].shortcutItems;
    NSArray *updatedItems = [existingItems arrayByAddingObjectsFromArray:arrayDynamicShortcutItems];
    */
    
    [[UIApplication sharedApplication] setShortcutItems:arrayDynamicShortcutItems];
}

- (NSArray *)arrayOfDynamicShortcutItems {
    
    UIApplicationShortcutItem *shortcutItem1 = [[UIApplicationShortcutItem alloc]
                                                initWithType:@"type1"
                                                localizedTitle:@"Title 1"];
    
    UIApplicationShortcutItem *shortcutItem2 = [[UIApplicationShortcutItem alloc]
                                                initWithType:@"type2"
                                                localizedTitle:@"Title 2"];
    
    UIApplicationShortcutItem *shortcutItem3 = [[UIApplicationShortcutItem alloc]
                                                initWithType:@"type3"
                                                localizedTitle:@"Title 3"];
    
    NSArray *array = @[shortcutItem1, shortcutItem2, shortcutItem3];
    
    return array;
}

- (NSArray *)arrayOfDynamicShortcutItemsWithIcons {
    
    // System Images
    UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeLove];
    UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeMail];
    UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithType:UIApplicationShortcutIconTypeProhibit];
    
    /* // My own images
     UIApplicationShortcutIcon *icon1 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon1"];
     UIApplicationShortcutIcon *icon2 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon2"];
     UIApplicationShortcutIcon *icon3 = [UIApplicationShortcutIcon iconWithTemplateImageName:@"iCon3"];
     */
    
    UIMutableApplicationShortcutItem *item1 = [[UIMutableApplicationShortcutItem alloc]
                                               initWithType:@"type1"
                                               localizedTitle:@"Title 1"
                                               localizedSubtitle:@"Subtitle 1"
                                               icon:icon1
                                               userInfo:nil];
    
    UIMutableApplicationShortcutItem *item2 = [[UIMutableApplicationShortcutItem alloc]
                                               initWithType:@"type2"
                                               localizedTitle:@"Title 2"
                                               localizedSubtitle:@"Subtitle 2"
                                               icon:icon2
                                               userInfo:nil];
    
    UIMutableApplicationShortcutItem *item3 = [[UIMutableApplicationShortcutItem alloc]
                                               initWithType:@"type3"
                                               localizedTitle:@"Title 3"
                                               localizedSubtitle:@"Subtitle 3"
                                               icon:icon3
                                               userInfo:nil];
    
    NSArray *array = @[item1, item2, item3];
    
    return array;
}

@end
