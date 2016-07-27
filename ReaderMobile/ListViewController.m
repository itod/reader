//
//  ListViewController.m
//  Reader
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "ListViewController.h"
#import "PageViewController.h"

#import "StoryParser.h"
#import "StoryAssembler.h"

#define CELL_ID @"Default"

@interface ListViewController ()
@property (nonatomic, retain) NSArray *stories;
@property (nonatomic, assign) NSUInteger selectedStoryIndex;
@end

@implementation ListViewController

- (void)dealloc {
    self.tableView = nil;
    self.stories = nil;
    [super dealloc];
}


#pragma mark -
#pragma mark UIViewController

- (BOOL)prefersStatusBarHidden {
    return YES;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    TDAssert(_tableView);
    TDAssert(self == _tableView.dataSource);
    TDAssert(self == _tableView.delegate);

    StoryAssembler *ass = [[[StoryAssembler alloc] init] autorelease];
    StoryParser *parser = [[[StoryParser alloc] initWithDelegate:ass] autorelease];

    self.stories = @[
                     [parser parseString:@"(das Auge)[eye];" error:nil],
                     [parser parseString:@"(die Nase)[nose];" error:nil],
                     [parser parseString:@"(die Hand)[hand];" error:nil],
                     [parser parseString:@"(das Knie)[knee];" error:nil],
                     [parser parseString:@"(der Knöchel)[ankle];" error:nil],
                     [parser parseString:@"(der Fuß)[foot];" error:nil],
                     [parser parseString:@"(der Ball)[ball];" error:nil],
                     [parser parseString:@"(der Fußball)[soccerball];" error:nil],
                     [parser parseString:@"(das Feld)[soccer_field];" error:nil],
                     [parser parseString:@"(das Tor)[soccer_goal];" error:nil],
                     [parser parseString:@"(der Spieler)[soccer_boy];" error:nil],
                     [parser parseString:@"(die Spielerin)[soccer_girl];" error:nil],
                     
                     [parser parseString:@"E is for (Eye)[eye];" error:nil],
                     [parser parseString:@"N is for (Nose)[nose];" error:nil],
                     [parser parseString:@"A is for (Ankle)[ankle];" error:nil],
                     [parser parseString:@"F is for (Foot)[foot];" error:nil],
                     [parser parseString:@"B is for (Ball)[ball];" error:nil],
                     [parser parseString:@"K is for (Knee)[knee];" error:nil],
                     [parser parseString:@"(Soccer Ball)[soccerball];" error:nil],
                     [parser parseString:@"(Soccer Field)[soccer_field];" error:nil],
                     [parser parseString:@"(Soccer Goal)[soccer_goal];" error:nil],
                     [parser parseString:@"(Boy Player)[soccer_boy];" error:nil],
                     [parser parseString:@"(Girl Player)[soccer_girl];" error:nil],
                     
                     [parser parseString:@"(Cogsworth)[cogsworth] (likes)[like] (Lumiere.)[lumiere];" error:nil],
                     [parser parseString:@"(Belle)[belle] (likes)[like] (Aurora.)[aurora];" error:nil],
                     [parser parseString:@"(Belle)[belle] (likes)[like] (Chip.)[chip];" error:nil],
                     [parser parseString:@"(Cinderella)[cinderella] (likes)[like] (Gus.)[gus];" error:nil],
                     [parser parseString:@"(Gaston)[gaston] (likes)[like] (Basketball.)[basketball];" error:nil],
                     [parser parseString:@"(Maurice)[maurice] (likes)[like] (Baseball.)[baseball];" error:nil],
                     [parser parseString:@"(Chip)[chip] (likes)[like] (Basketball)[basketball] (and)[and] (Soccer.)[soccerball];" error:nil],
                     [parser parseString:@"(Lumiere)[lumiere] (likes)[like] (Tennis)[racquet] (and)[and] (Football.)[football];" error:nil],

                     [parser parseString:@"(Belle)[belle] (loves)[heart] (Music.)[music];" error:nil],

                     [parser parseString:@"H is for (Happy)[happy];" error:nil],
                     [parser parseString:@"S is for (Sad)[sad];" error:nil],
                     [parser parseString:@"L is for (Love)[heart];" error:nil],
                     [parser parseString:@"L is for (Like)[like];" error:nil],

                     [parser parseString:@"A is for (Anna)[anna];" error:nil],
                     [parser parseString:@"E is for (Elsa)[elsa];" error:nil],
                     [parser parseString:@"O is for (Olaf)[olaf];" error:nil],
                     [parser parseString:@"M is for (Maurice)[maurice];" error:nil],
                     [parser parseString:@"B is for (Belle)[belle];" error:nil],
                     [parser parseString:@"L is for (Lumiere)[lumiere];" error:nil],
                     [parser parseString:@"A is for (Aurora)[aurora];" error:nil],
                     [parser parseString:@"G is for (Gus)[gus];" error:nil],
                     [parser parseString:@"M is for (Mrs. Potts)[mrspotts];" error:nil],
                     [parser parseString:@"G is for (Gaston)[gaston];" error:nil],
                     [parser parseString:@"P is for (Prince Charming)[prince];" error:nil],
                     [parser parseString:@"C is for (Cogsworth)[cogsworth];" error:nil],
                     [parser parseString:@"M is for (Moon)[moon];" error:nil],
                     [parser parseString:@"S is for (Sun)[sun];" error:nil],
                     [parser parseString:@"T is for (Tennis)[racquet];" error:nil],
                     [parser parseString:@"C is for (Clock)[clock];" error:nil],
                     [parser parseString:@"B is for (Baseball)[baseball];" error:nil],
                     [parser parseString:@"S is for (Soccer)[soccerball];" error:nil],
                     [parser parseString:@"G is for (Goal)[soccer_goal];" error:nil],
                     [parser parseString:@"C is for (Cloud)[cloud];" error:nil],
                     [parser parseString:@"S is for (Star)[star];" error:nil],
                     [parser parseString:@"B is for (Brush)[scrub_brush];" error:nil],

                     [parser parseString:@"(Maurice)[maurice] is (surprised.)[surprised];" error:nil],
                     [parser parseString:@"(Lumiere)[lumiere] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Chip)[chip] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Aurora)[aurora] is (sad.)[sad];" error:nil],
                     [parser parseString:@"(Gus)[gus] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] is (sad.)[sad];" error:nil],
                     [parser parseString:@"(Olaf)[olaf] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Elsa)[elsa] (likes)[likes] (Olaf.)[olaf];" error:nil],
                     [parser parseString:@"(Anna)[anna] (loves)[heart] (Elsa.)[elsa];" error:nil],
                     
                     [parser parseString:@"(Maurice)[maurice] (loves)[heart] (Belle.)[belle];" error:nil],
                     [parser parseString:@"(Belle)[belle] (loves)[heart] the (Beast.)[beast];" error:nil],

                     [parser parseString:@"(Cinderella)[cinderella] (loves)[heart] the (Prince.)[prince];" error:nil],

                     [parser parseString:@"(Cogsworth)[cogsworth] (loves)[heart] (Football.)[football];" error:nil],
                     [parser parseString:@"(Gus)[gus] (loves)[heart] (Basketball.)[basketball];" error:nil],
                     [parser parseString:@"The (Prince)[prince] (loves)[heart] (Soccer.)[soccerball];" error:nil],
                     [parser parseString:@"(Gaston)[gaston] (loves)[heart] (Tennis.)[racquet];" error:nil],
                     [parser parseString:@"(Gaston)[gaston] (loves)[heart] (Belle.)[belle];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (loves)[heart] (Chip.)[chip];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (and)[and] (Chip)[chip] (love)[heart] (Belle.)[belle];" error:nil],
                     
                     [parser parseString:@"(Belle)[belle] (loves)[heart] the (night)[night] (time.)[clock];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (loves)[heart] the (day)[day] (time.)[clock];" error:nil],
                     
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (loves)[heart] (Chip)[chip] to the (moon)[moon] (and)[and] (back.)[back];" error:nil],
                     [parser parseString:@"(Gus)[gus] (loves)[heart] the (day)[day] (time)[clock] (and)[and] the (night)[night] (time.)[clock];" error:nil],
                     [parser parseString:@"(Belle)[belle] (loves)[heart] the (sun)[sun] (and)[and] the (moon.)[moon];" error:nil],

//                     [parser parseString:@";" error:nil],
//                     [parser parseString:@";" error:nil],
                     ];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    PageViewController *pvc = [segue destinationViewController];
    TDAssert([pvc isKindOfClass:[PageViewController class]]);
    
    TDAssert(_stories);
    TDAssert(_selectedStoryIndex < [_stories count]);
    TDAssert(_selectedStoryIndex != NSNotFound);
    pvc.story = _stories[_selectedStoryIndex];
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    TDAssert(tv == _tableView);
    TDAssert(_stories);
    return [_stories count];
}


- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)path {
    TDAssert(tv == _tableView);
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CELL_ID];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID] autorelease];
    }
    
    NSUInteger idx = path.row;
    TDAssert(_stories);
    cell.textLabel.text = [_stories[idx] text];
    
    [cell setNeedsDisplay];
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)path {
    TDAssert(tv == _tableView);
    self.selectedStoryIndex = path.row;
    
    [self performSegueWithIdentifier:@"story" sender:tv];
}

@end
