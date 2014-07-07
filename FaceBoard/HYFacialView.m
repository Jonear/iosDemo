//
//  HYFacialView.m
//  FaceBoard
//
//  Created by 邱扬 on 14-4-8.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import "HYFacialView.h"

@implementation HYFacialView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        _faces=[Emoji allEmoji];
        _currentPage = 0;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

-(void)loadFacialView:(int)page size:(CGSize)size {
    //开始向scrollview中添加表情
    //row
    for (int i = 0; i < HY_FACIAL_ROW; ++i) {
        //column
        for (int j = 0; j < HY_FACIAL_COL; ++j) {
            _faceLabel = [[UILabel alloc] initWithFrame:CGRectMake(j*size.width, i*size.height, size.width, size.height)];
            [_faceLabel setBackgroundColor:[UIColor clearColor]];
            if (HY_FACIAL_ENDROW == i && j >= 4) {
                if (4 == j) {
                    //删除
                    //                UIColor *faceColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"shanchu"]];
                    //                [faceLabel setBackgroundColor:faceColor];
                    _faceLabel.frame = CGRectMake(j*size.width, i*size.height, size.width + size.width/2, size.height);
                    [_faceLabel setText:@"Delete"];
                } else  if (5 == j) {
                    //发送
                    //设置图片
                    // UIColor *faceColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"fasong"]];
                    //                [faceLabel setBackgroundColor:faceColor];
                    _faceLabel.frame = CGRectMake(j*size.width + size.width/2, i*size.height, size.width + size.width/2, size.height);
                    [_faceLabel setText:@"Send"];
                }
            } else {
                //表情
                [_faceLabel setFont:[UIFont fontWithName:@"AppleColorEmoji" size:29.0]];
                //i＊9+j＋（page＊24）是计算 表情坐标
                [_faceLabel setText:[_faces objectAtIndex:i * HY_FACIAL_COL + j + (page * (HY_FACIAL_ALL - 2))]];
            }
            [self addSubview:_faceLabel];
        }
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    //通过本地化获取 当前所在页面
    NSUserDefaults *defPage = [NSUserDefaults standardUserDefaults];
    _currentPage = [defPage integerForKey:@"currentPage"];
    
    UITouch *touch = [touches anyObject];
    CGPoint touchPoint = [touch locationInView:self];
    //touchPoint.x ，touchPoint.y 就是触点的坐标。
    int touchx = touchPoint.x / HY_FACIAL_SIZE_X;
    int touchy = touchPoint.y / HY_FACIAL_SIZE_Y;
    if (touchx >= 4 && HY_FACIAL_ENDROW == touchy) {
        //5.5是在绘制delete和send时，这两个按钮每个占1.5个表情大小
        if (touchPoint.x <= HY_FACIAL_SIZE_X*5.5) {
            NSLog(@"delete");
            [_delegate selectedFacial:@"删除"];
        } else {
            NSLog(@"send");
            [_delegate selectedFacial:@"发送"];
        }
    } else {
        NSString *str = [_faces objectAtIndex:(touchy * HY_FACIAL_COL + touchx + (_currentPage * (HY_FACIAL_ALL - 2)))];
        NSLog(@"%@", str);
        [_delegate selectedFacial:str];
    }
}

@end
