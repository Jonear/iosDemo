//
//  NADFancyButton.m
//  WallPaper
//
//  Created by 余成海 on 13-9-2.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "NADFancyButton.h"
#import <QuartzCore/QuartzCore.h>

#define DISTANCE 65
#define TAG      282

@implementation NADFancyButton

@synthesize state = _state;
@synthesize degree = _degree;

- (id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self){
        self.layer.anchorPoint = CGPointMake(0.5,1.f);
        self.layer.position = CGPointMake(frame.size.width/2 + frame.origin.x, frame.size.height);
    }
    return self;
}

- (void)show{
    
    [self.layer addAnimation:[self fadeInAnimation] forKey:@"NADFancyButtonFadeIn"];
    
    [self buttonMove:DISTANCE key:@"NADFancyButtonMoveIn"];

}

- (void)hide{
    
    
    [self.layer addAnimation:[self fadeOutAnimation] forKey:@"NADFancyButtonFadeOut"];
    
    [self buttonMove:-DISTANCE key:@"NADFancyButtonMoveOut"];

}

- (void) buttonMove:(int)distance key:(NSString*)keystr
{
    int index = self.tag - TAG;
    if (index == 0)
    {
        [self.layer addAnimation:[self movetox:distance] forKey:keystr];
    }
    else if (index == 1) {
        [self.layer addAnimation:[self movetox:-distance] forKey:keystr];
    }
    else if (index == 2)
    {
        [self.layer addAnimation:[self movetoy:distance] forKey:keystr];
    }
    else if (index == 3)
    {
        [self.layer addAnimation:[self movetoy:-distance] forKey:keystr];
    }
    
}
- (void)animationDidStart:(CAAnimation *)anim{
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    if ([animation.keyPath isEqualToString:@"transform.scale"]){
        switch (self.state) {
            case NADFancyButtonFadeIn:
                self.hidden = NO;
                break;
            case NADFancyButtonFadeOut:
                
                break;
            default:
                break;
        }
    }
}
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    CABasicAnimation *animation = (CABasicAnimation *)anim;
    if ([animation.keyPath isEqualToString:@"transform.scale"] && flag){
        switch (self.state) {
            case NADFancyButtonFadeIn:

                break;
            case NADFancyButtonFadeOut:
                self.hidden = YES;
                break;
            default:
                break;
        }
    }
    if ([animation.keyPath isEqualToString:@"transform.translation.x"] && flag){
        if (self.tag == 282)
        {
            [self setFrame:CGRectMake(self.frame.origin.x+DISTANCE, self.frame.origin.y, self.frame.size.width, self.frame.size.width)];
        }
        else if (self.tag == 283) {
            [self setFrame:CGRectMake(self.frame.origin.x-DISTANCE, self.frame.origin.y, self.frame.size.width, self.frame.size.width)];
        }

        if (self.state == NADFancyButtonFadeOut) {
            self.hidden = YES;
        }
    }
    if ([animation.keyPath isEqualToString:@"transform.translation.y"] && flag){
        if (self.tag == 284)
        {
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y+DISTANCE, self.frame.size.width, self.frame.size.width)];
        }
        else if (self.tag == 285)
        {
            [self setFrame:CGRectMake(self.frame.origin.x, self.frame.origin.y-DISTANCE, self.frame.size.width, self.frame.size.width)];
        }
        if (self.state == NADFancyButtonFadeOut) {
            self.hidden = YES;
        }
    }
}

- (CABasicAnimation *)fadeInAnimation{
    self.state = NADFancyButtonFadeIn;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:0.01];
    scaleAnimation.toValue = [NSNumber numberWithFloat:1];
    scaleAnimation.duration = 0.2f;
    scaleAnimation.delegate = self;
    return scaleAnimation;
}

- (CABasicAnimation *)fadeOutAnimation{
    self.state = NADFancyButtonFadeOut;
    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scaleAnimation.toValue = [NSNumber numberWithFloat:0.01];
    scaleAnimation.fromValue = [NSNumber numberWithFloat:1];
    scaleAnimation.duration = 0.2f;
    scaleAnimation.delegate = self;
    return scaleAnimation;
}

- (CABasicAnimation *)movetox:(CGFloat)x{

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.x"];

    scaleAnimation.toValue = [NSNumber numberWithFloat:x];
    scaleAnimation.duration = 0.15f;
    scaleAnimation.delegate = self;

    scaleAnimation.removedOnCompletion = NO;
    //scaleAnimation.fillMode = kCAFillModeForwards;
    return scaleAnimation;
}

- (CABasicAnimation *)movetoy:(CGFloat)y{

    CABasicAnimation *scaleAnimation = [CABasicAnimation animationWithKeyPath:@"transform.translation.y"];
    
    scaleAnimation.toValue = [NSNumber numberWithFloat:y];
    scaleAnimation.duration = 0.15f;
    scaleAnimation.delegate = self;

    scaleAnimation.removedOnCompletion = NO;
    //scaleAnimation.fillMode = kCAFillModeForwards;
    return scaleAnimation;
    
}



@end
