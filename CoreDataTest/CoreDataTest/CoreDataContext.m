//
//  CoreDataContext.m
//  CoreDataTest
//
//  Created by 余成海 on 13-8-2.
//  Copyright (c) 2013年 余成海. All rights reserved.
//

#import "CoreDataContext.h"

@implementation CoreDataContext

static NSManagedObjectContext *context;
static NSFetchedResultsController *collectResultController;

+ (void) initCoreData
{
	NSError *error;
	
	// Path to sqlite file.
	NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/test.sqlite"];
	NSURL *url = [NSURL fileURLWithPath:path];
	
	// Init the model, coordinator, context
	NSManagedObjectModel *managedObjectModel = [NSManagedObjectModel mergedModelFromBundles:nil];
	NSPersistentStoreCoordinator *persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:managedObjectModel];
	if (![persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:url options:nil error:&error])
		NSLog(@"Error: %@", [error localizedDescription]);
	else
	{
		context = [[NSManagedObjectContext alloc] init] ;
		[context setPersistentStoreCoordinator:persistentStoreCoordinator];
	}
}

+ (NSManagedObjectContext*)managedObjectContext {
    if (!context) {
        [self initCoreData];
    }
    return context;
}

+ (void)performCollectFetch {
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
	NSEntityDescription *entity = [NSEntityDescription entityForName:@EntityName inManagedObjectContext:[self managedObjectContext]];
	[fetchRequest setEntity:entity];
	[fetchRequest setFetchBatchSize:100]; // more than needed for this example
	
	// Apply an ascending sort for the items
	NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:NO selector:nil];
	NSArray *descriptors = [NSArray arrayWithObject:sortDescriptor];
	[fetchRequest setSortDescriptors:descriptors];
    
	// Init the fetched results controller
	NSError *error;
	collectResultController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:@"Root"];
    //collectResultController.delegate = self;
    if (![collectResultController performFetch:&error])
        NSLog(@"Error: %@", [error localizedDescription]);
}

+ (NSFetchedResultsController *)collectFetchedResultController {
    if (!collectResultController) {
        [self performCollectFetch];
    }
    return collectResultController;
}

+ (BOOL)collectContainUrl:(NSString *)name {
    NSFetchedResultsController *collectResult = [self collectFetchedResultController];
    for (Collect *collect in collectResult.fetchedObjects) {
        if ([collect.name isEqualToString:name]) {
            return YES;
        }
    }
    return NO;
}

+ (void)showCollect
{
    NSFetchedResultsController *collectResult = [self collectFetchedResultController];
    for (Collect *collect in collectResult.fetchedObjects) {
        NSLog(@"%@:%@", collect.title, collect.name);
    }
}

+ (void)saveCollect:(NSNumber*)title name:(NSString*)name
{
    NSManagedObjectContext *context = [CoreDataContext managedObjectContext];
    Collect *collect = (Collect *)[NSEntityDescription insertNewObjectForEntityForName:@EntityName inManagedObjectContext:context];
    collect.title = title;
    collect.name = name;

    NSError *error;
    if (![context save:&error]) {
        NSLog(@"saveCollect error:%@", [error description]);
    }
}

+ (void)deleteCollect: (NSNumber*)title
{
    NSFetchedResultsController *collectResult = [self collectFetchedResultController];
    for (Collect *collect in collectResult.fetchedObjects) {
        if([collect.title isEqualToNumber:title])
        {
            [[CoreDataContext managedObjectContext] deleteObject:collect];
            //[collect setValue:@"ok" forKey:@"name"];
        }
    }
   
    NSError *error;
    if (![[CoreDataContext managedObjectContext] save:&error]) {
        NSLog(@"delete table row error:%@", error);
    }
    [CoreDataContext performCollectFetch];
}
@end
