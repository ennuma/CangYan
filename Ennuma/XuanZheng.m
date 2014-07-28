//
//  XuanZheng.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-27.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "XuanZheng.h"
#import "IntroScene.h"
#import "HuangDi.h"
@implementation XuanZheng
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    exit = [CCSprite spriteWithImageNamed:@"Hero.png"];
    exit.position = CGPointMake(exit.contentSize.width/2, exit.contentSize.height/2);
    [self addChild:exit z:1];
    
    CCSprite* bg = [CCSprite spriteWithImageNamed:@"xuanzheng.png"];
    bg.position = CGPointMake(bg.contentSize.width/2, bg.contentSize.height/2);
    [self addChild:bg];
    
    officier = CGRectMake(32, 41, 91-32, 92-41);
    people = CGRectMake(102, 36, 162-102, 94-26);
    custom = CGRectMake(172, 36, 239-172, 92-36);
    war = CGRectMake(255, 39, 317-255, 92-39);
    prison = CGRectMake(330, 38, 397-330, 90-38);
    build = CGRectMake(412, 35, 487-412, 92-35);
    
    CCButton* kaikekaoshi = [CCButton buttonWithTitle:@"开科考试"];
    CCButton* diaohuanguanyuan = [CCButton buttonWithTitle:@"调换官员"];
    CCButton* fengjue = [CCButton buttonWithTitle:@"封爵"];
    CCButton* qinglixianguan = [CCButton buttonWithTitle:@"清理闲官"];
    CCButton* gedifangzhen = [CCButton buttonWithTitle:@"各地方针"];
    officierLayout = [[CCLayoutBox alloc]init];
    officierLayout.anchorPoint = ccp(0.5, 0.5);
    [officierLayout addChild:kaikekaoshi];
    [officierLayout addChild:diaohuanguanyuan];
    [officierLayout addChild:fengjue];
    [officierLayout addChild:qinglixianguan];
    [officierLayout addChild:gedifangzhen];
    officierLayout.spacing = 10;
    officierLayout.direction = CCLayoutBoxDirectionHorizontal;
    [officierLayout layout];
    officierLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    officierLayout.visible = NO;
    [self addChild:officierLayout];
    
    CCButton* hukoupucha = [CCButton buttonWithTitle:@"户口普查"];
    CCButton* wuqigoumai = [CCButton buttonWithTitle:@"武器购买"];
    CCButton* shuilvtiaozheng = [CCButton buttonWithTitle:@"税率调整"];
    CCButton* qiangzhizhengshui = [CCButton buttonWithTitle:@"强制征税"];
    peopleLayout = [[CCLayoutBox alloc]init];
    peopleLayout.anchorPoint = ccp(0.5, 0.5);
    [peopleLayout addChild:hukoupucha];
    [peopleLayout addChild:wuqigoumai];
    [peopleLayout addChild:shuilvtiaozheng];
    [peopleLayout addChild:qiangzhizhengshui];
    peopleLayout.spacing = 10;
    peopleLayout.direction = CCLayoutBoxDirectionHorizontal;
    [peopleLayout layout];
    peopleLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    peopleLayout.visible = NO;
    [self addChild:peopleLayout];

    CCButton* maoyi = [CCButton buttonWithTitle:@"贸易"];
    CCButton* lianyin = [CCButton buttonWithTitle:@"联姻"];
    CCButton* jisi = [CCButton buttonWithTitle:@"祭祀"];
    customLayout = [[CCLayoutBox alloc]init];
    customLayout.anchorPoint = ccp(0.5, 0.5);
    [customLayout addChild:maoyi];
    [customLayout addChild:lianyin];
    [customLayout addChild:jisi];
    customLayout.spacing = 10;
    customLayout.direction = CCLayoutBoxDirectionHorizontal;
    [peopleLayout layout];
    customLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    customLayout.visible = NO;
    [self addChild:customLayout];
    
    CCButton* fadongzhanzheng = [CCButton buttonWithTitle:@"发动战争"];
    CCButton* zhengzhaoshibing = [CCButton buttonWithTitle:@"征招士兵"];
    CCButton* xiejiaguitian = [CCButton buttonWithTitle:@"卸甲归田"];
    warLayout = [[CCLayoutBox alloc]init];
    warLayout.anchorPoint = ccp(0.5, 0.5);
    [warLayout addChild:fadongzhanzheng];
    [warLayout addChild:zhengzhaoshibing];
    [warLayout addChild:xiejiaguitian];
    warLayout.spacing = 10;
    warLayout.direction = CCLayoutBoxDirectionHorizontal;
    [warLayout layout];
    warLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    warLayout.visible = NO;
    [self addChild:warLayout];
    
    CCButton* jingfeidiaocha = [CCButton buttonWithTitle:@"经费调查"];
    CCButton* dashetianxia = [CCButton buttonWithTitle:@"大赦天下"];
    prisonLayout = [[CCLayoutBox alloc]init];
    prisonLayout.anchorPoint = ccp(0.5, 0.5);
    [prisonLayout addChild:jingfeidiaocha];
    [prisonLayout addChild:dashetianxia];
    prisonLayout.spacing = 10;
    prisonLayout.direction = CCLayoutBoxDirectionHorizontal;
    [prisonLayout layout];
    prisonLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    prisonLayout.visible = NO;
    [self addChild:prisonLayout];

    CCButton* teshujianshe = [CCButton buttonWithTitle:@"特殊建设"];
    CCButton* difangjianshe = [CCButton buttonWithTitle:@"地方建设"];
    CCButton* zhaolanminfu = [CCButton buttonWithTitle:@"招揽民夫"];
    CCButton* jieguminfu = [CCButton buttonWithTitle:@"解雇民夫"];
    buildLayout = [[CCLayoutBox alloc]init];
    buildLayout.anchorPoint = ccp(0.5, 0.5);
    [buildLayout addChild:teshujianshe];
    [buildLayout addChild:difangjianshe];
    [buildLayout addChild:zhaolanminfu];
    [buildLayout addChild:jieguminfu];
    buildLayout.spacing = 10;
    buildLayout.direction = CCLayoutBoxDirectionHorizontal;
    [buildLayout layout];
    buildLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    buildLayout.visible = NO;
    [self addChild:buildLayout];

    /**
    CCButton* button1 = [CCButton buttonWithTitle:@"button"];
    CCLayoutBox* officierlayout = [[CCLayoutBox alloc]init];
    officierlayout.anchorPoint = ccp(0.5, 0.5);
    [officierlayout addChild:button1];
    officierlayout.spacing = 10;
    officierlayout.direction = CCLayoutBoxDirectionVertical;
    [officierlayout layout];
    officierlayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    [self addChild:officierlayout];
    **/
    
    [self setUserInteractionEnabled:YES];
    return self;
}
+(CCScene*)scene
{
    return [[self alloc] init];
}
-(void)onEnter
{
    [self hideAllLayouts];
}
-(void)hideAllLayouts
{
    officierLayout.visible = NO;
    peopleLayout.visible = NO;
    customLayout.visible = NO;
    warLayout.visible = NO;
    prisonLayout.visible = NO;
    buildLayout.visible = NO;
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    HuangDi* m_huangdi = [HuangDi sharedHuangDi];
    CGPoint touchpos = [touch locationInNode:self];
    CGRect exitbox = exit.boundingBox;
    exitbox.origin = [exit convertToWorldSpace:CGPointZero];
    if (CGRectContainsPoint(exitbox, touchpos)) {
        m_huangdi.tili = MAX(m_huangdi.tili-20,0);
        [[IntroScene sharedScene] passPhase];
        [[CCDirector sharedDirector] popScene];
    }
    
    if (CGRectContainsPoint(officier, touchpos)) {
        [self hideAllLayouts];
        officierLayout.visible = YES;
    }
    if (CGRectContainsPoint(people, touchpos)) {
        [self hideAllLayouts];
        peopleLayout.visible = YES;
    }
    if (CGRectContainsPoint(custom, touchpos)) {
        [self hideAllLayouts];
        customLayout.visible = YES;
    }
    if (CGRectContainsPoint(war, touchpos)) {
        [self hideAllLayouts];
        warLayout.visible = YES;
    }
    if (CGRectContainsPoint(prison, touchpos)) {
        [self hideAllLayouts];
        prisonLayout.visible = YES;
    }
    if (CGRectContainsPoint(build, touchpos)) {
        [self hideAllLayouts];
        buildLayout.visible = YES;
    }
    CCLOG(@"%f,%f",touchpos.x,touchpos.y);
}
@end
