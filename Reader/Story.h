//
//  Story.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Serializable.h"

@class Page;

@interface Story : NSObject <NSCopying, Serializable>

- (Page *)currentPage;
- (void)reverse:(NSInteger)pages;
- (void)forward:(NSInteger)pages;
- (void)reset;

- (NSMutableString *)text;

@property (nonatomic, copy) NSArray *pages;
@property (nonatomic, assign) NSInteger pageIndex;
@end
