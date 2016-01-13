//
//  Phrase.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Serializable.h"

@interface Phrase : NSObject <NSCopying, Serializable>

@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *imageName;
@end
