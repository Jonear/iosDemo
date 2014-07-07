//
//  AppDelegate.h
//  showpage
//
//  Created by 余 成海 on 13-7-26.
//  Copyright (c) 2013年 余 成海. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ShareDelegate.h"

@class ViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@property (strong, nonatomic) UINavigationController *navController;

@property (strong, nonatomic) ShareDelegate *sharDelegate;

@end
