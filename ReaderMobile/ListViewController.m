//
//  ListViewController.m
//  Reader
//
//  Created by Todd Ditchendorf on 3/11/16.
//  Copyright © 2016 Todd Ditchendorf. All rights reserved.
//

#import "ListViewController.h"
#import "StoryViewController.h"

#import "StoryParser.h"
#import "StoryAssembler.h"
#import "Story.h"

#define CELL_ID @"Default"

@interface ListViewController ()
@property (nonatomic, retain) Story *story;
@end

@implementation ListViewController

- (void)dealloc {
    self.tableView = nil;
    self.story = nil;
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

    self.selectedPageIndex = NSNotFound;
    
    StoryAssembler *ass = [[[StoryAssembler alloc] init] autorelease];
    StoryParser *parser = [[[StoryParser alloc] initWithDelegate:ass] autorelease];
    
    self.story = [parser parseString:
//
//    @"(Mrs. Potts)[mrspotts] is from (Great Britain)[british_flag];"
//    @"(Merida)[merida] is from (Ireland)[irish_flag];"
//    @"(Lumiere)[lumiere] is from (France)[french_flag];"
//    @"(Rapunzel)[rapunzel] is from (Germany)[german_flag];"
//    @"(Hercules)[hercules] is from (Greece)[greek_flag];"
//    @"(Belle)[belle] is from (France)[french_flag];"
//    @"(Cogsworth)[cogsworth] is from (Great Britain)[british_flag];"
//    @"(Elsa)[elsa] is from (Norway)[norwegian_flag];"
//    @"(Gaston)[gaston] is from (France)[french_flag];"
//    @"(Mulan)[mulan] is from (China)[chinese_flag];"
//    @"(Flynn)[flynn] is from (Germany)[german_flag];"
//    @"(Anna)[anna] is from (Norway)[norwegian_flag];"
//    @"(Maurice)[maurice] is from (France)[french_flag];"
//    @"(Snow White)[snow_white] is from (Germany)[german_flag];"
//    @"(Olaf)[olaf] is from (Norway)[norwegian_flag];"
//    @"(Mushu)[mushu] is from (China)[chinese_flag];"
//
//                  @"S is for (Shoulder)[shoulder];"
//                  @"L is for (Lungs)[lungs];"
//                  @"A is for (Airplane)[airplane];"
//                  @"T is for (Tank)[tank];"
//                  @"H is for (Heart)[heart];"
//                  @"C is for (Collar)[collar];"
//                  @"S is for (Stairs)[stairs];"
//                  @"N is for (Napkin)[napkin];"
//                  @"A is for (Angel)[angel];"
//                  @"A is for (Arrow)[arrow];"
//                  @"B is for (Balcony)[balcony];"
//                  @"B is for (Bandage)[bandage];"
//                  @"B is for (Bat)[bat];"
//                  @"B is for (Beer)[beer];"
//                  @"B is for (Belt)[belt];"
//                  @"B is for (Bench)[bench];"
//                  @"B is for (Brush)[brush];"
//                  @"C is for (Calf)[calf];"
//                  @"C is for (Castle)[castle];"
//                  @"C is for (Cherry)[cherry];"
//                  @"C is for (Comb)[comb];"
//                  @"C is for (Compass)[compass];"
//                  @"D is for (Dart)[dart];"
//                  @"E is for (Eyebrow)[eyebrow];"
//                  @"F is for (Fence)[fence];"
//                  @"F is for (Forest)[forest];"
//                  @"F is for (Fruit)[fruit];"
//                  @"H is for (Ham)[ham];"
//                  @"H is for (Hedgehog)[hedgehog];"
//                  @"H is for (Hill)[hill];"
//                  @"H is for (Hoe)[hoe];"
//                  @"I is for (Island)[island];"
//                  @"I is for (Ivy)[ivy];"
//                  @"L is for (Lamb)[lamb];"
//                  @"M is for (Mountain)[mountain];"
//                  @"N is for (Notebook)[notebook];"
//                  @"O is for (Oven)[oven];"
//                  @"O is for (Owl)[owl];"
//                  @"P is for (Path)[path];"
//                  @"P is for (Pinecone)[pinecone];"
//                  @"P is for (Pond)[pond];"
//                  @"P is for (Pool)[pool];"
//                  @"P is for (Porcupine)[porcupine];"
//                  @"P is for (Pot)[pot];"
//                  @"P is for (Puddle)[puddle];"
//                  @"R is for (Rake)[rake];"
//                  @"R is for (River)[river];"
//                  @"S is for (Sheet)[sheet];"
//                  @"S is for (Sign)[sign];"
//                  @"S is for (Sponge)[sponge];"
//                  @"S is for (Stove)[stove];"
//                  @"S is for (Stump)[stump];"
//                  @"S is for (Sweatshirt)[sweatshirt];"
//                  @"T is for (Tower)[tower];"
//                  @"T is for (Turkey)[turkey];"
//                  @"W is for (Web)[web];"
//                  @"W is for (Windmill)[windmill];"
//                  @"W is for (Wine)[wine];"
//                  @"W is for (Worm)[worm];"
//
//    @"M is for (Moose)[moose];"
//    @"S is for (Sofa)[sofa];"
//    @"S is for (Shark)[shark];"
//    @"J is for (Juice Box)[juice_box];"
//    @"C is for (Card)[card];"
//    @"H is for (Hay)[hay];"
//    @"B is for (Bone)[bone];"
//    @"B is for (Binoculars)[binoculars];"
//    @"S is for (Slide)[slide];"
//    @"P is for (Peacock)[peacock];"
//    @"P is for (Pyramid)[pyramid];"
//    @"C is for (Coconut)[coconut];"
//    @"C is for (Cards)[cards];"
//    @"E is for (Eraser)[eraser];"
//    @"W is for (Whistle)[whistle];"
//    @"R is for (Roller Coaster)[roller_coaster];"
//    @"Y is for (Yo-Yo)[yo_yo];"
//    @"S is for (Swing)[swing];"
//    @"H is for (Helmet)[helmet];"
//    @"B is for (Bikini)[bikini];"
//    @"L is for (Lemondade)[lemondade];"
//    @"I is for (Ice Cube)[ice_cube];"
//    @"B is for (Broccoli)[broccoli];"
//    @"S is for (Sand)[sand];"
//    @"S is for (Scooter)[scooter];"
//    @"P is for (Picnic Table)[picnic_table];"
//    @"F is for (Fishing Pole)[fishing_pole];"
//    @"I is for (Ice Skates)[ice_skates];"
//    @"R is for (Rat)[rat];"
//    @"P is for (Palm Tree)[palm_tree];"
//    @"W is for (Whale)[whale];"
//    @"R is for (Road)[road];"
//    @"T is for (Tongue)[tongue];"
//    @"R is for (Rock)[rock];"
//    @"Z is for (Zebra)[zebra];"
//    @"I is for (Ice Skater)[ice_skater];"
//    @"R is for (Rollerblades)[rollerblades];"
//    @"S is for (Sand Castle)[sand_castle];"
//    @"N is for (Net)[net];"
//    @"D is for (Dolphin)[dolphin];"
//    @"B is for (Beach Ball)[beach_ball];"
//    @"B is for (Beach)[beach];"
//    @"D is for (Dessert)[dessert];"
//    @"S is for (Shirt)[shirt];"
//    @"H is for (Hose)[hose];"
//    @"S is for (Sunglasses)[sunglasses];"
//    @"S is for (Stick)[stick];"
//
//    @"E is for (Egg)[egg];"
//    @"C is for (Crayon)[crayon];"
//    @"G is for (Glasses)[eye_glasses];"
//    @"P is for (Pen)[pen];"
//    @"B is for (Bear)[bear];"
//    @"B is for (Butterfly)[butterfly];"
//    @"B is for (Barn)[barn];"
//    @"P is for (Popcorn)[popcorn];"
//    @"P is for (Pencil)[pencil];"
//    @"J is for (Jacket)[jacket];"
//    @"P is for (Pig)[pig];"
//    @"F is for (Fan)[fan];"
//    @"C is for (Candle)[candle];"
//    @"L is for (Lettuce)[lettuce];"
//    @"C is for (Coffee)[coffee];"
//    @"A is for (Accordion)[accordion];"
//    @"G is for (Gear)[gear];"
//    @"F is for (Farmer)[farmer];"
//    @"S is for (Snowflake)[snowflake];"
//    @"S is for (Shorts)[shorts];"
//    @"G is for (Gong)[gong];"
//    @"S is for (Safe)[safe];"
//    @"G is for (Gun)[gun];"
//    @"H is for (Hat)[hat];"
//    @"C is for (Chimney)[chimney];"
//    @"F is for (Finger)[finger];"
//    @"L is for (Log Cabin)[log_cabin];"
//    @"P is for (Pipe)[pipe];"
//    @"F is for (Fireworks)[fireworks];"
//    @"P is for (Picture Frame)[picture_frame];"
//    @"G is for (Gum)[gum];"
//    @"M is for (Mosquito)[mosquito];"
//    @"M is for (Microphone)[microphone];"
//    @"G is for (Goose)[goose];"
//    @"F is for (Feather)[feather];"
//    @"T is for (Teddy Bear)[teddy_bear];"
//    @"B is for (Broom)[broom];"
//    @"M is for (Moth)[moth];"
//    @"D is for (Duck)[duck];"
//    @"H is for (Hamburger)[hamburger];"
//    @"H is for (Horse)[horse];"
//    @"C is for (Cow)[cow];"
//    @"B is for (Bell)[bell];"
//    @"H is for (Horseshoe)[horseshoe];"
//    @"L is for (Lightbulb)[lightbulb];"
//    @"E is for (Eagle)[eagle];"
//    @"T is for (Toe)[toe];"
//    @"S is for (Spider)[spider];"
//    @"M is for (Mop)[mop];"
//    @"P is for (Pants)[pants];"
//    @"W is for (Wing)[wing];"
//    @"D is for (Dragon)[dragon];"
//    @"P is for (Printer)[printer];"
//    @"S is for (T-Shirt)[t_shirt];"
//
//    @"L is for (Label.)[label] T is for (Tag.)[label];"
//    @"A is for (Arm)[arm];"
//    @"M is for (Mailbox)[mailbox];"
//    @"P is for (Plate)[plate];"
//    @"L is for (Ladder)[ladder];"
//    @"T is for (Tire)[tire];"
//    @"S is for (Spoon)[spoon];"
//    @"Y is for (Yarn)[yarn];"
//    @"K is for (Knife)[knife];"
//    @"Z is for (Zipper)[zipper];"
//    @"U is for (Umbrella)[umbrella];"
//    @"L is for (Lollipop)[lollipop];"
//    @"C is for (Crab)[crab];"
//    @"H is for (Hammer)[hammer];"
//    @"B is for (Bowl)[bowl];"
//    @"D is for (Donut)[donut];"
//    @"T is for (Toilet)[toilet];"
//    @"T is for (Towel)[towel];"
//    @"F is for (Fire)[fire];"
//    @"S is for (Slingshot)[slingshot];"
//    @"P is for (Panda)[panda];"
//    @"O is for (Octopus)[octopus];"
//    @"R is for (Ring)[ring];"
//    @"B is for (Butter)[butter];"
//    @"N is for (Needle)[needle];"
//    @"B is for (Bicycle)[bicycle];"
//    @"N is for (Nail)[nail];"
//    @"C is for (Carrot Cake)[carrot_cake];"
//    @"T is for (Tooth)[tooth];"
//    @"T is for (Toilet Paper)[toilet_paper];"
//    @"R is for (Rocket)[rocket];"
//    @"C is for (Carrot)[carrot];"
//    @"W is for (Wrench)[wrench];"
//    @"E is for (Envelope)[envelope];"
//    @"C is for (Cotton Candy)[cotton_candy];"
//    @"W is for (Wheel)[wheel];"
//    @"S is for (Sock)[sock];"
//    @"H is for (Hair)[hair];"
//    @"D is for (Dumbbell)[dumbbell];"
//    @"I is for (Ice Cream)[ice_cream];"
//    @"S is for (Sink)[sink];"
//    @"M is for (Magnet)[magnet];"
//    @"B is for (Bathroom)[bathroom];"
//    @"B is for (Bread)[bread];"
//    @"K is for (Keyboard)[keyboard];"
//    @"B is for (Broom)[broom];"
//    @"B is for (Button)[button];"
//    @"C is for (Cheese)[cheese];"
//    @"H is for (High Heel)[high_heel];"
//    @"M is for (Motorcycle)[motorcycle];"
//    @"B is for (Baby)[baby];"
//    @"G is for (Gate)[gate];"
//    @"S is for (Shoe)[shoe];"
//    @"Y is for (Yawn)[yawn];"
//    @"L is for (Lemon)[lemon];"
//    @"M is for (Mouth)[mouth];"
//    @"P is for (Pear)[pear];"
//    @"B is for (Brain)[brain];"
//    @"K is for (Kitchen)[kitchen];"
//    @"R is for (Rope)[rope];"
//    @"F is for (Fork)[fork];"
//
//    @"S is for (Scissors)[scissors];"
//    @"T is for (Tomato)[tomato];"
//    @"F is for (Fox)[fox];"
//    @"T is for (Turtle)[turtle];"
//    @"H is for (Hot Dog)[hot_dog];"
//    @"L is for (Lock)[lock];"
//    @"P is for (Paper Clip)[paper_clip];"
//    @"K is for (Ketchup)[ketchup];"
//    @"S is for (Sea Turtle)[sea_turtle];"
//    @"T is for (Toolbox)[toolbox];"
//    @"C is for (Corn)[corn];"
//    @"S is for (Saturn)[saturn];"
//    @"C is for (Crown)[crown];"
//    @"A is for (Australia)[australia];"
//    @"A is for (Africa)[africa];"
//    @"D is for (Desk)[desk];"
//    @"M is for (Mirror)[mirror];"
//    @"T is for (Tiara)[tiara];"
//    @"C is for (Cabinet)[cabinet];"
//    @"C is for (Chair)[chair];"
//    @"B is for (Bucket)[bucket];"
//    @"S is for (Shovel)[shovel];"
//    @"D is for (Door)[door];"
//    @"L is for (Leopard)[leopard];"
//    @"D is for (Door Knob)[door_knob];"
//    @"T is for (Tape)[tape];"
//    @"E is for (Europe)[europe];"
//    @"M is for (Mouse)[mouse];"
//    @"B is for (Box)[box];"
//    @"P is for (Pizza)[pizza];"
//    @"G is for (Gorilla)[gorilla];"
//    @"S is for (Skirt)[skirt];"
//    @"W is for (Wall)[wall];"
//    @"S is for (Squirrel)[squirrel];"
//    @"S is for (Skunk)[skunk];"
//    @"S is for (Soap)[soap];"
//    @"P is for (Pineapple)[pineapple];"
//    @"B is for (Boat)[boat];"
//    @"U is for (USA)[usa];"
//    @"F is for (Fawn)[fawn];"
//    @"R is for (Neck Tie)[neck_tie];"
//    @"P is for (Painting)[painting];"
//    @"D is for (Dress)[dress];"
//    @"B is for (Book)[book];"
//    @"C is for (Cup)[cup];"
//    @"K is for (Kettle)[kettle];"
//    @"B is for (Banana)[banana];"
//    @"T is for (Telephone)[telephone];"
//    @"L is for (Lamp)[lamp];"
//    @"Q is for (Quilt)[quilt];"
//    @"T is for (Teacup)[teacup];"
//    @"T is for (Toothbrush)[toothbrush];"
//    @"B is for (Bow Tie)[bow_tie];"
//    @"T is for (Truck)[truck];"
//    @"S is for (Snake)[snake];"
//    @"R is for (Raccoon)[raccoon];"
//    @"E is for (Eel)[eel];"
//    @"K is for (Key)[key];"
//    @"T is for (Toothpaste)[toothpaste];"
//    @"B is for (Brick)[brick];"
//    @"E is for (Earth)[earth];"
//    @"M is for (Monkey)[monkey];"
//    @"T is for (Television)[tv];"
//    @"C is for (Cushion)[cushion];"
//    @"N is for (North America)[north_america];"
//    @"D is for (Deer)[deer];"
//    @"S is for (Ship)[ship];"
//    @"T is for (Table)[table];"
//    @"S is for (Stork)[stork];"
//    @"C is for (Computer)[computer];"
//    @"A is for (Asia)[asia];"
//    @"S is for (South America)[south_america];"
//    @"S is for (Sailboat)[sailboat];"
//    @"P is for (Pizza slice)[pizza_slice];"
//    @"G is for (Grapes)[grapes];"
//    @"N is for (Newspaper)[newspaper];"
//    @"P is for (Paper)[paper];"
//    @"B is for (Bed)[bed];"
//    @"J is for (Jupiter)[jupiter];"
//    @"R is for (Recycle Bin)[recycle_bin];"
//    @"C is for (Can)[can];"
//    @"T is for (Trash Can)[trash_can];"
//
//
//    @"S is for (Sword)[sword];"
//    @"F is for (Flag)[flag];"
//    @"S is for (Shield)[shield];"
//    @"A is for (Axe)[axe];"
//
//    @"D is for (Dog)[dog];"
//    @"C is for (Cat)[cat];"
//    @"R is for (Rooster)[rooster];"
//    @"H is for (Hen)[hen];"
//    @"P is for (Penguin)[penguin];"
//    @"E is for (Elephant)[elephant];"
//    @"L is for (Lion)[lion];"
//    @"T is for (Tiger)[tiger];"
//    @"H is for (Hamster)[hamster];"
//    @"A is for (Alligator)[alligator];"
//    @"A is for (Ant)[ant];"
//    @"B is for (Bee)[bee];"
//    @"B is for (Bird)[bird];"
//    @"B is for (Blue Bird)[blue_bird];"
//    @"H is for (Hippo)[hippo];"
//    @"P is for (Parrot)[parrot];"
//    @"R is for (Rhino)[rhino];"
//    @"S is for (Seagull)[seagull];"
//    @"W is for (Wasp)[wasp];"
//
//    @"F is for (Flower)[flower];"
//    @"G is for (Grass)[grass];"
//    @"T is for (Tree)[tree];"
//
//    @"B is for (Bottle)[bottle];"
//    @"C is for (Car)[car];"
//    @"T is for (Truck)[truck];"
//    @"H is for (House)[house];"
//    @"W is for (Window)[window];"
//
//
//    @"O is for (Orange)[orange_fruit];"
//    @"C is for (Cake)[cake];"
//    @"P is for (Pie)[cherry_pie];"
//    @"S is for (Sandwich)[sandwich];"
//    @"A is for (Apple)[apple];"
//    @"K is for (Kiwi)[kiwi];"
//    @"S is for (Strawberry)[strawberry];"
//    @"OJ is for (Orange Juice)[orange_juice];"
//
//    @"P is for (Piano)[piano];"
//    @"X is for (Xylophone)[xylophone];"
//    @"G is for (Guitar)[guitar];"
//    @"H is for (Harp)[harp];"
//
//    @"V is for (Violin)[violin];"
//    @"F is for (Flute)[flute];"
//    @"C is for (Clarinet)[clarinet];"
//    @"T is for (Trumpet)[trumpet];"
//    @"F is for (French Horn)[french_horn];"
//    @"T is for (Trombone)[trombone];"
//    @"D is for (Drum)[drum];"
//    @"O is for (Oboe)[oboe];"
//
//    @"P is for (Pink)[pink];"
//    @"R is for (Red)[red];"
//    @"O is for (Orange)[orange];"
//    @"Y is for (Yellow)[yellow];"
//    @"G is for (Green)[green];"
//    @"B is for (Blue)[blue];"
//    @"P is for (Purple)[purple];"
//    @"B is for (Black)[black];"
//    @"B is for (Brown)[brown];"
//    @"G is for (Gray)[gray];"
//
//    @"E is for (Eye)[eye];"
//    @"N is for (Nose)[nose];"
//    @"E is for (Ear)[ear];"
//    @"A is for (Ankle)[ankle];"
//    @"F is for (Foot)[foot];"
//    @"B is for (Ball)[ball];"
//    @"K is for (Knee)[knee];"
//
//    @"(Soccer Ball)[soccerball];"
//    @"(Soccer Field)[soccer_field];"
//    @"(Soccer Goal)[soccer_goal];"
//    @"(Soccer Boy)[soccer_boy];"
//    @"(Soccer Girl)[soccer_girl];"
//
//    @"(Cogsworth)[cogsworth] (likes)[like] (Lumiere.)[lumiere];"
//    @"(Belle)[belle] (likes)[like] (Aurora.)[aurora];"
//    @"(Belle)[belle] (likes)[like] (Chip.)[chip];"
//    @"(Cinderella)[cinderella] (likes)[like] (Gus.)[gus];"
//    @"(Gaston)[gaston] (likes)[like] (Basketball.)[basketball];"
//    @"(Maurice)[maurice] (likes)[like] (Baseball.)[baseball];"
//    @"(Chip)[chip] (likes)[like] (Basketball)[basketball] (and)[and] (Soccer.)[soccerball];"
//    @"(Lumiere)[lumiere] (likes)[like] (Tennis)[racquet] (and)[and] (Football.)[football];"
//
//    @"(Belle)[belle] (loves)[heart] (Music.)[music];"
//
//    @"H is for (Happy)[happy];"
//    @"S is for (Sad)[sad];"
//    @"L is for (Love)[heart];"
//    @"L is for (Like)[like];"
//
//    @"A is for (Anna)[anna];"
//    @"E is for (Elsa)[elsa];"
//    @"O is for (Olaf)[olaf];"
//    @"M is for (Maurice)[maurice];"
//    @"B is for (Belle)[belle];"
//    @"L is for (Lumiere)[lumiere];"
//    @"A is for (Aurora)[aurora];"
//    @"G is for (Gus)[gus];"
//    @"M is for (Mrs. Potts)[mrspotts];"
//    @"G is for (Gaston)[gaston];"
//    @"P is for (Prince Charming)[prince];"
//    @"C is for (Cogsworth)[cogsworth];"
//    @"M is for (Moon)[moon];"
//    @"S is for (Sun)[sun];"
//    @"T is for (Tennis)[racquet];"
//    @"C is for (Clock)[clock];"
//    @"B is for (Baseball)[baseball];"
//    @"S is for (Soccer)[soccerball];"
//    @"G is for (Goal)[soccer_goal];"
//    @"C is for (Cloud)[cloud];"
//    @"S is for (Star)[star];"
//    @"B is for (Brush)[scrub_brush];"
//    @"C is for (Cup)[cup];"
//
//    @"(Maurice)[maurice] is (surprised.)[surprised];"
//    @"(Lumiere)[lumiere] is (happy.)[happy];"
//    @"(Chip)[chip] is (happy.)[happy];"
//    @"(Aurora)[aurora] is (sad.)[sad];"
//    @"(Gus)[gus] is (happy.)[happy];"
//    @"(Mrs. Potts)[mrspotts] is (sad.)[sad];"
//    @"(Olaf)[olaf] is (happy.)[happy];"
//    @"(Elsa)[elsa] (likes)[like] (Olaf.)[olaf];"
//    @"(Anna)[anna] (loves)[heart] (Elsa.)[elsa];"
//
//    @"(Maurice)[maurice] (loves)[heart] (Belle.)[belle];"
//    @"(Belle)[belle] (loves)[heart] the (Beast.)[beast];"
//
//    @"(Cinderella)[cinderella] (loves)[heart] the (Prince.)[prince];"
//
//    @"(Cogsworth)[cogsworth] (loves)[heart] (Football.)[football];"
//    @"(Gus)[gus] (loves)[heart] (Basketball.)[basketball];"
//    @"The (Prince)[prince] (loves)[heart] (Soccer.)[soccerball];"
//    @"(Gaston)[gaston] (loves)[heart] (Tennis.)[racquet];"
//    @"(Gaston)[gaston] (loves)[heart] (Belle.)[belle];"
//    @"(Mrs. Potts)[mrspotts] (loves)[heart] (Chip.)[chip];"
//    @"(Mrs. Potts)[mrspotts] (and)[and] (Chip)[chip] (love)[heart] (Belle.)[belle];"
//
//    @"(Belle)[belle] (loves)[heart] the (night)[night] (time.)[clock];"
//    @"(Mrs. Potts)[mrspotts] (loves)[heart] the (day)[day] (time.)[clock];"
//
//    @"(Mrs. Potts)[mrspotts] (loves)[heart] (Chip)[chip] to the (moon)[moon] (and)[and] (back.)[back];"
//    @"(Gus)[gus] (loves)[heart] the (day)[day] (time)[clock] (and)[and] the (night)[night] (time.)[clock];"
//    @"(Belle)[belle] (loves)[heart] the (sun)[sun] (and)[and] the (moon.)[moon];"
//


                  @"(die Schulter)[shoulder];"
                  @"(das Flugzeug)[airplane];"
                  @"(der Panzer)[tank];"
                  @"(das Herz)[heart];"
                  @"(der Kragen)[collar];"
                  @"(die Treppe)[stairs];"
                  @"(die Serviette)[napkin];"
                  @"(der Engel)[angel];"
                  @"(der Pfeil)[arrow];"
                  @"(der Balkon)[balcony];"
                  @"(die Bandage)[bandage];"
                  @"(die Fliedermaus/Keule)[bat];"
                  @"(das Bier)[beer];"
                  @"(der Gürtel)[belt];"
                  @"(die Sitzbank)[bench];"
                  @"(die Bürste)[brush];"
                  @"(das Schloss)[castle];"
                  @"(die Kirsche)[cherry];"
                  @"(der Kamm)[comb];"
                  @"(der Kompass)[compass];"
                  @"(der Wurfpfeil)[dart];"
                  @"(die Augenbraue)[eyebrow];"
                  @"(der Zaun)[fence];"
                  @"(der Wald)[forest];"
                  @"(die Frucht/das Obst)[fruit];"
                  @"(der Schinken)[ham];"
                  @"(der Igel)[hedgehog];"
                  @"(der Hügel)[hill];"
                  @"(die Platthacke/-haue)[hoe];"
                  @"(die Insel)[island];"
                  @"(der Efeu)[ivy];"
                  @"(das Lamm)[lamb];"
                  @"(der Berg)[mountain];"
                  @"(das Heft)[notebook];"
                  @"(der Ofen)[oven];"
                  @"(die Eule)[owl];"
                  @"(der Pfad)[path];"
                  @"(der Kiefernzapfen)[pinecone];"
                  @"(der Teich)[pond];"
                  @"(der Pool)[pool];"
                  @"(das Stachelschwein)[porcupine];"
                  @"(der Topf)[pot];"
                  @"(die Pfütze)[puddle];"
                  @"(der Rechen)[rake];"
                  @"(der Fluss)[river];"
                  @"(das Betttuch)[sheet];"
                  @"(das Schild)[sign];"
                  @"(der Schwamm)[sponge];"
                  @"(der Herd)[stove];"
                  @"(der Stumpf)[stump];"
                  @"(das Sweatshirt)[sweatshirt];"
                  @"(der Turm)[tower];"
                  @"(der Truthahn)[turkey];"
                  @"(das Gewebe)[web];"
                  @"(die Windmühle)[windmill];"
                  @"(der Wein)[wine];"
                  @"(der Wurm)[worm];"

                  @"(der Elch)[moose];"
                  @"(das Sofa)[sofa];"
                  @"(der Hai)[shark];"
                  @"(die Saftpackung)[juice_box];"
                  @"(die Spielkarte)[card];"
                  @"(das Heu)[hay];"
                  @"(der Knochen)[bone];"
                  @"(das Fernglas)[binoculars];"
                  @"(die Rutschbahn)[slide];"
                  @"(der Pfau)[peacock];"
                  @"(die Pyramide)[pyramid];"
                  @"(die Kokosnuss)[coconut];"
                  @"(die Spielkarten)[cards];"
                  @"(der Radiergummi)[eraser];"
                  @"(die Trillerpfeife)[whistle];"
                  @"(die Achterbahn)[roller_coaster];"
                  @"(das Jojo)[yo_yo];"
                  @"(die Schaukel)[swing];"
                  @"(der Schutzhelm)[helmet];"
                  @"(der Bikini)[bikini];"
                  @"(die Zitronenlimonade)[lemondade];"
                  @"(der Eiswürfel)[ice_cube];"
                  @"(der Brokkoli)[broccoli];"
                  @"(der Sand)[sand];"
                  @"(der Roller)[scooter];"
                  @"(der Picknicktisch)[picnic_table];"
                  @"(die Angelrute)[fishing_pole];"
                  @"(die Schlitt-/Eislaufschuhe)[ice_skates];"
                  @"(die Ratte)[rat];"
                  @"(die Palme)[palm_tree];"
                  @"(der Wal)[whale];"
                  @"(die Straße/Fahrbahn)[road];"
                  @"(die Zunge)[tongue];"
                  @"(der Stein/Fels)[rock];"
                  @"(das Zebra)[zebra];"
                  @"(die Eisläuferin)[ice_skater];"
                  @"(die Inlineskates)[rollerblades];"
                  @"(die Sandburg)[sand_castle];"
                  @"(das Netz)[net];"
                  @"(der Delfin)[dolphin];"
                  @"(der Wasserball)[beach_ball];"
                  @"(der Strand)[beach];"
                  @"(der Nachtisch / die Nachspeise)[dessert];"
                  @"(das Hemd)[shirt];"
                  @"(der Schlauch)[hose];"
                  @"(die Sonnenbrille)[sunglasses];"
                  @"(die Stange)[stick];"
                  @"(das Ei)[egg];"
                  @"(der Buntstift)[crayon];"
                  @"(die Brille)[eye_glasses];"
                  @"(der Kugelschreiber)[pen];"
                  @"(der Bär)[bear];"
                  @"(der Schmetterling)[butterfly];"
                  @"(die Scheune)[barn];"
                  @"(das Popcorn)[popcorn];"
                  @"(der Bleistift)[pencil];"
                  @"(die Jacke)[jacket];"
                  @"(das Schwein)[pig];"
                  @"(der Lüfter)[fan];"
                  @"(die Kerze)[candle];"
                  @"(der Salat)[lettuce];"
                  @"(der Kaffee)[coffee];"
                  @"(das Akkordeon)[accordion];"
                  @"(das Zahnrad)[gear];"
                  @"(der Farmer)[farmer];"
                  @"(die Schneeflocke)[snowflake];"
                  @"(die Shorts)[shorts];"
                  @"(der Gong)[gong];"
                  @"(der Tresor)[safe];"
                  @"(die Schusswaffe / das Schießgewehr)[gun];"
                  @"(der Hut\n[huːt])[hat];"
                  @"(der Kamin)[chimney];"
                  @"(der Finger)[finger];"
                  @"(die Blockhütte)[log_cabin];"
                  @"(die Pfeife)[pipe];"
                  @"(das Feuerwerk)[fireworks];"
                  @"(der Bilderrahmen)[picture_frame];"
                  @"(der Kaugummi)[gum];"
                  @"(die Mücke)[mosquito];"
                  @"(das Mikrofon)[microphone];"
                  @"(die Gans)[goose];"
                  @"(die Feder)[feather];"
                  @"(das Kuscheltier)[teddy_bear];"
                  @"(der Besen)[broom];"
                  @"(die Motte)[moth];"
                  @"(die Ente)[duck];"
                  @"(der Hamburger)[hamburger];"
                  @"(das Pferd)[horse];"
                  @"(die Kuh)[cow];"
                  @"(die Glocke)[bell];"
                  @"(das Hufeisen)[horseshoe];"
                  @"(die Glühbirne)[lightbulb];"
                  @"(der Adler)[eagle];"
                  @"(der Zeh)[toe];"
                  @"(die Spinne)[spider];"
                  @"(der Mop)[mop];"
                  @"(die Hose)[pants];"
                  @"(der Flugel)[wing];"
                  @"(der Drache)[dragon];"
                  @"(der Drucker)[printer];"
                  @"(das T-Shirt)[t_shirt];"
                  @"(das Label/Etikett)[label];"
                  @"(der Arm)[arm];"
                  @"(das Postfach)[mailbox];"
                  @"(der Teller)[plate];"
                  @"(die Leiter)[ladder];"
                  @"(der Reifen)[tire];"
                  @"(der Löffel)[spoon];"
                  @"(das Garn)[yarn];"
                  @"(das Messer)[knife];"
                  @"(der Reißverschluss)[zipper];"
                  @"(der Regenschirm)[umbrella];"
                  @"(der Lutscher)[lollipop];"
                  @"(die Krabbe)[crab];"
                  @"(der Hammer)[hammer];"
                  @"(die Schüssel / der Napf)[bowl];"
                  @"(der Krapfen / Doghnut)[donut];"
                  @"(die Toilette)[toilet];"
                  @"(das Handtuch)[towel];"
                  @"(das Feuer)[fire];"
                  @"(die Schleuder)[slingshot];"
                  @"(der Panda)[panda];"
                  @"(die Krake)[octopus];"
                  @"(der Ring)[ring];"
                  @"(die Butter)[butter];"
                  @"(die Nadel)[needle];"
                  @"(das Fahrrad)[bicycle];"
                  @"(der Nagel)[nail];"
                  @"(der Karotten-/Möhrenkuchen)[carrot_cake];"
                  @"(der Zahn)[tooth];"
                  @"(das Toilettenpapier)[toilet_paper];"
                  @"(die Rakete)[rocket];"
                  @"(die Karotte/Möhre)[carrot];"
                  @"(der Schraubenschlüssel)[wrench];"
                  @"(der Briefumschlag)[envelope];"
                  @"(die Zuckerwatte)[cotton_candy];"
                  @"(das Rad)[wheel];"
                  @"(die Socke)[sock];"
                  @"(das Haar)[hair];"
                  @"(die Hantel)[dumbbell];"
                  @"(das Eis)[ice_cream];"
                  @"(die Spüle/das Spülbecken)[sink];"
                  @"(der Magnet)[magnet];"
                  @"(das Badezimmer)[bathroom];"
                  @"(das Brot)[bread];"
                  @"(die Tastatur)[keyboard];"
                  @"(der Knopf)[button];"
                  @"(der Käse)[cheese];"
                  @"(der Schuhabsatz)[high_heel];"
                  @"(das Motorrad)[motorcycle];"
                  @"(das Baby)[baby];"
                  @"(das Tor)[gate];"
                  @"(der Schuh)[shoe];"
                  @"(das Gähnen)[yawn];"
                  @"(die Zitrone)[lemon];"
                  @"(der Mund)[mouth];"
                  @"(die Birne)[pear];"
                  @"(das Hirn/Gehirn)[brain];"
                  @"(die Küche)[kitchen];"
                  @"(das Seil/das Tau)[rope];"
                  @"(die Schnur/die Saite\nder Bindfaden)[string];"
                  @"(die Gabel)[fork];"
                  @"(die Schere)[scissors];"
                  @"(die Tomate)[tomato];"
                  @"(der Fuchs)[fox];"
                  @"(die Schildkröte)[turtle];"
                  @"(das Würstchen/das Hotdog\nder Wiener)[hot_dog];"
                  @"(das Schloss)[lock];"
                  @"(die Aktenklammer)[paper_clip];"
                  @"(das Ketchup)[ketchup];"
                  @"(die Meeresschildkröte)[sea_turtle];"
                  @"(der Werkzeugkasten\ndie Wekzeugkiste)[toolbox];"
                  @"(das Korn\ndas Getreide\nder Mais)[corn];"
                  @"(der Saturn)[saturn];"
                  @"(die Krone)[crown];"
                  @"(das Australien)[australia];"
                  @"(das Afrika)[africa];"
                  @"(der Schreibtisch)[desk];"
                  @"(der Spiegel)[mirror];"
                  @"(das Diadem)[tiara];"
                  @"(der Aktenschrank)[cabinet];"
                  @"(der Stuhl)[chair];"
                  @"(der Eimer)[bucket];"
                  @"(die Schaufel)[shovel];"
                  @"(die Tür)[door];"
                  @"(der Leopard)[leopard];"
                  @"(der Türgriff\ndie Türklinke)[door_knob];"
                  @"(das Klebeband)[tape];"
                  @"(das Europa)[europe];"
                  @"(die Maus)[mouse];"
                  @"(die Box/die Büchse)[box];"
                  @"(die Pizza)[pizza];"
                  @"(der Gorilla)[gorilla];"
                  @"(der Rock)[skirt];"
                  @"(die Wand/die Mauer)[wall];"
                  @"(das Eichhörnchen)[squirrel];"
                  @"(das Stinktier)[skunk];"
                  @"(die Seife)[soap];"
                  @"(die Ananas)[pineapple];"
                  @"(das Boot)[boat];"
                  @"(die USA)[usa];"
                  @"(das Rehkitz/das Hirschkalb)[fawn];"
                  @"(die Krawatte)[neck_tie];"
                  @"(das Gemälde)[painting];"
                  @"(das Kleid)[dress];"
                  @"(das Buch)[book];"
                  @"(die Tasse/der Becher)[cup];"
                  @"(der Kessel)[kettle];"
                  @"(die Banane)[banana];"
                  @"(das Telefon)[telephone];"
                  @"(die Lampe)[lamp];"
                  @"(die Zierdecke)[quilt];"
                  @"(die Teetasse)[teacup];"
                  @"(die Zahnbürste)[toothbrush];"
                  @"(die Fliege)[bow_tie];"
                  @"(der Lastwagen)[truck];"
                  @"(die Schlange)[snake];"
                  @"(der Waschbär)[raccoon];"
                  @"(der Aal)[eel];"
                  @"(der Schlüssel)[key];"
                  @"(die Zahnpaste)[toothpaste];"
                  @"(der Ziegel)[brick];"
                  @"(die Erde)[earth];"
                  @"(der Affe)[monkey];"
                  @"(das Fernsehen)[tv];"
                  @"(das Kissen)[cushion];"
                  @"(das Nordamerika)[north_america];"
                  @"(der Hirsch/das Reh)[deer];"
                  @"(das Schiff)[ship];"
                  @"(der Tisch)[table];"
                  @"(der Storch)[stork];"
                  @"(der Computer/der Rechner)[computer];"
                  @"(das Asien)[asia];"
                  @"(das Südamerika)[south_america];"
                  @"(Das Segelboot)[sailboat];"
                  @"(das Pizza Stück)[pizza_slice];"
                  @"(die Traube)[grapes];"
                  @"(die Zeitung)[newspaper];"
                  @"(das Papier)[paper];"
                  @"(das Bett)[bed];"
                  @"(der Jupiter)[jupiter];"
                  @"(der Papierkorb)[recycle_bin];"
                  @"(die Dose)[can];"
                  @"(der Mülleimer)[trash_can];"
                  @"(das Schwert)[sword];"
                  @"(die Fahne/die Flagge)[flag];"
                  @"(der Schild)[shield];"
                  @"(die Axt/das Beil)[axe];"
                  @"(der Hund)[dog];"
                  @"(die Katze)[cat];"
                  @"(der Hahn)[rooster];"
                  @"(die Henne)[hen];"
                  @"(der Pinguin)[penguin];"
                  @"(der Elefant)[elephant];"
                  @"(der Löwe)[lion];"
                  @"(der Tiger)[tiger];"
                  @"(der Hamster)[hamster];"
                  @"(der Alligator)[alligator];"
                  @"(die Ameise)[ant];"
                  @"(die Biene)[bee];"
                  @"(der Vogel)[bird];"
                  @"(der Rotkehlhüttensänger)[blue_bird];"
                  @"(das Nilpferd)[hippo];"
                  @"(der Papagei)[parrot];"
                  @"(der Nashorn)[rhino];"
                  @"(die Möwe)[seagull];"
                  @"(die Wespe)[wasp];"
                  @"(die Blume/die Blüte)[flower];"
                  @"(das Gras)[grass];"
                  @"(der Baum)[tree];"
                  @"(die Flasche)[bottle];"
                  @"(der Wagen)[car];"
                  @"(das Haus)[house];"
                  @"(das Fenster)[window];"
                  @"(die Orange)[orange_fruit];"
                  @"(der Kuchen)[cake];"
                  @"(die Kirschtorte)[cherry_pie];"
                  @"(das Sandwich)[sandwich];"
                  @"(der Apfel)[apple];"
                  @"(die Kiwi)[kiwi];"
                  @"(die Erdbeere)[strawberry];"
                  @"(der Orangensaft)[orange_juice];"
                  @"(das Klavier)[piano];"
                  @"(das Xylophon)[xylophone];"
                  @"(die Gitarre)[guitar];"
                  @"(die Harfe)[harp];"
                  @"(die Geige/die Violine)[violin];"
                  @"(die Flöte)[flute];"
                  @"(die Klarinette)[clarinet];"
                  @"(die Trompete)[trumpet];"
                  @"(das Waldhorn)[french_horn];"
                  @"(die Posaune)[trombone];"
                  @"(die Trommel)[drum];"
                  @"(die Oboe)[oboe];"
                  @"(das Rosa)[pink];"
                  @"(das Rot)[red];"
                  @"(das Orange)[orange];"
                  @"(das Gelb)[yellow];"
                  @"(das Grün)[green];"
                  @"(das Blau)[blue];"
                  @"(das Purpurrot)[purple];"
                  @"(das Schwarz)[black];"
                  @"(das Braun)[brown];"
                  @"(das Grau)[gray];"
                  @"(das Auge)[eye];"
                  @"(die Nase)[nose];"
                  @"(das Ohr)[ear];"
                  @"(das Fußgelenk)[ankle];"
                  @"(der Fuß)[foot];"
                  @"(der Ball)[ball];"
                  @"(das Knie)[knee];"
                  @"(der Fußball)[soccerball];"
                  @"(das Feld)[soccer_field];"
                  @"(das Tor)[soccer_goal];"
                  @"(der Spieler)[soccer_boy];"
                  @"(die Spielerin)[soccer_girl];"
                  
                               error:nil];
    
}


