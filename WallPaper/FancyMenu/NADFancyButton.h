//
//  NADFancyButton.h
//  WallPaper
//
//  Created by 余成海 on 13-9-2.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum {
    NADFancyButtonFadeIn,
    NADFancyButtonFadeOut
} NADFancyButtonState;

@interface NADFancyButton : UIButton
@property (nonatomic) CGFloat degree;
@property (nonatomic) NADFancyButtonState state;
@property (nonatomic) int indexbutton;
- (void)show;
- (void)hide;

@end
