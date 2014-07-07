//
//  NADFancyMenu.h
//  WallPaper
//
//  Created by 余成海 on 13-8-30.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FAFancyButton.h"
#import "NADFancyButton.h"

@protocol NADFancyMenuDelegate <NSObject>

- (void)buttonPressed:(int)indexbutton;
- (void)addview:(NADFancyButton*)indexbutton;

@end


@interface NADFancyMenu : UIView

@property (strong, nonatomic) NSMutableArray *fancybuttons;

@property (nonatomic) BOOL isShowButton;
@property (nonatomic) BOOL isShowing;
@property (nonatomic) CGSize buttonSize;
@property (nonatomic) float buttonCount;


@property (weak, nonatomic) id<NADFancyMenuDelegate> delegate;

- (void)showButtons;
- (void)initButtons;

- (void)touchtap:(UITapGestureRecognizer *)sender;
@end
