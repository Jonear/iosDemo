//
//  DMRootViewController.m
//  Demo
//
//  Created by wenbi on 14-6-18.
//  Copyright (c) 2014年 NexusPod. All rights reserved.
//

#import "DMRootViewController.h"
#import "APDataViewController.h"

@interface DMRootViewController ()

@property(nonatomic, strong) NSMutableArray *viewControllers;

@end

@implementation DMRootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Root";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Start" style:UIBarButtonItemStyleBordered target:self action:@selector(doStart:)];
    
    self.viewControllers = [NSMutableArray arrayWithCapacity:10];
    
    for (int i = 0; i < 10; ++i) {
        APDataViewController *vc = [[APDataViewController alloc] init];
        [self.viewControllers addObject:vc];
    }

}

- (void)doStart:(id)sender
{
    int r = (int)time(0);
    
    for (NSInteger i = 0; i < 30; ++i) {
        srand(r);
        r = rand();        
        int x = r % 10;
        if (x == 3) {
            [self popToRoot];
        }
        else if (x == 4) {
            [self popTo];
        }
        else if (x == 5) {
            [self pop];
        }
        else {
            [self push];
        }
    }
    [self performSelector:@selector(doStart:) withObject:nil afterDelay:2];
}

- (void)push
{
    static int i = 0;
    APDataViewController *vc = [[APDataViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    vc.title = [NSString stringWithFormat:@"Title %i", i++];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)pop
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)popTo
{
    srand((unsigned int)time(0));
    NSUInteger index = abs(rand()) % self.navigationController.viewControllers.count;
    [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index] animated:YES];
}

- (void)popToRoot
{
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
