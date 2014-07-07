//
//  AllImageViewController.m
//  WallPaper
//
//  Created by 余成海 on 13-8-19.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "NADAllImageViewController.h"
#import "NADPhotoViewController.h"
#import "KxMenu.h"
#import "UIImageView+WebCache.h"


@interface NADAllImageViewController ()

@end

@implementation NADAllImageViewController

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
    //设置委托
    self.collectionview.dataSource = self;
    self.collectionview.delegate = self;
    
    //设置item
    //UINib *cellNib = [UINib nibWithNibName:@"imageCollectionViewCell" bundle:nil];
    //[self.collectionview registerNib:cellNib forCellWithReuseIdentifier:@"Cell"];
    
    [self.collectionview registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"AllImageCollectionViewCell"];
    [self.collectionview setAllowsMultipleSelection:YES];
    [self.collectionview setBackgroundColor:[UIColor whiteColor]];
    
    //设置布局
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    [flowLayout setItemSize:CGSizeMake(100, 100)];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionVertical];
    flowLayout.sectionInset = UIEdgeInsetsMake(3, 4, 3, 5);
    flowLayout.minimumLineSpacing = 4;
    flowLayout.minimumInteritemSpacing = 4;
    //flowLayout.footerReferenceSize = CGSizeMake(300, 100);
    [self.collectionview setCollectionViewLayout:flowLayout];
    
    self.title = @"天龙壁纸";
    
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
//    KxMenuItem *first = menuItems[0];
//    first.foreColor = [UIColor colorWithRed:47/255.0f green:112/255.0f blue:225/255.0f alpha:1.0];
//    first.alignment = NSTextAlignmentCenter;
    
    [KxMenu showMenuInView:self.view
                  fromRect:CGRectMake(230, 0, 100, 0)
                 menuItems:menuItems];
}
- (void) pushMenuItem:(id)sender
{
    if([[sender title] compare:@"壁纸专题"] == NSOrderedSame)
    {
        [self.navigationController popToRootViewControllerAnimated:NO];
    }
}

#pragma -mark CollectionView DataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *identifier = @"AllImageCollectionViewCell";
    
    UICollectionViewCell *cell = (UICollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
    
    CGRect imageRect=CGRectMake(0, 0, cell.frame.size.width, cell.frame.size.height);
    UIImageView *imageView=[[UIImageView alloc]initWithFrame:imageRect];
    imageView.tag=1;
    [cell.contentView addSubview:imageView];
    
    UIImageView *imgView = (UIImageView *)[cell.contentView viewWithTag:1];
    [imgView setImageWithURL:[NSURL URLWithString:[self.imageArray objectAtIndex:indexPath.row]] placeholderImage:[UIImage imageNamed:@"photoDefault.png"]];
    
    return cell;
}

#pragma -mark CollectionView delegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.navigationController.navigationBarHidden = NO;
    
    NADPhotoViewController *photoViewController = [[NADPhotoViewController alloc] initWithNibName:@"NADPhotoViewController" bundle:nil];
    
    [self presentViewController:photoViewController animated:YES completion:^(){}];
    
    
}
@end
