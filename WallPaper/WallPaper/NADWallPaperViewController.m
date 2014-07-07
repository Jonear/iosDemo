//
//  ViewController.m
//  WallPaper
//
//  Created by 余成海 on 13-8-13.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "NADWallPaperViewController.h"
#import "NADImageCollectionViewCell.h"
#import "NADPhotoViewController.h"
#import "KxMenu.h"
#import "NADAllImageViewController.h"
//#import "ADLivelyTableView.h"

#define IMAGEWIDTH  150
#define IMAGEHEIGHT 150

@interface NADWallPaperViewController ()

@end

@implementation NADWallPaperViewController

@synthesize collectionview;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
	// Do any additional setup after loading the view, typically from a nib.
    //设置委托
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    
    //设置item
    [self.collectionview registerClass:[NADImageCollectionViewCell class] forCellWithReuseIdentifier:@"NADImageCollectionViewCell"];
    [self.collectionview setAllowsMultipleSelection:YES];
    [self.collectionview setBackgroundColor:[UIColor whiteColor]];
    
    //设置布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(IMAGEWIDTH, IMAGEHEIGHT)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(3, 6, 3, 10);
    flowLayout.minimumLineSpacing = 10;
    flowLayout.minimumInteritemSpacing = 6;
    //flowLayout.footerReferenceSize = CGSizeMake(300, 100);
    [self.collectionview setCollectionViewLayout:flowLayout];
    
    self.title = @"天龙壁纸";
    
    self.animationCount = 0;

    //
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonItemStyleDone target:self action:@selector(showMenu)];
    
    self.imageArray = [[NSMutableArray alloc] initWithObjects:
                       @"http://wenwen.soso.com/p/20080820/20080820020459-1714828217.jpg",
                       @"http://images.xiaoflash.com/picture/200910/16276.jpg",
                       @"http://image.003c.com/img_01/a_2/3095214801_4231099424_0_0.jpg",
                       @"http://pic5.duowan.com/newgame/0904/103310903062/103311927493.jpg",
                       @"http://pic.tot.name/200509/23/2005923112933156.gif",
                       @"http://www.5253.com/zhuanti/2011/04/huoyingimg/02.jpg",
                       @"http://imgsrc.baidu.com/forum/pic/item/8289ae02b4804b734afb5142.jpg",
                       nil];
}

-(void) showMenu
{
    NSArray *menuItems =
    @[
      [KxMenuItem menuItem:@"壁纸专题"
                     image:[UIImage imageNamed:@"home_icon.png"]
                    target:self
                    action:@selector(pushMenuItem:)],
      
      [KxMenuItem menuItem:@"全部壁纸"
                     image:[UIImage imageNamed:@"reload.png"]
                    target:self
                    action:@selector(pushMenuItem:)],
      ];
    
    //KxMenuItem *first = menuItems[0];
    //first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
    //first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(230, 0, 100, 0)
                 menuItems:menuItems];
}
- (void) pushMenuItem:(id)sender
{
    if([[sender title] compare:@"全部壁纸"] == NSOrderedSame)
    {
        NADAllImageViewController *allimageViewController = [[NADAllImageViewController alloc] initWithNibName:@"NADAllImageViewController" bundle:nil];
        [self.navigationController pushViewController:allimageViewController animated:NO];
    }
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
    static NSString *identifier = @"NADImageCollectionViewCell";
    
    NADImageCollectionViewCell *cell = (NADImageCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    if(!cell.isShowCell)
    {
        cell.alpha = 0;
        //cell.transform = CGAffineTransformMakeScale(0, 0);
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDelay:0.1 * self.animationCount];
        [UIView setAnimationDuration:0.6];
        //cell.transform = CGAffineTransformMakeScale(1, 1);
        cell.alpha = 1;
        [UIView setAnimationDelegate:self];
        [UIView setAnimationDidStopSelector:@selector(finishanimation)];
        [UIView commitAnimations];
        self.animationCount++;
        
        cell.isShowCell = YES;
    }
    


    if ([cell isKindOfClass:[NADImageCollectionViewCell class]]) {
        [cell setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:indexPath.row]] title:@"天龙小秘专题"];
  
    }
    return cell;
}

#pragma -mark CollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.navigationController.navigationBarHidden = NO;
    
    NADPhotoViewController *photoViewController = [[NADPhotoViewController alloc] initWithNibName:@"NADPhotoViewController" bundle:nil];
  
    [self presentViewController:photoViewController animated:YES completion:^(){}];

}

- (void) finishanimation
{
    self.animationCount--;
}

@end
