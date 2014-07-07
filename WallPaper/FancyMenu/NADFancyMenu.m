//
//  NADFancyMenu.m
//  WallPaper
//
//  Created by 余成海 on 13-8-30.
//  Copyright (c) 2013年 余成海. All rights reserved.
//
#define _is4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define PHOTOWIDTH  320
#define PHOTOHEIGHT (_is4Inch ? 568 : 480)
#define DELAYTIME   0.2
#define TAG      282
#define DISTANCE 65

#import "NADFancyMenu.h"

@implementation NADFancyMenu

#pragma -mark FancyMenu init
- (id) init
{
    self = [super init];
    if (self) {

        self.fancybuttons = [[NSMutableArray alloc] init];

        self.isShowing = NO;
        self.isShowButton = NO;
    }
    return self;
}

- (void)initButtons{
    
    NSArray *buttonImages = @[[UIImage imageNamed:@"wallpaper_menu_down.png"],[UIImage imageNamed:@"wallpaper_menu_back.png"],[UIImage imageNamed:@"wallpaper_menu_share.png"],[UIImage imageNamed:@"wallpaper_menu_preview.png"]];
    
    self.buttonCount = 0;
    CGFloat degree = 360.f/buttonImages.count;
    
    self.buttonSize = CGSizeMake(((UIImage *)[buttonImages lastObject]).size.height * 2, ((UIImage *)[buttonImages lastObject]).size.height * 2);
    
    for (UIImage *image in buttonImages){
        
        NADFancyButton *fancyButton = [[NADFancyButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - image.size.width/2, 0, image.size.width, image.size.height)];

        //FAFancyButton *fancyButton = [[FAFancyButton alloc] initWithFrame:CGRectMake(self.frame.size.width/2 - image.size.width/2, 0, image.size.width, image.size.height)];

        [fancyButton setBackgroundImage:image forState:UIControlStateNormal];
        fancyButton.degree = self.buttonCount*degree;
        fancyButton.hidden = YES;
        fancyButton.tag = self.buttonCount + TAG;
        fancyButton.backgroundColor = [UIColor clearColor];
        [fancyButton addTarget:self action:@selector(buttonPressed:) forControlEvents:UIControlEventTouchUpInside];
        [self.delegate addview:fancyButton];
        
        [self.fancybuttons addObject:fancyButton];
        self.buttonCount++;
        
    }
    
}

- (void)hideButtons{
    for (FAFancyButton *button in self.fancybuttons){
        [button hide];
    }
    self.isShowButton = NO;
    [self performSelector:@selector(didFinishHide) withObject:nil afterDelay:DELAYTIME];
}

- (void)didFinishHide{
    @synchronized(self) {
        
        for (FAFancyButton *button in self.fancybuttons){
            if(![button isHidden])
            {
                [self performSelector:@selector(didFinishHide) withObject:nil afterDelay:DELAYTIME];
                return;
            }
        }
        self.isShowing = NO;
    }
}

- (void)didFinishShow{
    @synchronized(self) {
        for (FAFancyButton *button in self.fancybuttons){
            if([button isHidden])
            {
                [self performSelector:@selector(didFinishShow) withObject:nil afterDelay:DELAYTIME];
                return;
            }
        }
        self.isShowing = NO;
    }
}

- (void)showButtons{
    self.isShowButton = YES;
    
    for (FAFancyButton *button in self.fancybuttons){
        [button show];
    }
    [self performSelector:@selector(didFinishShow) withObject:nil afterDelay:DELAYTIME];
}

#pragma -mark FancyMenu delegate
- (void)buttonPressed:(FAFancyButton *)button
{
    if (self.isShowing) {
        NSLog(@"this is showing,do nothing");
        return;
    }
    
    [self performSelector:@selector(hideButtons) withObject:nil afterDelay:0];
    
    int indexButton = button.tag - TAG;

    [self.delegate buttonPressed:indexButton];

}
- (void)touchtap:(UITapGestureRecognizer *)sender {
    if (self.isShowing) {
        NSLog(@"this is showing,do nothing");
        return;
    }
    if (self.isShowButton)
    {
        self.isShowing = YES;
        [self hideButtons];
    }
    else
    {
        self.isShowing = YES;
        UIView *superView = [sender view];
        CGPoint pressedPoint = [sender locationInView:superView];

        CGPoint newCenter = pressedPoint;
        if ((pressedPoint.x - self.buttonSize.width/2) < 0){
            newCenter.x = self.buttonSize.width/2;
        }
        if ((pressedPoint.x + self.buttonSize.width/2) > PHOTOWIDTH){
            newCenter.x = PHOTOWIDTH - self.buttonSize.width/2;
        }
        if ((pressedPoint.y - self.buttonSize.height/2) <0){
            newCenter.y = self.buttonSize.height/2;
        }
        if ((pressedPoint.y + self.buttonSize.height/2) > PHOTOHEIGHT){

            newCenter.y = PHOTOHEIGHT - self.buttonSize.height/2;
        }
        newCenter.x = newCenter.x - self.buttonSize.width/4;
        newCenter.y = newCenter.y - self.buttonSize.height/4;

        for (FAFancyButton *button in self.fancybuttons){
            [button setFrame:CGRectMake(newCenter.x, newCenter.y, self.buttonSize.width/2, self.buttonSize.height/2)];
        }
        [self showButtons];
    }
}

@end
