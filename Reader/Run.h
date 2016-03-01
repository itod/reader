//
//  Run.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Run : NSObject <NSCopying>

- (NSMutableString *)phraseText;

@property (nonatomic, copy) NSArray *phrases;
@end
