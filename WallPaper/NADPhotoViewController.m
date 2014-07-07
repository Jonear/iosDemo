//
//  PhotoViewController.m
//  WallPaper
//
//  Created by 余成海 on 13-8-14.
//  Copyright (c) 2013年 余成海. All rights reserved.
//
#define _is4Inch ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define PHOTOWIDTH  320
#define PHOTOHEIGHT (_is4Inch ? 568 : 480)
#define DELAYTIME   0.2


#import "NADPhotoViewController.h"
#import "AppDelegate.h"
#import "SDWebImage/UIImageView+WebCache.h"


@interface NADPhotoViewController ()

@end

@implementation NADPhotoViewController


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
    //设置委托
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"photoCell"];
    [self.collectionview setAllowsMultipleSelection:YES];
    [self.collectionview setBackgroundColor:[UIColor whiteColor]];
    
    //设置布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(PHOTOWIDTH, PHOTOHEIGHT)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    //flowLayout.footerReferenceSize = CGSizeMake(300, 100);
    [self.collectionview setCollectionViewLayout:flowLayout];
    
    //初始化应用菜单
    self.fancymenu = [[NADFancyMenu alloc] init];
    [self.view addSubview:self.fancymenu];
    //初始化应用菜单
    self.fancymenu.delegate = self;
    [self.fancymenu initButtons];
    
    //预览视图
    self.preview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, PHOTOWIDTH, PHOTOHEIGHT)];
    [self.preview setImage:[UIImage imageNamed:@"preview.png"]];
    self.preview.tag = 1;
    self.isPreview = NO;
    
    //隐藏系统状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    
    //增加下滑手势
    UISwipeGestureRecognizer *oneFingerSwipeDown = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(oneFingerSwipeDown:)];
    [oneFingerSwipeDown setDirection:UISwipeGestureRecognizerDirectionDown];
    [[self view] addGestureRecognizer:oneFingerSwipeDown];
    
    self.imageLoading = [[NSMutableArray alloc] init];
    self.imageArray = [[NSMutableArray alloc] initWithObjects:
                       @"http://ww4.sinaimg.cn/large/b3986411jw1e1ksdjhxwej.jpg",
                       @"http://img1.duoduotu.com/2012/1224/20121224021731478.jpg",
                       @"http://5.gaosu.com/download/pic/000/326/1aaa2c891d39442ad3e58976144b3016.jpg",
                       @"http://wp2.sina.cn/woriginal/b5db6593tw1e2hjpjgznnj.jpg",
                       @"http://4.img.265g.com/img5/201306/201306171733233429.jpg",
                       @"http://pic.ffpic.com/files/2012/1019/sj1020mao01.jpg",
                       @"http://ww2.sinaimg.cn/large/b3986411jw1e1dr04rfh1j.jpg",
                       @"http://ww1.sinaimg.cn/large/b3986411jw1e1ksh0hrkzj.jpg",
                       @"http://zoldesk.92game.net/upload/sj/409/320x510/1356002759207.jpg",
                       @"http://wp1.sina.cn/woriginal/b5db6593tw1e2hjr11td4j.jpg",
              
                       nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma -mark CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"photoCell";
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    CGRect imageRect=CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:imageRect];
    imageView.tag = 1;
    [cell.contentView addSubview:imageView];
    
    CGRect indicatorRect = CGRectMake(cell.frame.size.width/2-10, cell.frame.size.height/2-10, 20, 20);
    UIActivityIndicatorView *indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:indicatorRect];
    indicatorView.tag = 2;
    [cell.contentView addSubview:indicatorView];
    
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    if([imgView isKindOfClass:[UIImageView class]])
    {
        UIActivityIndicatorView *indView = (UIActivityIndicatorView *)[cell.contentView viewWithTag:2];
        if([indView isKindOfClass:[UIActivityIndicatorView class]])
        {
            [indView startAnimating];
        }
        [imgView setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:indexPath.row]]
                placeholderImage:[UIImage imageNamed:@"Default-568h@2x.png"]
                       completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType) {
            [indView stopAnimating];
        }];
        
    }
    //加载前面两张和后面两张图片
    [self loadAroundImageWithIndex:indexPath.row];

    return cell;
}
- (void) loadAroundImageWithIndex:(int)index
{
    if(index > 0)
    {
        [self downloadImageFromURLString:[self.imageArray objectAtIndex:index-1]];
    }
    if(index > 1)
    {
        [self downloadImageFromURLString:[self.imageArray objectAtIndex:index-2]];
    }
    if(index < self.imageArray.count-1)
    {
        [self downloadImageFromURLString:[self.imageArray objectAtIndex:index+1]];
    }
    if(index < self.imageArray.count-2)
    {
        [self downloadImageFromURLString:[self.imageArray objectAtIndex:index+2]];
    }
}

