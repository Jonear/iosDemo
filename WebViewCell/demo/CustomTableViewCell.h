//
//  CustomTableViewCell.h
//  demo
//
//  Created by kyle on 11/18/13.
//  Copyright (c) 2013 kyle. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTableViewCell : UITableViewCell <UIWebViewDelegate>

@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (assign, nonatomic) NSInteger index;

- (void)updateCell:(NSString *)data index:(NSInteger)index;

@end
