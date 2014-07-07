//
//  CoreDataContext.h
//  CoreDataTest
//
//  Created by 余成海 on 13-8-2.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Collect.h"

#define EntityName "TestData"

@interface CoreDataContext : NSObject

+ (NSManagedObjectContext *)managedObjectContext;

+ (void)performCollectFetch;

+ (NSFetchedResultsController *)collectFetchedResultController;

+ (BOOL)collectContainUrl:(NSString *)url;

+ (void)saveCollect:(NSNumber*)title name:(NSString*)name;

+ (void)showCollect;

+ (void)deleteCollect: (NSNumber*)title;
@end
