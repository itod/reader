//
//  Page.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Serializable.h"

@interface Page : NSObject <NSCopying, Serializable>

- (NSArray *)makeRuns;
- (NSMutableString *)text;

@property (nonatomic, copy) NSArray *phrases;
@property (nonatomic, assign) BOOL textHidden;
@end
