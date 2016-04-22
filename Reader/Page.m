//
//  Page.m
//  Reader
//
//  Created by Todd Ditchendorf on 1/13/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "Page.h"
#import "Run.h"
#import "Phrase.h"

@implementation Page

- (void)dealloc {
    self.phrases = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark NSCopying

- (id)copyWithZone:(NSZone *)zone {
    Page *page = [[Page alloc] init];
    
    page.phrases = _phrases;
    
    return page;
}


#pragma mark -
#pragma mark Serializable

+ (instancetype)fromPlist:(NSDictionary *)plist {
    Page *page = [[[Page alloc] init] autorelease];

    // phrases
    {
        NSMutableArray *phrases = [NSMutableArray array];
        for (id phrasePlist in plist[@"phrases"]) {
            Phrase *phrase = [Phrase fromPlist:phrasePlist];
            [phrases addObject:phrase];
        }
        page.phrases = phrases;
    }
    
    return page;
}


- (NSMutableDictionary *)asPlist {
    NSMutableDictionary *plist = [NSMutableDictionary dictionary];
    
    // phrases
    {
        NSMutableArray *phrasePlists = [NSMutableArray array];
        for (Phrase *phrase in _phrases) {
            id phrasePlist = [phrase asPlist];
            [phrasePlists addObject:phrasePlist];
        }
        plist[@"phrases"] = phrasePlists;
    }
    
    return plist;
}


#pragma mark -
#pragma mark Public

- (NSMutableString *)text {
    NSMutableString *str = [NSMutableString string];
    
    for (Phrase *phrase in _phrases) {
        [str appendFormat:@"%@ ", phrase.text];
    }
    
    return str;
}


- (NSArray *)makeRuns {
    NSMutableArray *runs = nil;

    NSInteger phraseCount = [_phrases count];
    if (phraseCount > 0) {
        
        NSInteger phrasesPerRun = 4;
        switch (phraseCount) {
            case 0:
            case 1:
            case 2:
            case 3:
            case 4:
                phrasesPerRun = phraseCount;
                break;
//            case 4:
//                phrasesPerRun = 2;
//                break;
            case 5:
            case 6:
                phrasesPerRun = 3;
                break;
            case 7:
            case 8:
                phrasesPerRun = 4;
                break;
            case 9:
            case 10:
                phrasesPerRun = 5;
                break;
            case 11:
            case 12:
                phrasesPerRun = 4;
                break;
            default:
                phrasesPerRun = 5;
                break;
        }
        
        NSInteger runCount = ceil((double)phraseCount / (double)phrasesPerRun);
        //NSLog(@"%@/%@ = %@", @(phraseCount), @(phrasesPerRun), @(runCount));
        runs = [NSMutableArray arrayWithCapacity:runCount];

        Run *run = nil;
        for (Phrase *phrase in _phrases) {
            if (run) {
                [run.phrases addObject:phrase];
                if (phrasesPerRun == [run.phrases count]) {
                    TDAssert([run.phrases count] <= phrasesPerRun);
                    run = nil;
                }
            } else {
                run = [[[Run alloc] init] autorelease];
                [runs addObject:run];

                run.phrases = [NSMutableArray arrayWithCapacity:phrasesPerRun];
                [run.phrases addObject:phrase];
            }
        }
        //TDAssert(runCount == [runs count]);
    }
    
    return runs;
}

@end
