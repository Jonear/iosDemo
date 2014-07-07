//
//  ViewController.m
//  CoreDataTest
//
//  Created by 余成海 on 13-8-2.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "ViewController.h"
#import "CoreDataContext.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [CoreDataContext deleteCollect:[NSNumber numberWithInt:2]];
    
    //[CoreDataContext saveCollect:[NSNumber numberWithInt:1] name:@"test1"];
    //[CoreDataContext saveCollect:[NSNumber numberWithInt:2] name:@"test2"];
    //[CoreDataContext saveCollect:[NSNumber numberWithInt:3] name:@"test3"];
    
    [CoreDataContext showCollect];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