- (BOOL)isImageCached:(NSString *)urlString {
    UIImage *image = [[SDImageCache sharedImageCache] imageFromMemoryCacheForKey:urlString];
    if(image == nil) image = [[SDImageCache sharedImageCache] imageFromDiskCacheForKey:urlString];
    return image != nil;
}
- (BOOL)isImageLoading:(NSString*)urlstring{
    if ([self.imageLoading indexOfObject:urlstring] == NSNotFound) {
        return NO; 
    }
    return YES;
}
- (void)downloadImageFromURLString:(NSString *)urlString {
    //判断图片是否已经有缓存
    if ([self isImageCached:urlString]) {
        return;
    }
    //判断图片是否已在加载中
    if ([self isImageLoading:urlString]) {
        //NSLog(@"this image is loading");
        return;
    }
    else
    {
        [self.imageLoading addObject:urlString];
    }

    SDWebImageManager *manager = [SDWebImageManager sharedManager];
    NSURL *imageURL = [NSURL URLWithString:urlString];

    [manager downloadWithURL:imageURL
                     options:0
                    progress:^(NSUInteger receivedSize, long long expectedSize)
     {
         // progression tracking code
     }
                   completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, BOOL finished)
     {
         if (image)
         {
             NSLog(@"download image ok:%@", urlString);
             [self.imageLoading removeObject:urlString];
         }
     }];
}

#pragma -mark FancyMenu delegate
- (void)buttonPressed:(int)indexButton
{
    NSLog(@"%i", indexButton);
    //预览
    if (indexButton == 3) {
        [self.view addSubview:self.preview];
        self.isPreview = YES;
    }
    //分享
    else if (indexButton == 2) {
        
    }
    //保存图片
    else if (indexButton == 0)
    {
        [self savePhoto];
    }
    //退出
    else if (indexButton == 1)
    {
        [self closeView];
    }
}

- (void)addview:(NADFancyButton*)indexbutton
{
    [self.view addSubview:indexbutton];
}
- (IBAction)touchtap:(UITapGestureRecognizer *)sender {

    if (self.isPreview)
    {
        [self.preview removeFromSuperview];
        self.isPreview = NO;
        return;
    }
    
    [self.fancymenu touchtap:sender];
}


- (void)oneFingerSwipeDown:(UISwipeGestureRecognizer *)recognizer
{
    [self closeView];
}


- (void) closeView
{
    //显示系统状态栏
    [[UIApplication sharedApplication] setStatusBarHidden:NO withAnimation:UIStatusBarAnimationFade];
    [self dismissViewControllerAnimated:YES completion:^(){}];
}

- (void) savePhoto
{
    int page = floor((self.collectionview.contentOffset.x - PHOTOWIDTH / 2) / PHOTOWIDTH) + 1;
    
    UICollectionViewCell *cell = [self.collectionview cellForItemAtIndexPath:[NSIndexPath indexPathForItem:page inSection:0]];
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    
    if (imgView.image) {
        UIImageWriteToSavedPhotosAlbum(imgView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(id)context{
//    UIView *view = [self.view subviewWithTag:100];
//    
//    [UIView animateWithDuration:0.2
//                     animations:^{
//                         view.alpha = 1;
//                     }completion:^(BOOL finished) {
//                         [view removeFromSuperview];
//                     }];
//
//    [self showCheckMarkTips];
    NSLog(@"save error");
}
@end
