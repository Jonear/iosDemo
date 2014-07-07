//
//  ViewController.m
//  showpage
//
//  Created by 余 成海 on 13-7-26.
//  Copyright (c) 2013年 余 成海. All rights reserved.
//

#import "ViewController.h"
#import "DetailViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIBarButtonItem *showButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(showObject:)];
    self.navigationItem.rightBarButtonItem = showButton;
    
    //[self GetUpdate];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)showObject:(id)sender
{
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:nil];
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    if(![detailViewController loadWebWithFileHtml:@"table"])
    {
        [detailViewController loadWebWithString:@"http://baidu.com" id:@"table"];
    }
}

@end
