#import "StoryParser.h"
#import <PEGKit/PEGKit.h>


@interface StoryParser ()

@end

@implementation StoryParser { }

- (instancetype)initWithDelegate:(id)d {
    self = [super initWithDelegate:d];
    if (self) {
        
        self.startRuleName = @"story";
        self.tokenKindTab[@";"] = @(STORYPARSER_TOKEN_KIND_SEMI_COLON);
        self.tokenKindTab[@"(,)"] = @(STORYPARSER_TOKEN_KIND_PHRASESPEC);
        self.tokenKindTab[@"[,]"] = @(STORYPARSER_TOKEN_KIND_IMAGESPEC);

        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_SEMI_COLON] = @";";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_PHRASESPEC] = @"(,)";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_IMAGESPEC] = @"[,]";

    }
    return self;
}

- (void)dealloc {
    

    [super dealloc];
}

- (void)start {
    [self execute:^{
    
    PKTokenizer *t = self.tokenizer;
    [t.symbolState add:@"!="];
    [t.symbolState add:@"<="];
    [t.symbolState add:@">="];
    
    [t.delimitState addStartMarker:@"(" endMarker:@")" allowedCharacterSet:nil];
    [t.delimitState addStartMarker:@"[" endMarker:@"]" allowedCharacterSet:nil];
    [t setTokenizerState:t.delimitState from:'(' to:')'];
    [t setTokenizerState:t.delimitState from:'[' to:'['];

    }];

    [self story_]; 
    [self matchEOF:YES]; 

}

- (void)story_ {
    
    do {
        [self line_]; 
    } while ([self speculate:^{ [self line_]; }]);

    [self fireDelegateSelector:@selector(parser:didMatchStory:)];
}

- (void)line_ {
    
    do {
        [self phraseSpec_]; 
        [self imageSpec_]; 
    } while ([self speculate:^{ [self phraseSpec_]; [self imageSpec_]; }]);
    [self match:STORYPARSER_TOKEN_KIND_SEMI_COLON discard:YES]; 

    [self fireDelegateSelector:@selector(parser:didMatchLine:)];
}

- (void)phraseSpec_ {
    
    [self match:STORYPARSER_TOKEN_KIND_PHRASESPEC discard:NO]; 

    [self fireDelegateSelector:@selector(parser:didMatchPhraseSpec:)];
}

- (void)imageSpec_ {
    
    [self match:STORYPARSER_TOKEN_KIND_IMAGESPEC discard:NO]; 

    [self fireDelegateSelector:@selector(parser:didMatchImageSpec:)];
}

@end