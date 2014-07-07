//
//  HYViewController.m
//  FaceBoard
//
//  Created by 邱扬 on 14-4-8.
//  Copyright (c) 2014年 邱扬. All rights reserved.
//

#import "HYViewController.h"

@interface HYViewController ()

@end

@implementation HYViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        _faceBoard = [[HYFaceView alloc] init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Do any additional setup after loading the view from its nib.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyBoardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 键盘处理
#pragma mark 键盘即将显示
- (void)keyBoardWillShow:(NSNotification *)note{
    
    CGRect rect = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    CGFloat ty = - rect.size.height;
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        //如果修改主view，那么home返回后会回弹。  此时只需要修改两个子view就可以解决问题，但是坐标数据难设置。
        //不修改主view坐标，就需要修改两个子view。  但是是自动获得数据。
        self.view.transform = CGAffineTransformMakeTranslation(0, ty);
    }];
    
}
#pragma mark 键盘即将退出
- (void)keyBoardWillHide:(NSNotification *)note{
    
    [UIView animateWithDuration:[note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue] animations:^{
        self.view.transform = CGAffineTransformIdentity;
        self.bottomView.transform = CGAffineTransformIdentity;
    }];
}

#pragma mark 手势响应
//单击识别
- (void)handleSingleTap:(UITapGestureRecognizer *)gestureRecognizer {
    [self.view endEditing:YES];
    _messageText.inputView = nil;
}

- (IBAction)faceBtn:(id)sender {
    _faceBoard.delegate = self;
    [_messageText resignFirstResponder];
    _messageText.inputView = _faceBoard;
    [_messageText becomeFirstResponder];
}

#pragma mark  委托
- (void)selectedFace:(NSString *)str {
    NSString *currentStr;
    if ([str isEqualToString:@"发送"]) {
        ;
    } else if ([str isEqualToString:@"删除"]) {
        if (_messageText.text.length > 0) {
            //这里要判断length>1  否则会导致崩溃
            if (_messageText.text.length > 1 && [[Emoji allEmoji] containsObject:[_messageText.text substringFromIndex:_messageText.text.length - 2]]) {
                //表情
                currentStr = [_messageText.text substringToIndex:_messageText.text.length - 2];
            } else {
                //文字
                currentStr = [_messageText.text substringToIndex:_messageText.text.length - 1];
            }
        }
    } else {
        currentStr = [NSString stringWithFormat:@"%@%@", _messageText.text, str];
    }
    _messageText.text = currentStr;
}

@end
