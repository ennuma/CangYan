//
//  WuLinScene.m
//  Ennuma
//
//  Created by ennuma on 14-7-1.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "WuLinScene.h"
#import "MenPai.h"
#import "HuaShanPai.h"
#import "HengShanPai.h"
#import "SongShanPai.h"

@implementation WuLinScene
MenPai* currentSelected;
static CGPoint lasttouchloc;
+ (WuLinScene *)scene
{
	WuLinScene* ret = [[self alloc] init];
    [ret initBackgorund];
    [ret initMenPai];
    [ret setUserInteractionEnabled:YES];
    return ret;
}

-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    menPaiArr = [[NSMutableArray alloc]init];
    
    return self;
}

-(void)initBackgorund
{
    CCSprite* bg = [CCSprite spriteWithImageNamed:@"bg_map.png"];
    bg.position = CGPointMake([bg contentSize].width*0.5, [bg contentSize].height*0.5);
    [self addChild:bg z:-99 name:@"bg_map"];
    [self setContentSize:bg.contentSize];
}

-(void)initMenPai
{
    //CCLOG(@"%f", [self contentSize].width);
    //CCLOG(@"%f", [self contentSize].height);
    
    HuaShanPai* huashan = [HuaShanPai menPaiWithLocation:CGPointMake([self contentSize].width/4, [self contentSize].height/4)];
    [self addMenPai: huashan z:0 name:@"huashan"];
    HengShanPai* henshan = [HengShanPai menPaiWithLocation:CGPointMake([self contentSize].width/4, [self contentSize].height*3/4)];
    [self addMenPai: henshan z:0 name:@"henshan"];
    MenPai* songshan = [SongShanPai menPaiWithLocation:CGPointMake([self contentSize].width*3/4, [self contentSize].height/4)];
    [self addMenPai: songshan z:0 name:@"songshan"];
    MenPai* taishan = [MenPai menPaiWithLocation:CGPointMake([self contentSize].width*3/4, [self contentSize].height*3/4)];
    [self addMenPai: taishan z:0 name:@"taishan"];
    
    
    [huashan.neighbours addObject:henshan];
    [huashan.neighbours addObject:songshan];
    
    [henshan.neighbours addObject:huashan];
    [henshan.neighbours addObject:taishan];
    
    [songshan.neighbours addObject:huashan];
    [songshan.neighbours addObject:taishan];
    
    [taishan.neighbours addObject:henshan];
    [taishan.neighbours addObject:songshan];
    
    CCLOG(@"%f", [huashan contentSize].width);
    CCLOG(@"%f", [huashan contentSize].height);
    CCLOG(@"%f", [huashan boundingBox].origin.x);
    CCLOG(@"%f", [huashan boundingBox].origin.y);
    
    huashan.controlByPlayer=YES;
    henshan.controlByPlayer = YES;
}

-(void)addMenPai:(CCNode*)child z:(int)zorder name:(NSString*) name
{
    [menPaiArr addObject:child];
    [self addChild:child z:zorder name:name];
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    lasttouchloc = [touch locationInNode:self];
    
    for (MenPai* menpai in menPaiArr) {
        if (CGRectContainsPoint([menpai boundingBox], lasttouchloc)) {
            currentSelected = menpai;
            break;
        }
    }
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pos = [touch locationInNode:self];
    CGPoint moveBy = ccpSub(pos, lasttouchloc);
    lasttouchloc = pos;
    CCActionMoveBy* moveby = [CCActionMoveBy actionWithDuration:0.5 position:moveBy];
    CCActionEase* action = [CCActionEase actionWithAction:moveby];
    [self runAction:action];
    
    currentSelected = nil;
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (currentSelected!=nil) {
        CCScene* menpaiscene = [currentSelected getMenPaiScene];
        //[[CCDirector sharedDirector] pushScene:menpaiscene];
        [self addChild:menpaiscene z:99 name:@"menpai"];
        menpaiscene.position = CGPointMake(-self.position.x, -self.position.y);
    }
}
@end
