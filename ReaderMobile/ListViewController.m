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
                     [parser parseString:@"(Mrs. Potts)[mrspotts] is from (Great Britain)[british_flag];" error:nil],
                     [parser parseString:@"(Merida)[merida] is from (Ireland)[irish_flag];" error:nil],
                     [parser parseString:@"(Lumiere)[lumiere] is from (France)[french_flag];" error:nil],
                     [parser parseString:@"(Rapunzel)[rapunzel] is from (Germany)[german_flag];" error:nil],
                     [parser parseString:@"(Hercules)[hercules] is from (Greece)[greek_flag];" error:nil],
                     [parser parseString:@"(Belle)[belle] is from (France)[french_flag];" error:nil],
                     [parser parseString:@"(Cogsworth)[cogsworth] is from (Great Britain)[british_flag];" error:nil],
                     [parser parseString:@"(Elsa)[elsa] is from (Norway)[norwegian_flag];" error:nil],
                     [parser parseString:@"(Gaston)[gaston] is from (France)[french_flag];" error:nil],
                     [parser parseString:@"(Mulan)[mulan] is from (China)[chinese_flag];" error:nil],
                     [parser parseString:@"(Flynn)[flynn] is from (Germany)[german_flag];" error:nil],
                     [parser parseString:@"(Anna)[anna] is from (Norway)[norwegian_flag];" error:nil],
                     [parser parseString:@"(Maurice)[maurice] is from (France)[french_flag];" error:nil],
                     [parser parseString:@"(Snow White)[snow_white] is from (Germany)[german_flag];" error:nil],
                     [parser parseString:@"(Olaf)[olaf] is from (Norway)[norwegian_flag];" error:nil],
                     [parser parseString:@"(Mushu)[mushu] is from (China)[chinese_flag];" error:nil],

                     [parser parseString:@"M is for (Moose)[moose];" error:nil],
                     [parser parseString:@"S is for (Sofa)[sofa];" error:nil],
                     [parser parseString:@"S is for (Shark)[shark];" error:nil],
                     [parser parseString:@"J is for (Juice Box)[juice_box];" error:nil],
                     [parser parseString:@"C is for (Card)[card];" error:nil],
                     [parser parseString:@"H is for (Hay)[hay];" error:nil],
                     [parser parseString:@"B is for (Bone)[bone];" error:nil],
                     [parser parseString:@"B is for (Binoculars)[binoculars];" error:nil],
                     [parser parseString:@"S is for (Slide)[slide];" error:nil],
                     [parser parseString:@"P is for (Peacock)[peacock];" error:nil],
                     [parser parseString:@"P is for (Pyramid)[pyramid];" error:nil],
                     [parser parseString:@"C is for (Coconut)[coconut];" error:nil],
                     [parser parseString:@"C is for (Cards)[cards];" error:nil],
                     [parser parseString:@"E is for (Eraser)[eraser];" error:nil],
                     [parser parseString:@"W is for (Whistle)[whistle];" error:nil],
                     [parser parseString:@"R is for (Roller Coaster)[roller_coaster];" error:nil],
                     [parser parseString:@"Y is for (Yo-Yo)[yo_yo];" error:nil],
                     [parser parseString:@"S is for (Swing)[swing];" error:nil],
                     [parser parseString:@"H is for (Helmet)[helmet];" error:nil],
                     [parser parseString:@"B is for (Bikini)[bikini];" error:nil],
                     [parser parseString:@"L is for (Lemondade)[lemondade];" error:nil],
                     [parser parseString:@"I is for (Ice Cube)[ice_cube];" error:nil],
                     [parser parseString:@"B is for (Broccoli)[broccoli];" error:nil],
                     [parser parseString:@"S is for (Sand)[sand];" error:nil],
                     [parser parseString:@"S is for (Scooter)[scooter];" error:nil],
                     [parser parseString:@"P is for (Picnic Table)[picnic_table];" error:nil],
                     [parser parseString:@"F is for (Fishing Pole)[fishing_pole];" error:nil],
                     [parser parseString:@"I is for (Ice Skates)[ice_skates];" error:nil],
                     [parser parseString:@"R is for (Rat)[rat];" error:nil],
                     [parser parseString:@"P is for (Palm Tree)[palm_tree];" error:nil],
                     [parser parseString:@"W is for (Whale)[whale];" error:nil],
                     [parser parseString:@"R is for (Road)[road];" error:nil],
                     [parser parseString:@"T is for (Tongue)[tongue];" error:nil],
                     [parser parseString:@"R is for (Rock)[rock];" error:nil],
                     [parser parseString:@"Z is for (Zebra)[zebra];" error:nil],
                     [parser parseString:@"I is for (Ice Skater)[ice_skater];" error:nil],
                     [parser parseString:@"R is for (Rollerblades)[rollerblades];" error:nil],
                     [parser parseString:@"S is for (Sand Castle)[sand_castle];" error:nil],
                     [parser parseString:@"N is for (Net)[net];" error:nil],
                     [parser parseString:@"D is for (Dolphin)[dolphin];" error:nil],
                     [parser parseString:@"B is for (Beach Ball)[beach_ball];" error:nil],
                     [parser parseString:@"B is for (Beach)[beach];" error:nil],
                     [parser parseString:@"D is for (Dessert)[dessert];" error:nil],
                     [parser parseString:@"S is for (Shirt)[shirt];" error:nil],
                     [parser parseString:@"H is for (Hose)[hose];" error:nil],
                     [parser parseString:@"S is for (Sunglasses)[sunglasses];" error:nil],
                     [parser parseString:@"S is for (Stick)[stick];" error:nil],
                     
                     [parser parseString:@"E is for (Egg)[egg];" error:nil],
                     [parser parseString:@"C is for (Crayon)[crayon];" error:nil],
                     [parser parseString:@"G is for (Glasses)[eye_glasses];" error:nil],
                     [parser parseString:@"P is for (Pen)[pen];" error:nil],
                     [parser parseString:@"B is for (Bear)[bear];" error:nil],
                     [parser parseString:@"B is for (Butterfly)[butterfly];" error:nil],
                     [parser parseString:@"B is for (Barn)[barn];" error:nil],
                     [parser parseString:@"P is for (Popcorn)[popcorn];" error:nil],
                     [parser parseString:@"P is for (Pencil)[pencil];" error:nil],
                     [parser parseString:@"J is for (Jacket)[jacket];" error:nil],
                     [parser parseString:@"P is for (Pig)[pig];" error:nil],
                     [parser parseString:@"F is for (Fan)[fan];" error:nil],
                     [parser parseString:@"C is for (Candle)[candle];" error:nil],
                     [parser parseString:@"L is for (Lettuce)[lettuce];" error:nil],
                     [parser parseString:@"C is for (Coffee)[coffee];" error:nil],
                     [parser parseString:@"A is for (Accordion)[accordion];" error:nil],
                     [parser parseString:@"G is for (Gear)[gear];" error:nil],
                     [parser parseString:@"F is for (Farmer)[farmer];" error:nil],
                     [parser parseString:@"S is for (Snowflake)[snowflake];" error:nil],
                     [parser parseString:@"S is for (Shorts)[shorts];" error:nil],
                     [parser parseString:@"G is for (Gong)[gong];" error:nil],
                     [parser parseString:@"S is for (Safe)[safe];" error:nil],
                     [parser parseString:@"G is for (Gun)[gun];" error:nil],
                     [parser parseString:@"H is for (Hat)[hat];" error:nil],
                     [parser parseString:@"C is for (Chimney)[chimney];" error:nil],
                     [parser parseString:@"F is for (Finger)[finger];" error:nil],
                     [parser parseString:@"L is for (Log Cabin)[log_cabin];" error:nil],
                     [parser parseString:@"P is for (Pipe)[pipe];" error:nil],
                     [parser parseString:@"F is for (Fireworks)[fireworks];" error:nil],
                     [parser parseString:@"P is for (Picture Frame)[picture_frame];" error:nil],
                     [parser parseString:@"G is for (Gum)[gum];" error:nil],
                     [parser parseString:@"M is for (Mosquito)[mosquito];" error:nil],
                     [parser parseString:@"M is for (Microphone)[microphone];" error:nil],
                     [parser parseString:@"G is for (Goose)[goose];" error:nil],
                     [parser parseString:@"F is for (Feather)[feather];" error:nil],
                     [parser parseString:@"T is for (Teddy Bear)[teddy_bear];" error:nil],
                     [parser parseString:@"B is for (Broom)[broom];" error:nil],
                     [parser parseString:@"M is for (Moth)[moth];" error:nil],
                     [parser parseString:@"D is for (Duck)[duck];" error:nil],
                     [parser parseString:@"H is for (Hamburger)[hamburger];" error:nil],
                     [parser parseString:@"H is for (Horse)[horse];" error:nil],
                     [parser parseString:@"C is for (Cow)[cow];" error:nil],
                     [parser parseString:@"B is for (Bell)[bell];" error:nil],
                     [parser parseString:@"H is for (Horseshoe)[horseshoe];" error:nil],
                     [parser parseString:@"L is for (Lightbulb)[lightbulb];" error:nil],
                     [parser parseString:@"E is for (Eagle)[eagle];" error:nil],
                     [parser parseString:@"T is for (Toe)[toe];" error:nil],
                     [parser parseString:@"S is for (Spider)[spider];" error:nil],
                     [parser parseString:@"M is for (Mop)[mop];" error:nil],
                     [parser parseString:@"P is for (Pants)[pants];" error:nil],
                     [parser parseString:@"W is for (Wing)[wing];" error:nil],
                     [parser parseString:@"D is for (Dragon)[dragon];" error:nil],
                     [parser parseString:@"P is for (Printer)[printer];" error:nil],
                     [parser parseString:@"S is for (T-Shirt)[t_shirt];" error:nil],

                     [parser parseString:@"L is for (Label.)[label] T is for (Tag.)[label];" error:nil],
                     [parser parseString:@"A is for (Arm)[arm];" error:nil],
                     [parser parseString:@"M is for (Mailbox)[mailbox];" error:nil],
                     [parser parseString:@"P is for (Plate)[plate];" error:nil],
                     [parser parseString:@"L is for (Ladder)[ladder];" error:nil],
                     [parser parseString:@"T is for (Tire)[tire];" error:nil],
                     [parser parseString:@"S is for (Spoon)[spoon];" error:nil],
                     [parser parseString:@"Y is for (Yarn)[yarn];" error:nil],
                     [parser parseString:@"K is for (Knife)[knife];" error:nil],
                     [parser parseString:@"Z is for (Zipper)[zipper];" error:nil],
                     [parser parseString:@"U is for (Umbrella)[umbrella];" error:nil],
                     [parser parseString:@"L is for (Lollipop)[lollipop];" error:nil],
                     [parser parseString:@"C is for (Crab)[crab];" error:nil],
                     [parser parseString:@"H is for (Hammer)[hammer];" error:nil],
                     [parser parseString:@"B is for (Bowl)[bowl];" error:nil],
                     [parser parseString:@"D is for (Donut)[donut];" error:nil],
                     [parser parseString:@"T is for (Toilet)[toilet];" error:nil],
                     [parser parseString:@"T is for (Towel)[towel];" error:nil],
                     [parser parseString:@"F is for (Fire)[fire];" error:nil],
                     [parser parseString:@"S is for (Slingshot)[slingshot];" error:nil],
                     [parser parseString:@"P is for (Panda)[panda];" error:nil],
                     [parser parseString:@"O is for (Octopus)[octopus];" error:nil],
                     [parser parseString:@"R is for (Ring)[ring];" error:nil],
                     [parser parseString:@"B is for (Butter)[butter];" error:nil],
                     [parser parseString:@"N is for (Needle)[needle];" error:nil],
                     [parser parseString:@"B is for (Bicycle)[bicycle];" error:nil],
                     [parser parseString:@"N is for (Nail)[nail];" error:nil],
                     [parser parseString:@"C is for (Carrot Cake)[carrot_cake];" error:nil],
                     [parser parseString:@"T is for (Tooth)[tooth];" error:nil],
                     [parser parseString:@"T is for (Toilet Paper)[toilet_paper];" error:nil],
                     [parser parseString:@"R is for (Rocket)[rocket];" error:nil],
                     [parser parseString:@"C is for (Carrot)[carrot];" error:nil],
                     [parser parseString:@"W is for (Wrench)[wrench];" error:nil],
                     [parser parseString:@"E is for (Envelope)[envelope];" error:nil],
                     [parser parseString:@"C is for (Cotton Candy)[cotton_candy];" error:nil],
                     [parser parseString:@"W is for (Wheel)[wheel];" error:nil],
                     [parser parseString:@"S is for (Sock)[sock];" error:nil],
                     [parser parseString:@"H is for (Hair)[hair];" error:nil],
                     [parser parseString:@"D is for (Dumbbell)[dumbbell];" error:nil],
                     [parser parseString:@"I is for (Ice Cream)[ice_cream];" error:nil],
                     [parser parseString:@"S is for (Sink)[sink];" error:nil],
                     [parser parseString:@"M is for (Magnet)[magnet];" error:nil],
                     [parser parseString:@"B is for (Bathroom)[bathroom];" error:nil],
                     [parser parseString:@"B is for (Bread)[bread];" error:nil],
                     [parser parseString:@"K is for (Keyboard)[keyboard];" error:nil],
                     [parser parseString:@"B is for (Broom)[broom];" error:nil],
                     [parser parseString:@"B is for (Button)[button];" error:nil],
                     [parser parseString:@"C is for (Cheese)[cheese];" error:nil],
                     [parser parseString:@"H is for (High Heel)[high_heel];" error:nil],
                     [parser parseString:@"M is for (Motorcycle)[motorcycle];" error:nil],
                     [parser parseString:@"B is for (Baby)[baby];" error:nil],
                     [parser parseString:@"G is for (Gate)[gate];" error:nil],
                     [parser parseString:@"S is for (Shoe)[shoe];" error:nil],
                     [parser parseString:@"Y is for (Yawn)[yawn];" error:nil],
                     [parser parseString:@"L is for (Lemon)[lemon];" error:nil],
                     [parser parseString:@"M is for (Mouth)[mouth];" error:nil],
                     [parser parseString:@"P is for (Pear)[pear];" error:nil],
                     [parser parseString:@"B is for (Brain)[brain];" error:nil],
                     [parser parseString:@"K is for (Kitchen)[kitchen];" error:nil],
                     [parser parseString:@"R is for (Rope)[rope];" error:nil],
                     [parser parseString:@"F is for (Fork)[fork];" error:nil],
                     
                     [parser parseString:@"S is for (Scissors)[scissors];" error:nil],
                     [parser parseString:@"T is for (Tomato)[tomato];" error:nil],
                     [parser parseString:@"F is for (Fox)[fox];" error:nil],
                     [parser parseString:@"T is for (Turtle)[turtle];" error:nil],
                     [parser parseString:@"H is for (Hot Dog)[hot_dog];" error:nil],
                     [parser parseString:@"L is for (Lock)[lock];" error:nil],
                     [parser parseString:@"P is for (Paper Clip)[paper_clip];" error:nil],
                     [parser parseString:@"K is for (Ketchup)[ketchup];" error:nil],
                     [parser parseString:@"S is for (Sea Turtle)[sea_turtle];" error:nil],
                     [parser parseString:@"T is for (Toolbox)[toolbox];" error:nil],
                     [parser parseString:@"C is for (Corn)[corn];" error:nil],
                     [parser parseString:@"S is for (Saturn)[saturn];" error:nil],
                     [parser parseString:@"C is for (Crown)[crown];" error:nil],
                     [parser parseString:@"A is for (Australia)[australia];" error:nil],
                     [parser parseString:@"A is for (Africa)[africa];" error:nil],
                     [parser parseString:@"D is for (Desk)[desk];" error:nil],
                     [parser parseString:@"M is for (Mirror)[mirror];" error:nil],
                     [parser parseString:@"T is for (Tiara)[tiara];" error:nil],
                     [parser parseString:@"C is for (Cabinet)[cabinet];" error:nil],
                     [parser parseString:@"C is for (Chair)[chair];" error:nil],
                     [parser parseString:@"B is for (Bucket)[bucket];" error:nil],
                     [parser parseString:@"S is for (Shovel)[shovel];" error:nil],
                     [parser parseString:@"D is for (Door)[door];" error:nil],
                     [parser parseString:@"L is for (Leopard)[leopard];" error:nil],
                     [parser parseString:@"D is for (Door Knob)[door_knob];" error:nil],
                     [parser parseString:@"T is for (Tape)[tape];" error:nil],
                     [parser parseString:@"E is for (Europe)[europe];" error:nil],
                     [parser parseString:@"M is for (Mouse)[mouse];" error:nil],
                     [parser parseString:@"B is for (Box)[box];" error:nil],
                     [parser parseString:@"P is for (Pizza)[pizza];" error:nil],
                     [parser parseString:@"G is for (Gorilla)[gorilla];" error:nil],
                     [parser parseString:@"S is for (Skirt)[skirt];" error:nil],
                     [parser parseString:@"W is for (Wall)[wall];" error:nil],
                     [parser parseString:@"S is for (Squirrel)[squirrel];" error:nil],
                     [parser parseString:@"S is for (Skunk)[skunk];" error:nil],
                     [parser parseString:@"S is for (Soap)[soap];" error:nil],
                     [parser parseString:@"P is for (Pineapple)[pineapple];" error:nil],
                     [parser parseString:@"B is for (Boat)[boat];" error:nil],
                     [parser parseString:@"U is for (USA)[usa];" error:nil],
                     [parser parseString:@"F is for (Fawn)[fawn];" error:nil],
                     [parser parseString:@"R is for (Neck Tie)[neck_tie];" error:nil],
                     [parser parseString:@"P is for (Painting)[painting];" error:nil],
                     [parser parseString:@"D is for (Dress)[dress];" error:nil],
                     [parser parseString:@"B is for (Book)[book];" error:nil],
                     [parser parseString:@"C is for (Cup)[cup];" error:nil],
                     [parser parseString:@"K is for (Kettle)[kettle];" error:nil],
                     [parser parseString:@"B is for (Banana)[banana];" error:nil],
                     [parser parseString:@"T is for (Telephone)[telephone];" error:nil],
                     [parser parseString:@"L is for (Lamp)[lamp];" error:nil],
                     [parser parseString:@"Q is for (Quilt)[quilt];" error:nil],
                     [parser parseString:@"T is for (Teacup)[teacup];" error:nil],
                     [parser parseString:@"T is for (Toothbrush)[toothbrush];" error:nil],
                     [parser parseString:@"B is for (Bow Tie)[bow_tie];" error:nil],
                     [parser parseString:@"T is for (Truck)[truck];" error:nil],
                     [parser parseString:@"S is for (Snake)[snake];" error:nil],
                     [parser parseString:@"R is for (Racoon)[racoon];" error:nil],
                     [parser parseString:@"E is for (Eel)[eel];" error:nil],
                     [parser parseString:@"K is for (Key)[key];" error:nil],
                     [parser parseString:@"T is for (Toothpaste)[toothpaste];" error:nil],
                     [parser parseString:@"B is for (Brick)[brick];" error:nil],
                     [parser parseString:@"E is for (Earth)[earth];" error:nil],
                     [parser parseString:@"M is for (Monkey)[monkey];" error:nil],
                     [parser parseString:@"T is for (Television)[tv];" error:nil],
                     [parser parseString:@"C is for (Cushion)[cushion];" error:nil],
                     [parser parseString:@"N is for (North America)[north_america];" error:nil],
                     [parser parseString:@"D is for (Deer)[deer];" error:nil],
                     [parser parseString:@"S is for (Ship)[ship];" error:nil],
                     [parser parseString:@"T is for (Table)[table];" error:nil],
                     [parser parseString:@"S is for (Stork)[stork];" error:nil],
                     [parser parseString:@"C is for (Computer)[computer];" error:nil],
                     [parser parseString:@"A is for (Asia)[asia];" error:nil],
                     [parser parseString:@"S is for (South America)[south_america];" error:nil],
                     [parser parseString:@"S is for (Sailboat)[sailboat];" error:nil],
                     [parser parseString:@"P is for (Pizza slice)[pizza_slice];" error:nil],
                     [parser parseString:@"G is for (Grapes)[grapes];" error:nil],
                     [parser parseString:@"N is for (Newspaper)[newspaper];" error:nil],
                     [parser parseString:@"P is for (Paper)[paper];" error:nil],
                     [parser parseString:@"B is for (Bed)[bed];" error:nil],
                     [parser parseString:@"J is for (Jupiter)[jupiter];" error:nil],
                     [parser parseString:@"R is for (Recycle Bin)[recycle_bin];" error:nil],
                     [parser parseString:@"C is for (Can)[can];" error:nil],
                     [parser parseString:@"T is for (Trash Can)[trash_can];" error:nil],
                     

                     [parser parseString:@"S is for (Sword)[sword];" error:nil],
                     [parser parseString:@"F is for (Flag)[flag];" error:nil],
                     [parser parseString:@"S is for (Shield)[shield];" error:nil],
                     [parser parseString:@"A is for (Axe)[axe];" error:nil],

                     [parser parseString:@"D is for (Dog)[dog];" error:nil],
                     [parser parseString:@"C is for (Cat)[cat];" error:nil],
                     [parser parseString:@"R is for (Rooster)[rooster];" error:nil],
                     [parser parseString:@"H is for (Hen)[hen];" error:nil],
                     [parser parseString:@"P is for (Penguin)[penguin];" error:nil],
                     [parser parseString:@"E is for (Elephant)[elephant];" error:nil],
                     [parser parseString:@"L is for (Lion)[lion];" error:nil],
                     [parser parseString:@"T is for (Tiger)[tiger];" error:nil],
                     [parser parseString:@"H is for (Hamster)[hamster];" error:nil],
                     [parser parseString:@"A is for (Alligator)[alligator];" error:nil],
                     [parser parseString:@"A is for (Ant)[ant];" error:nil],
                     [parser parseString:@"B is for (Bee)[bee];" error:nil],
                     [parser parseString:@"B is for (Bird)[bird];" error:nil],
                     [parser parseString:@"B is for (Blue Bird)[blue_bird];" error:nil],
                     [parser parseString:@"H is for (Hippo)[hippo];" error:nil],
                     [parser parseString:@"P is for (Parrot)[parrot];" error:nil],
                     [parser parseString:@"R is for (Rhino)[rhino];" error:nil],
                     [parser parseString:@"S is for (Seagull)[seagull];" error:nil],
                     [parser parseString:@"W is for (Wasp)[wasp];" error:nil],

                     [parser parseString:@"F is for (Flower)[flower];" error:nil],
                     [parser parseString:@"G is for (Grass)[grass];" error:nil],
                     [parser parseString:@"T is for (Tree)[tree];" error:nil],
                     
                     [parser parseString:@"B is for (Bottle)[bottle];" error:nil],
                     [parser parseString:@"C is for (Car)[car];" error:nil],
                     [parser parseString:@"T is for (Truck)[truck];" error:nil],
                     [parser parseString:@"H is for (House)[house];" error:nil],
                     [parser parseString:@"W is for (Window)[window];" error:nil],

                     
                     [parser parseString:@"O is for (Orange)[orange_fruit];" error:nil],
                     [parser parseString:@"C is for (Cake)[cake];" error:nil],
                     [parser parseString:@"P is for (Pie)[cherry_pie];" error:nil],
                     [parser parseString:@"S is for (Sandwich)[sandwich];" error:nil],
                     [parser parseString:@"A is for (Apple)[apple];" error:nil],
                     [parser parseString:@"K is for (Kiwi)[kiwi];" error:nil],
                     [parser parseString:@"S is for (Strawberry)[strawberry];" error:nil],
                     [parser parseString:@"OJ is for (Orange Juice)[orange_juice];" error:nil],

                     [parser parseString:@"P is for (Piano)[piano];" error:nil],
                     [parser parseString:@"X is for (Xylophone)[xylophone];" error:nil],
                     [parser parseString:@"G is for (Guitar)[guitar];" error:nil],
                     [parser parseString:@"H is for (Harp)[harp];" error:nil],

                     [parser parseString:@"V is for (Violin)[violin];" error:nil],
                     [parser parseString:@"F is for (Flute)[flute];" error:nil],
                     [parser parseString:@"C is for (Clarinet)[clarinet];" error:nil],
                     [parser parseString:@"T is for (Trumpet)[trumpet];" error:nil],
                     [parser parseString:@"F is for (French Horn)[french_horn];" error:nil],
                     [parser parseString:@"T is for (Trombone)[trombone];" error:nil],
                     [parser parseString:@"D is for (Drum)[drum];" error:nil],
                     [parser parseString:@"O is for (Oboe)[oboe];" error:nil],
                     
                     [parser parseString:@"P is for (Pink)[pink];" error:nil],
                     [parser parseString:@"R is for (Red)[red];" error:nil],
                     [parser parseString:@"O is for (Orange)[orange];" error:nil],
                     [parser parseString:@"Y is for (Yellow)[yellow];" error:nil],
                     [parser parseString:@"G is for (Green)[green];" error:nil],
                     [parser parseString:@"B is for (Blue)[blue];" error:nil],
                     [parser parseString:@"P is for (Purple)[purple];" error:nil],
                     [parser parseString:@"B is for (Black)[black];" error:nil],
                     [parser parseString:@"B is for (Brown)[brown];" error:nil],
                     [parser parseString:@"G is for (Gray)[gray];" error:nil],
                     
                     [parser parseString:@"E is for (Eye)[eye];" error:nil],
                     [parser parseString:@"N is for (Nose)[nose];" error:nil],
                     [parser parseString:@"E is for (Ear)[ear];" error:nil],
                     [parser parseString:@"A is for (Ankle)[ankle];" error:nil],
                     [parser parseString:@"F is for (Foot)[foot];" error:nil],
                     [parser parseString:@"B is for (Ball)[ball];" error:nil],
                     [parser parseString:@"K is for (Knee)[knee];" error:nil],
                     
                     [parser parseString:@"(Soccer Ball)[soccerball];" error:nil],
                     [parser parseString:@"(Soccer Field)[soccer_field];" error:nil],
                     [parser parseString:@"(Soccer Goal)[soccer_goal];" error:nil],
                     [parser parseString:@"(Soccer Boy)[soccer_boy];" error:nil],
                     [parser parseString:@"(Soccer Girl)[soccer_girl];" error:nil],
                     
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
                     [parser parseString:@"C is for (Cup)[cup];" error:nil],

                     [parser parseString:@"(Maurice)[maurice] is (surprised.)[surprised];" error:nil],
                     [parser parseString:@"(Lumiere)[lumiere] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Chip)[chip] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Aurora)[aurora] is (sad.)[sad];" error:nil],
                     [parser parseString:@"(Gus)[gus] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Mrs. Potts)[mrspotts] is (sad.)[sad];" error:nil],
                     [parser parseString:@"(Olaf)[olaf] is (happy.)[happy];" error:nil],
                     [parser parseString:@"(Elsa)[elsa] (likes)[like] (Olaf.)[olaf];" error:nil],
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

                    [parser parseString:@"(das Auge)[eye];" error:nil],
                    [parser parseString:@"(das Ohr)[ear];" error:nil],
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
