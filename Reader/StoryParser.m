#import "StoryParser.h"
#import <PEGKit/PEGKit.h>


@interface StoryParser ()

@end

@implementation StoryParser { }

- (instancetype)initWithDelegate:(id)d {
    self = [super initWithDelegate:d];
    if (self) {
        
        self.startRuleName = @"story";
        self.tokenKindTab[@"(,)"] = @(STORYPARSER_TOKEN_KIND_PHRASESPEC);
        self.tokenKindTab[@"[,]"] = @(STORYPARSER_TOKEN_KIND_IMAGESPEC);
        self.tokenKindTab[@";"] = @(STORYPARSER_TOKEN_KIND_TERMINATOR);

        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_PHRASESPEC] = @"(,)";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_IMAGESPEC] = @"[,]";
        self.tokenKindNameTab[STORYPARSER_TOKEN_KIND_TERMINATOR] = @";";

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
        
    [t.wordState setWordChars:YES from:'.' to:'.'];

    }];

    [self story_]; 
    [self matchEOF:YES]; 

}

- (void)story_ {
    
    do {
        [self line_]; 
    } while ([self predicts:TOKEN_KIND_BUILTIN_ANY]);

    [self fireDelegateSelector:@selector(parser:didMatchStory:)];
}

- (void)line_ {
    
    do {
        if ([self predicts:STORYPARSER_TOKEN_KIND_PHRASESPEC, 0]) {
            [self decoratedPhrase_];
        } else if (![self predicts:STORYPARSER_TOKEN_KIND_TERMINATOR, 0]) {
            [self text_]; 
        } else {
            [self raise:@"No viable alternative found in rule 'line'."];
        }
    } while (![self predicts:STORYPARSER_TOKEN_KIND_TERMINATOR, 0]);
    [self terminator_]; 

    [self fireDelegateSelector:@selector(parser:didMatchLine:)];
}

- (void)text_ {
    
    if (![self predicts:STORYPARSER_TOKEN_KIND_TERMINATOR, 0]) {
        [self match:TOKEN_KIND_BUILTIN_ANY discard:NO];
    } else {
        [self raise:@"negation test failed in text"];
    }

    [self fireDelegateSelector:@selector(parser:didMatchText:)];
}

- (void)decoratedPhrase_ {
    
    [self phraseSpec_]; 
    [self imageSpec_]; 

    [self fireDelegateSelector:@selector(parser:didMatchDecoratedPhrase:)];
}

- (void)phraseSpec_ {
    
    [self match:STORYPARSER_TOKEN_KIND_PHRASESPEC discard:NO]; 

    [self fireDelegateSelector:@selector(parser:didMatchPhraseSpec:)];
}

- (void)imageSpec_ {
    
    [self match:STORYPARSER_TOKEN_KIND_IMAGESPEC discard:NO]; 

    [self fireDelegateSelector:@selector(parser:didMatchImageSpec:)];
}

- (void)terminator_ {
    
    [self match:STORYPARSER_TOKEN_KIND_TERMINATOR discard:NO]; 

    [self fireDelegateSelector:@selector(parser:didMatchTerminator:)];
}

@end
