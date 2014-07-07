//
//  CustomTableViewCell.m
//  demo
//
//  Created by kyle on 11/18/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import "CustomTableViewCell.h"

@implementation CustomTableViewCell {
    CGFloat webViewHeight;
    UIButton *btn;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UIButton *)createUIButton:(CGRect)rect title:(NSString *)title
{
    UIButton *button = [[UIButton alloc] initWithFrame:rect];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    [button setTitle:title forState:UIControlStateNormal];
    UIImage *image = [UIImage imageNamed:@"comments.png"];
    [button setImage:image forState:UIControlStateNormal];
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0.0, 2.0, 0.0, 0.0)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0)];
    
    button.titleLabel.font = [UIFont systemFontOfSize:10];
    return button;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    CGRect frame = webView.frame;
    frame.size.height = 1;
    webView.frame = frame;
    CGSize fittingSize = [webView sizeThatFits:CGSizeZero];
    frame.size = fittingSize;
    webView.frame = frame;
    
    if (webViewHeight == self.webView.frame.size.height) {
        [btn removeFromSuperview];
        
        btn = [self createUIButton:CGRectMake(30, webViewHeight+65, 22+40, 22) title:@"click"];
        [self addSubview:btn];
        return;
    }
    
    webViewHeight = self.webView.frame.size.height;
    
    [[NSNotificationCenter defaultCenter] postNotificationName:@"freshTableView" object:nil userInfo:@{@"height": [[NSNumber alloc] initWithFloat:webViewHeight + 90], @"index": [[NSNumber alloc] initWithInt:self.index]}];
}


- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    NSLog(@"load html failed.error=%@", error);
}

- (void)updateCell:(NSString *)data index:(NSInteger)index
{
    self.index = index;
    
    //set webview content
    self.webView.delegate = self;
    self.webView.scrollView.scrollEnabled = NO;
    self.webView.scrollView.bounces = NO;
    self.webView.opaque = NO;
    //self.webView.suppressesIncrementalRendering = YES;
    
    NSString *temp_path = [[[NSBundle mainBundle] resourcePath] stringByAppendingFormat:@"/demo.html"];
    NSData *tmp_data = [[NSFileManager defaultManager] contentsAtPath:temp_path];
    NSString *templateContent = [[NSString alloc] initWithData:tmp_data encoding:NSUTF8StringEncoding];
    NSString *html = [templateContent stringByReplacingOccurrencesOfString:@"WEIBO-BODY" withString:data];
    [self.webView loadHTMLString:html baseURL:nil];
}

@end
