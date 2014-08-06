//
//  FaDongZhanZheng.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-6.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "FaDongZhanZheng.h"
#import "GuoJia.h"
#import "GuanYuan.h"
#import "BattleField.h"
#import "EventManager.h"
#import "IntroScene.h"
@implementation FaDongZhanZheng
static FaDongZhanZheng* sharedScene;
+(FaDongZhanZheng*)sharedScene
{
    if (sharedScene) {
        return sharedScene;
    }
    
    sharedScene = [self node];
    return sharedScene;
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    guanyuanArr = [[NSMutableArray alloc]init];
    messageArr = [[NSMutableArray alloc]init];
    buttonArr = [[NSMutableArray alloc]init];
    return self;
}
-(void)reset
{
    [guanyuanArr removeAllObjects];
    [messageArr removeAllObjects];
    [buttonArr removeAllObjects];
    hasGeneral = false;
}
-(void)onEnter
{
    
    //[guanyuanArr removeAllObjects];
    [self reset];
    [messageArr addObject:@"。。。。。。"];
    
    NSDictionary* guanzhiDic = [[GuoJia sharedGuoJia]getGuanZhiDic];
    NSDictionary* guanyuanDic = [[GuoJia sharedGuoJia]getGuanYuanDic];
    
    
    NSString* dajiangjunName = [[guanzhiDic objectForKey:@"大将军"]objectForKey:@"官员"];
    CCLOG(@"name:%@",dajiangjunName);
    if (![dajiangjunName isEqualToString:@"无"]) {
        NSDictionary* dajiangjunDic = [guanyuanDic objectForKey:dajiangjunName];
        GuanYuan* dajiangjun = [GuanYuan initFromDictionary:dajiangjunDic];
        if (CCRANDOM_0_1()*100<100) {//relate to zhongcheng TODO
            [guanyuanArr addObject:dajiangjun];
        }
    }

    
    if ([guanyuanArr count]==0) {
        [messageArr addObject:@"泱泱大国，竟无人应战。"];
    }else{
        hasGeneral = true;
        for (GuanYuan* gy in guanyuanArr) {
            [messageArr addObject:[NSString stringWithFormat:@"%@愿与一战",gy.guanyuanname]];
        }
    }

    CCButton* confirm = [CCButton buttonWithTitle:@"确认"];
    text = [CCLabelTTF labelWithString:[messageArr objectAtIndex:0] fontName:@"Chalkduster" fontSize:10];
    
    CCSprite* ret = [CCSprite spriteWithImageNamed:@"messageBox.png"];
    [ret addChild:confirm];
    [ret addChild:text];
    text.position = ccp(ret.contentSize.width/2,ret.contentSize.height/2-text.contentSize.height/2);
    confirm.position = ccp(ret.contentSize.width/2,ret.contentSize.height/2-confirm.contentSize.height/2-10);
    [confirm setTarget:self selector:@selector(messageButtonClicked:)];
    [self addChild:ret z:0 name:@"messageBox"];
    ret.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    
    [super onEnter];
}

-(void)messageButtonClicked:(id)button
{
    CCButton* bt = button;
    [messageArr removeObjectAtIndex:0];
    if ([messageArr count]==0) {
        [bt.parent removeFromParentAndCleanup:YES];
        if (!hasGeneral) {
            [[CCDirector sharedDirector]popScene];
        }else{
            [self startSelect];
        }
    }else{
        [text setString:[messageArr objectAtIndex:0]];
    }
}
-(void)finishSelect
{
    int count = 0;
    
    BattleField* battle = [BattleField scene];
    //add enemy
    
    for (CCButton* button in buttonArr) {
        if (button.selected == true) {
            GuanYuan* gy = (GuanYuan*)[button getChildByName:@"guanyuan" recursively:NO];
            [battle addEntity:[gy transformToInvader] ForTeam:@"red" AtPos:CGPointMake(18, 18)];
            //TODO delete below line
            [battle addEntity:[gy transformToInvader] ForTeam:@"blue" AtPos:CGPointMake(5, 5)];
            CCLOG(@"add gy to bf");
            count++;
        }
    }
    [self setUserInteractionEnabled:YES];
    [self removeChildByName:@"kaoshi"];
    if (count!=0) {
        int day = [IntroScene sharedScene].m_day;
        int time = [IntroScene sharedScene].m_time;
        [[EventManager sharedEventManager]pushEvent:battle ForDay:day ForTime:time+1];
        CCLOG(@"start battle field!");
    }
    
    [[CCDirector sharedDirector]popScene];
}
-(void)startSelect
{
    [self setUserInteractionEnabled:NO];
    
    CCLayoutBox* chuzhenLayout = [[CCLayoutBox alloc]init];
    CCButton* confirm = [CCButton buttonWithTitle:@"确定"];
    [confirm setTarget:self selector:@selector(finishSelect)];
    [chuzhenLayout addChild:confirm];
    
    CCLayoutBox* hori = [[CCLayoutBox alloc]init];
    CCButton* nameButton = [CCButton buttonWithTitle:@"人名"];
    nameButton.preferredSize = CGSizeMake(40, 20);
    
    CCButton* wuli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"武力"]];
    wuli.preferredSize = CGSizeMake(40, 20);
    CCButton* bingli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"兵力"]];
    bingli.preferredSize = CGSizeMake(80, 20);
    [hori addChild:nameButton];
    [hori addChild:wuli];
    [hori addChild:bingli];
    hori.spacing = 5;
    hori.direction = CCLayoutBoxDirectionHorizontal;
    [hori layout];
    
    for (int i = 0; i<[guanyuanArr count]; i++) {
        CCLayoutBox* hori = [[CCLayoutBox alloc]init];
        GuanYuan* gy = [guanyuanArr objectAtIndex:i];
        CCButton* nameButton = [CCButton buttonWithTitle:gy.guanyuanname spriteFrame:[CCSpriteFrame frameWithImageNamed:@"maphud.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"highlighted.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"selected.png"]];
        
        [nameButton setTarget:nameButton selector:@selector(toggleSelected)];
        [nameButton addChild:gy z:0 name:@"guanyuan"];
        [buttonArr addObject:nameButton];
        nameButton.preferredSize = CGSizeMake(40, 20);
        CCButton* wuli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.wuli]];
        wuli.preferredSize = CGSizeMake(40, 20);
        CCButton* bingli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.wuli*1000]];
        bingli.preferredSize = CGSizeMake(80, 20);
        
        [hori addChild:nameButton];
        [hori addChild:wuli];
        [hori addChild:bingli];
        hori.spacing = 5;
        hori.direction = CCLayoutBoxDirectionHorizontal;
        [hori layout];
        [chuzhenLayout addChild:hori];
    }
    
    [chuzhenLayout addChild:hori];
    
    chuzhenLayout.spacing = 5;
    chuzhenLayout.direction = CCLayoutBoxDirectionVertical;
    [chuzhenLayout layout];
    
    
    CCSprite* sprite = [CCSprite spriteWithImageNamed:@"kaoshi.png"];
    sprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    
    chuzhenLayout.position = ccp(20,sprite.contentSize.height-chuzhenLayout.contentSize.height);
    [sprite addChild:chuzhenLayout];
    [self addChild:sprite z:1 name:@"kaoshi"];
}
@end
