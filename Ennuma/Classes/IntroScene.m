//
//  IntroScene.m
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright ennuma 2014年. All rights reserved.
//
// -----------------------------------------------------------------------

// Import the interfaces
#import "IntroScene.h"
#import "HelloWorldScene.h"
#import "XuanZheng.h"
#import "HouGong.h"
#import "HuangDi.h"
#import "GuoJia.h"
// -----------------------------------------------------------------------
#pragma mark - IntroScene
// -----------------------------------------------------------------------

@implementation IntroScene

// -----------------------------------------------------------------------
#pragma mark - Create & Destroy
// -----------------------------------------------------------------------
static IntroScene* sharedScene;
+ (IntroScene *)scene
{
    sharedScene = [[self alloc] init];
	return sharedScene;
}
+(IntroScene*)sharedScene
{
    return sharedScene;
}
// -----------------------------------------------------------------------

- (id)init
{
    // Apple recommend assigning self with supers return value
    self = [super init];
    if (!self) return(nil);
    
    // Create a colored background (Dark Grey)
    //CCNodeColor *background = [CCNodeColor nodeWithColor:[CCColor colorWithRed:0.2f green:0.2f blue:0.2f alpha:1.0f]];
    //[self addChild:background];
    CCSprite* bg = [CCSprite spriteWithImageNamed:@"huanggong.png"];
    bg.position = CGPointMake(bg.contentSize.width/2, bg.contentSize.height/2);
    [self addChild:bg];
    CGSize winsize = [[CCDirector sharedDirector] viewSize];
    CCLOG(@"%f,%f", winsize.width,winsize.height);
    
    // Hello world
    CCLabelTTF *label = [CCLabelTTF labelWithString:@"Hello World" fontName:@"Chalkduster" fontSize:36.0f];
    label.positionType = CCPositionTypeNormalized;
    label.color = [CCColor redColor];
    label.position = ccp(0.5f, 0.5f); // Middle of screen
    //[self addChild:label];
    
    // Helloworld scene button
    CCButton *helloWorldButton = [CCButton buttonWithTitle:@"[ Start ]" fontName:@"Verdana-Bold" fontSize:18.0f];
    helloWorldButton.positionType = CCPositionTypeNormalized;
    helloWorldButton.position = ccp(0.5f, 0.35f);
    [helloWorldButton setTarget:self selector:@selector(onSpinningClicked:)];
    //[self addChild:helloWorldButton];
    [self setUserInteractionEnabled:YES];
    // done
    xuanzheng = CGRectMake(386, 36, 465-386, 99-36);
    hougong = CGRectMake(99, 182, 230-99, 267-182);
    baixiyuan = CGRectMake(163, 35, 263-163, 105-35);
    wudaochang = CGRectMake(356, 212, 441-356, 282-212);
    [self loadData];
    [self refreshHuangDi];
	return self;
}
-(void)loadData
{
    day = 1;
    time = 1;
}
-(void)refreshHuangDi
{
    int marginleft = 50;
    int margintop = 50;
    int paddingbetween = 50;
    HuangDi* m_huangdi = [HuangDi sharedHuangDi];
    CCLabelTTF *label1 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"年龄： %i", m_huangdi.nianling] fontName:@"Chalkduster" fontSize:10.0f];
    label1.position = CGPointMake(self.contentSize.width-marginleft, self.contentSize.height-margintop);
    [self removeChildByName:@"nianling"];
    [self addChild:label1 z:0 name:@"nianling"];
    
    CCLabelTTF *label2 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"健康： %i", m_huangdi.jiankang] fontName:@"Chalkduster" fontSize:10.0f];
    label2.position = CGPointMake(self.contentSize.width-marginleft, label1.position.y-paddingbetween);
    [self removeChildByName:@"jiankang"];
    [self addChild:label2 z:0 name:@"jiankang"];
    
    CCLabelTTF *label3 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"体力： %i", m_huangdi.tili] fontName:@"Chalkduster" fontSize:10.0f];
    label3.position = CGPointMake(self.contentSize.width-marginleft, label2.position.y-paddingbetween);
    [self removeChildByName:@"tili"];
    [self addChild:label3 z:0 name:@"tili"];
    
    CCLabelTTF *label4 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"快乐： %i", m_huangdi.kuaile] fontName:@"Chalkduster" fontSize:10.0f];
    label4.position = CGPointMake(self.contentSize.width-marginleft, label3.position.y-paddingbetween);
    [self removeChildByName:@"kuaile"];
    [self addChild:label4 z:0 name:@"kuaile"];
    
    CCLabelTTF *label5 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"武力： %i", m_huangdi.wuli] fontName:@"Chalkduster" fontSize:10.0f];
    label5.position = CGPointMake(self.contentSize.width-marginleft, label4.position.y-paddingbetween);
    [self removeChildByName:@"wuli"];
    [self addChild:label5 z:0 name:@"wuli"];
    
    CCLabelTTF *label6 = [CCLabelTTF labelWithString:[NSString stringWithFormat:@"智力： %i", m_huangdi.zhili] fontName:@"Chalkduster" fontSize:10.0f];
    label6.position = CGPointMake(self.contentSize.width-marginleft, label5.position.y-paddingbetween);
    [self removeChildByName:@"zhili"];
    [self addChild:label6 z:0 name:@"zhili"];
}
-(void)passPhase
{
    time++;
    if (time>4) {
        time=1;
        day++;
    }
    [self refreshHuangDi];
}

-(void)onEnter
{
    CCLOG(@"day: %i, time: %i", day, time);
    [GuoJia sharedGuoJia];
    [super onEnter];
}
// -----------------------------------------------------------------------
#pragma mark - Button Callbacks
// -----------------------------------------------------------------------
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint touchpos = [touch locationInNode:self];
    //CCLOG(@"%f,%f",touchpos.x,touchpos.y);
    if (CGRectContainsPoint(xuanzheng, touchpos)) {
        CCScene* xuanZheng = [XuanZheng scene];
        [[CCDirector sharedDirector] pushScene:xuanZheng];
        CCLOG(@"xuanzheng");
    }
    else if(CGRectContainsPoint(hougong, touchpos))
    {
        CCScene* hougong = [HouGong sharedScene];
        [[CCDirector sharedDirector] pushScene:hougong];
        CCLOG(@"hougong");
    }
    else if(CGRectContainsPoint(baixiyuan, touchpos))
    {
        CCLOG(@"baixiyuan");
    }
    else if(CGRectContainsPoint(wudaochang, touchpos))
    {
        CCLOG(@"wudaochang");
    }
}
- (void)onSpinningClicked:(id)sender
{
    // start spinning scene with transition
    [[CCDirector sharedDirector] replaceScene:[HelloWorldScene scene]
                               withTransition:[CCTransition transitionPushWithDirection:CCTransitionDirectionLeft duration:1.0f]];
}

// -----------------------------------------------------------------------
@end
