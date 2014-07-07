//
//  DetailViewController.m
//  showpage
//
//  Created by 余 成海 on 13-7-26.
//  Copyright (c) 2013年 余 成海. All rights reserved.
//

#import "DetailViewController.h"
#import "EditViewController.h"
#import "AppDelegate.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    UIImage* backImage = [UIImage imageNamed:@"back@2x.png"];
    UIButton* backButton= [[UIButton alloc] initWithFrame:CGRectMake(0,0,50,40)];
    [backButton setBackgroundImage:backImage forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(doClickBackAction:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    
    AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    self.delegate = appDelegate.sharDelegate;
    
    UIColor *bgColor = [UIColor colorWithPatternImage: [UIImage imageNamed:@"toolline@2x.png"]];
    [self.toolView setBackgroundColor:bgColor];
    
    self.isLoadToFile = YES;
}

- (void)doClickBackAction:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void) loadWebWithString: (NSString*) url id:(NSString*)id
{
    NSURL *nurl = [[NSURL alloc] initWithString:url];
    [self loadWebWithURL:nurl id:id];
}

- (void) loadWebWithURL: (NSURL*) url id:(NSString*)id
{
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    [self.webView loadRequest:request];
    self.articleID = id;
}

- (BOOL) loadWebWithFileHtml: (NSString*)filename
{
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"%@/%@.html", @SAVEDIR, filename]];
    
    if ([fileManager fileExistsAtPath:path])
    {
        NSURL *url = [NSURL fileURLWithPath:path];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
        self.isLoadToFile = NO;
        return YES;
    }
    return NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)shareButtonClick:(id)sender {
    UIActionSheet* mySheet = [[UIActionSheet alloc]
                              initWithTitle:@""
                              delegate:self
                              cancelButtonTitle:@"Cancel"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"分享到新浪微博",
                              @"分享到微信好友",
                              @"分享到微信朋友圈",
                              @"分享到QQ好友",nil];
    [mySheet showInView:self.view];
}

- (IBAction)editButtonClick:(id)sender {
    EditViewController *editViewContrller = [[EditViewController alloc]initWithNibName:@"EditViewController" bundle:nil];
    
    [self.navigationController pushViewController:editViewContrller animated:YES];
}

- (void) saveHtmlToFile:(NSString*)filename;
{
    //获取html
    NSString *lJs = @"document.documentElement.innerHTML";
    NSString *lHtml = [self.webView stringByEvaluatingJavaScriptFromString:lJs];
    
    //NSLog(@"%@",lHtml);
    
    //创建文件管理器
    NSFileManager *fileManager = [NSFileManager defaultManager];
    
    //获取document路径,括号中属性为当前应用程序独享
    NSArray *directoryPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,      NSUserDomainMask, YES);
    NSString *documentDirectory = [directoryPaths objectAtIndex:0];
    
    //查找文件夹，如果不存在，就创建一个文件夹
    NSString *dir = [documentDirectory stringByAppendingPathComponent:@SAVEDIR];
    if(![fileManager fileExistsAtPath:dir])
    {

        if(![fileManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil])
        {
            NSLog(@"create dir:(%@) error", dir);
            return;
        }
    }
    
    //定义记录文件全名以及路径的字符串filePath
    NSString *filePath = [dir stringByAppendingPathComponent:[[NSString alloc]initWithFormat:@"/%@", filename]];

    //查找文件，如果不存在，就创建一个文件
    NSData *data = [lHtml dataUsingEncoding:NSUTF8StringEncoding];
    if (![fileManager fileExistsAtPath:filePath]) {
        
        if(![fileManager createFileAtPath:filePath contents:data attributes:nil])
        {
            NSLog(@"创建文件:(%@) 失败", filePath);
            return;
        }
        else{
            NSLog(@"写入文件:%@ 成功", filePath);
        }
    }
    //如果文件存在
    else
    {
        if([data writeToFile:filePath atomically:YES])
        {
            NSLog(@"重写文件：%@ 成功", filePath);
        }
        else
        {
            NSLog(@"重写文件：%@ 失败", filePath);
        }
    }
}

#pragma mark - webview delegate
- (void)webViewDidStartLoad:(UIWebView *)webView {
}
- (void)webViewDidFinishLoad:(UIWebView *)webView {

    if(self.isLoadToFile)
    {
        [self saveHtmlToFile:[self.articleID stringByAppendingString:@".html"]];
        NSLog(@"完成加载");
    }
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    NSLog(@"load page error:%@", [error description]);
}

#pragma mark - actionsheet delegate

- (void)actionSheetCancel:(UIActionSheet *)actionSheet{
    //
}
- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    //分享到新浪微博
    if(buttonIndex ==0)
    {
        [_delegate sendMsgToXLWB:@"大家来看啊，这是一个分享到微信好友的程序，真是非常非常犀利的啊，我是非常喜欢，不知道你们怎么想"
                           title:@"大家一起来看啊"
                       imagename:@"share"
                       imagetype:@"png"
                          weburl:@"http://baidu.com"];
    }
    //分享到微信好友:WXSceneSession，
    if(buttonIndex == 1)
    {
        [_delegate sendMsgToWXSession:@"大家来看啊，这是一个分享到微信好友的程序，真是非常非常犀利的啊，我是非常喜欢，不知道你们怎么想"
                                title:@"大家一起来看啊"
                                image:[UIImage imageNamed:@"share.png"]
                               weburl:@"http://baidu.com"];
    }
    //分享到微信朋友圈:WXSceneTimeline，
    if(buttonIndex == 2)
    {
        [_delegate sendMsgToWXTimeLine:@"大家来看啊，这是一个分享到微信好友的程序，真是非常非常犀利的啊，我是非常喜欢，不知道你们怎么想"
                                 title:@"大家一起来看啊"
                                 image:[UIImage imageNamed:@"share.png"]
                                weburl:@"http://baidu.com"];
    }
    if(buttonIndex == 3)
    {
        [_delegate sendMsgToQQ:@"大家来看啊，这是一个分享到微信好友的程序，真是非常非常犀利的啊，我是非常喜欢，不知道你们怎么想"
                                 title:@"大家一起来看啊"
                             imagename:@"share"
                             imagetype:@"png"
                                weburl:@"http://baidu.com"];
    }
}
-(void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex{
    //
}
-(void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex{
    //
}

@end
