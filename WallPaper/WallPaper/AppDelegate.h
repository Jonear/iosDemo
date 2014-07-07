//
//  AppDelegate.h
//  WallPaper
//
//  Created by 余成海 on 13-8-13.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NADWallPaperViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) NADWallPaperViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
