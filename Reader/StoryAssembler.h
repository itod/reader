//
//  StoryAssembler.h
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import <Foundation/Foundation.h>

@class PKParser;
@class PKAssembly;
@class Story;

@interface StoryAssembler : NSObject

- (void)parser:(PKParser *)p didMatchStory:(PKAssembly *)a;
- (void)parser:(PKParser *)p didMatchLine:(PKAssembly *)a;
- (void)parser:(PKParser *)p didMatchPhraseSpec:(PKAssembly *)a;
- (void)parser:(PKParser *)p didMatchImageSpec:(PKAssembly *)a;

@property (nonatomic, retain) Story *story;
@end