- (void)viewWillAppear:(BOOL)animated {
    TDAssert(_tableView);
    if (NSNotFound != _selectedPageIndex) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:_selectedPageIndex inSection:0];
        [_tableView selectRowAtIndexPath:path animated:NO scrollPosition:UITableViewScrollPositionMiddle];
    }
}


- (void)viewDidAppear:(BOOL)animated {
    TDAssert(_tableView);
    if (NSNotFound != _selectedPageIndex) {
        NSIndexPath *path = [NSIndexPath indexPathForRow:_selectedPageIndex inSection:0];
        [_tableView deselectRowAtIndexPath:path animated:YES];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    StoryViewController *svc = [segue destinationViewController];
    TDAssert([svc isKindOfClass:[StoryViewController class]]);
    
    TDAssert(_story.pages);
    TDAssert(_selectedPageIndex < [_story.pages count]);
    TDAssert(_selectedPageIndex != NSNotFound);
    _story.pageIndex = _selectedPageIndex;
    svc.story = _story;
}


#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
    TDAssert(tv == _tableView);
    TDAssert(_story.pages);
    return [_story.pages count];
}


- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)path {
    TDAssert(tv == _tableView);
    UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:CELL_ID];
    
    if (!cell) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CELL_ID] autorelease];
    }
    
    NSUInteger idx = path.row;
    TDAssert(_story.pages);
    cell.textLabel.text = [_story.pages[idx] text];
    
    [cell setNeedsDisplay];
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tv didSelectRowAtIndexPath:(NSIndexPath *)path {
    TDAssert(tv == _tableView);
    self.selectedPageIndex = path.row;
    
    [self performSegueWithIdentifier:@"story" sender:tv];
}

@end
