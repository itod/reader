//
//  Serializable.h
//  Shapes
//
//  Created by Todd Ditchendorf on 7/29/14.
//  Copyright (c) 2014 Todd Ditchendorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol Serializable <NSObject>
+ (instancetype)fromPlist:(NSDictionary *)plist;
- (NSMutableDictionary *)asPlist;
@end
