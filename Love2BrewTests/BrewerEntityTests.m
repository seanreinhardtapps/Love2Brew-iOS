//
//  BrewerEntityTests.m
//  Love2Brew
//
//  Created by Sean Reinhardt on 2/4/15.
//  Copyright (c) 2015 Sean Reinhardt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>
#import "BrewerEntity.h"
#import "BrewerDataStack.h"

@interface BrewerEntityTests : XCTestCase{
    NSDictionary *testBrewer;
    BrewerDataStack *coreDataStack;
}


@end

@implementation BrewerEntityTests

- (void)setUp {
    [super setUp];
    testBrewer = [NSDictionary dictionaryWithObjects:@[@1, @"Brewer",@"history", @"howItWorks", @"overview", @"steps",@1,@1]
                                             forKeys:@[@"id", @"name", @"history", @"howItWorks", @"overview", @"steps", @"temp", @"rating",]];
    coreDataStack = [BrewerDataStack defaultStack];

}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testBrewerInit {
    
    BrewerEntity *brewer = [NSEntityDescription insertNewObjectForEntityForName:@"BrewerEntity"  inManagedObjectContext:coreDataStack.managedObjectContext];
    
    [brewer fillBrewerWithJSON:testBrewer];
    XCTAssert([brewer isKindOfClass:[BrewerEntity class]]);
}

- (void)testBrewerFillBrewerWithJSON {
    BrewerEntity *brewer = [NSEntityDescription insertNewObjectForEntityForName:@"BrewerEntity"  inManagedObjectContext:coreDataStack.managedObjectContext];
    
    [brewer fillBrewerWithJSON:testBrewer];
    XCTAssertEqualObjects(brewer.name, @"Brewer");
    XCTAssertEqualObjects(brewer.iD, @1);
    XCTAssertEqualObjects(brewer.history, @"history");
    XCTAssertEqualObjects(brewer.howItWorks, @"howItWorks");
    XCTAssertEqualObjects(brewer.overview, @"overview");
    XCTAssertEqualObjects(brewer.steps, @"steps");
    XCTAssertEqualObjects(brewer.temp, @1);
    XCTAssertEqualObjects(brewer.rating, @1);
}

- (void)testBrewerDownloadImageWithQueueAndStack {
    BrewerEntity *brewer = [NSEntityDescription insertNewObjectForEntityForName:@"BrewerEntity"  inManagedObjectContext:coreDataStack.managedObjectContext];
    static dispatch_queue_t queue = 0;
    if (0 == queue) {
        queue = dispatch_queue_create("com.sreinhardt.SeanReinhardtApps.Love2Brew", NULL);
    }
    dispatch_async(queue, ^{
    [brewer downloadImageWithQueue:queue andStack:coreDataStack];
    dispatch_async(dispatch_get_main_queue(), ^{
        XCTAssert(brewer.imageData.length > 0);
        });
    });
}

@end
