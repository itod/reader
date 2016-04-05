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
                     [parser parseString:@"(der Fußball)[soccerball];" error:nil],
                     [parser parseString:@"(das Feld)[soccer_field];" error:nil],
                     [parser parseString:@"(das Tor)[soccer_goal];" error:nil],
                     [parser parseString:@"(der Spieler)[soccer_boy];" error:nil],
                     [parser parseString:@"(die Spielerin)[soccer_girl];" error:nil],
                     
                     
                     [parser parseString:@"(Chip)[chip] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Aurora)[aurora] is (sad.)[sad];" error:nil],
                     [parser parseString:@"(Gus)[gus] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] is (sad.)[sad];" error:nil],

                     [parser parseString:@"(Cinderella)[cinderella] (loves)[heart] the (Prince.)[prince];" error:nil],

                     [parser parseString:@"(Cogsworth)[cogsworth] (loves)[heart] (Football.)[football];" error:nil],
                     [parser parseString:@"(Gus)[gus] (loves)[heart] (Basketball.)[basketball];" error:nil],
                     [parser parseString:@"The (prince)[prince] (loves)[heart] (Soccer.)[soccerball];" error:nil],
                     [parser parseString:@"(Gaston)[gaston] (loves)[heart] (Tennis.)[racquet];" error:nil],
                     [parser parseString:@"(Gaston)[gaston] (loves)[heart] (Belle.)[belle];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (loves)[heart] (Chip.)[chip];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (and)[and] (Chip)[chip] (love)[heart] (Belle.)[belle];" error:nil],
                     
                     [parser parseString:@"(Belle)[belle] (loves)[heart] the (night)[night] (time.)[clock];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (loves)[heart] the (day)[day] (time.)[clock];" error:nil],
                     
                     [parser parseString:@"(Mrs. Potts)[mrspotts] (loves)[heart] (Chip)[chip] to the (moon)[moon] (and)[and] (back.)[back];" error:nil],
                     [parser parseString:@"(Gus)[gus] (loves)[heart] the (day)[day] (time)[clock] (and)[and] the (night)[night] (time.)[clock];" error:nil],
                     [parser parseString:@"(Belle)[belle] (loves)[heart] the (Sun)[sun] (and)[and] the (Moon.)[moon];" error:nil],

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
