//
//  Player.m
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Player.h"
#import "Extension.h"
#import "ComponentHeroBody.h"
#import "ComponentAttackRange.h"
#import "ComponentSoldierCache.h"
#import "SoldierCache.h"
#import "MessageCache.h"
#import "GameScene.h"
@implementation Player
@synthesize routine = _routine;
-(id)init
{
    self = [super init];
    if (!self) return nil;
    
    [self prepareComponent];
    return self;
}
+(Player*) player
{
    return [[self alloc] init];
}

-(void) prepareComponent
{
    /**
     Add components to the current player
     */
    
    //herobody
    ComponentHeroBody* CHB = [ComponentHeroBody component];
    [self addChild:CHB z:0 name:kNameComponentHeroBody];
    self.contentSize = CGSizeMake(CHB.heroBody.soldierActiveRange+CHB.heroBody.contentSize.width, CHB.heroBody.soldierActiveRange+CHB.heroBody.contentSize.height);
    //attack range
    /**
    ComponentAttackRange* CAR = [ComponentAttackRange component];
    [self addChild:CAR z:0 name:kNameComponentAttackRange];
    [CAR reset];
    **/
    
    //soldier cache
    ComponentSoldierCache* SC   =[ComponentSoldierCache component];
    [self addChild:SC z:0 name:kNameComponentSoldierCache];
    [SC initWithParent:self];
    
    //retrieve soldier cache
    SoldierCache* soldierCache = (SoldierCache*)[self getChildByName:kNameComponentSoldierCache recursively:NO];
    for(int i = 0 ; i < 45 ; i++){
        [soldierCache addSoldier];
    }
}

-(void)setMoveSeq:(NSMutableArray*)arr
{
    //moveDuration = distance/10;
    CCActionCallFunc* callback = [CCActionCallFunc actionWithTarget:self selector:@selector(endOfMove)];
    [arr addObject:callback];
    CCActionSequence* seq = [CCActionSequence actionWithArray:arr];
    moveSeq = seq;
}

-(void)endOfMove
{
    moveSeq = nil;
    CCSpriteBatchNode* batch = [self.parent getChildByName:@"batchnode" recursively:NO];
    [batch removeAllChildrenWithCleanup:YES];
}

-(void)update:(CCTime)delta
{
    if ([self numberOfRunningActions]!=0||!moveSeq) {
        return;
    }
    
    [self runAction:moveSeq];
    //MessageCache* _messages = (MessageCache*)[[GameScene sharedScene] getChildByName:kNameCacheMessage recursively:NO];
    //CCSprite* message = [_messages nextMessage];
    //NSAssert(_messages!=nil, @"message is nil in Soldier->update:CCTime");
    //CCLOG(@"in");
    //message.visible=YES;
    //message.position = [self convertToGameSceneSpace:CGPointMake(0, 0)];
}
@end
