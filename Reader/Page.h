//
//  Page.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Serializable.h"

@interface Page : NSObject <NSCopying, Serializable>

- (NSMutableString *)phraseText;
- (NSArray *)makeRuns;

@property (nonatomic, copy) NSArray *phrases;
@end
