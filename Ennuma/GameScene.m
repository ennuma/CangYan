//
//  d.m
//  Ennuma
//
//  Created by ennuma on 14-6-27.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "GameScene.h"
#import "Extension.h"
#import "MessageCache.h"
#import "Player.h"
#import "EnemyCache.h"
#import "ComponentSoldierCache.h"
#import "Soldier.h"
static GameScene* sharedScene;
@implementation GameScene
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setUserInteractionEnabled:YES];
    MessageCache* m_cache = [MessageCache messageCacheWithMessages:10];
    [self addChild:m_cache z:0 name:kNameCacheMessage];
    
    EnemyCache* en_cache = [EnemyCache enemyCache];
    [self addChild:en_cache z:0 name:kNameCacheEnemy];
    
    CCTiledMap* map = [CCTiledMap tiledMapWithFile:@"TiledMap.tmx"];
    [self addChild:map z:-99];
    
    //set contentsize to tilemap size
    self.contentSize = map.contentSize;
    
    //init routine
    routine = [[NSMutableArray alloc]init];
    //bufferRoutine = [[NSMutableArray alloc]init];
    batchnode = [CCSpriteBatchNode batchNodeWithFile:@"Projectile.png"];
    [self addChild:batchnode z:0 name:@"batchnode"];
    
    //all tests go below ===================
    player = [Player player];
    [self addChild:player z:0 name:@"player"];
    player.position = CGPointMake([self contentSize].width/5, [self contentSize].height/5);
    
    //CCActionRotateBy* rotateby = [CCActionRotateBy actionWithDuration:1 angle:360];
    //[player runAction:rotateby];
    
    //CCActionMoveBy* move = [CCActionMoveBy actionWithDuration:5 position:CGPointMake(600, 600)];
    //[player runAction:move];
    Enemy* em = [en_cache nextEnemy];
    em.position = CGPointMake([self contentSize].width/3, [self contentSize].height/3);

    return self;
}
+(GameScene*)scene
{
    sharedScene = [[self alloc]init];
    return sharedScene;
}

+(GameScene*)sharedScene
{
    NSAssert(sharedScene!=nil, @"sharedScene not initialized yet");
    return sharedScene;
}

-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    lasttouchloc = [touch locationInNode:self];
    CCLOG(@"%f,%f,%f,%f",[player boundingBox].origin.x,[player boundingBox].origin.y,[player boundingBox].size.width,[player boundingBox].size.height);
    CCLOG(@"%f,%f",lasttouchloc.x,lasttouchloc.y);
    if (CGRectContainsPoint([player boundingBox], lasttouchloc)) {
        CCLOG(@"move");
        isMovingPlayer = YES;
        [routine removeAllObjects];
        [player stopAllActions];
        [player endOfMove];
        [batchnode removeAllChildrenWithCleanup:YES];
        travelDistance = 0;
    }else{
        isMovingPlayer = NO;
    }
}

-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint pos = [touch locationInNode:self];
    CGPoint moveBy = ccpSub(pos, lasttouchloc);
    float angle = ccpAngle(lasttouchloc,pos);
    lasttouchloc = pos;
    float angleSpeed = 100;
    float moveSpeed = 100;
    if (!isMovingPlayer) {
        CCActionMoveBy* moveby = [CCActionMoveBy actionWithDuration:0.5 position:moveBy];
        CCActionEase* action = [CCActionEase actionWithAction:moveby];
        [self runAction:action];
    }else{
        //CCLOG(@"%f",angle);
        //CCActionRotateBy* rotateby = [CCActionRotateBy actionWithDuration:angle*180/3.14/angleSpeed angle:angle*180/3.14];
        //[routine addObject:rotateby];
        
        travelDistance = ccpLength(moveBy);
        CCActionMoveBy* moveby = [CCActionMoveBy actionWithDuration:travelDistance/moveSpeed position:moveBy];
        [routine addObject:moveby];
        
        CCSprite* temp = [CCSprite spriteWithImageNamed:@"Projectile.png"];
        temp.position = pos;
        [batchnode addChild:temp];

    }
}

-(void)touchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    if (isMovingPlayer) {
        [player setMoveSeq:routine];
    }
}

-(void)update:(CCTime)delta
{
    ComponentSoldierCache* ps = [player getChildByName:kNameComponentSoldierCache recursively:NO];
    EnemyCache* en_cache = [self getChildByName:kNameCacheEnemy recursively:NO];
    NSMutableArray* enemyArr = en_cache.enemyArray;
    for (Enemy* em in enemyArr) {
        if (em.visible==YES) {
            ComponentSoldierCache* es = [em getChildByName:kNameComponentSoldierCache recursively:NO];
            for (Soldier* p in [ps getSoldierArray]) {
                for (Soldier* e in [es getSoldierArray]) {
                    if (CGRectIntersectsRect([p boundingBox], [e boundingBox])) {
                        CCLOG(@"P %f,%f",[p boundingBox].origin.x, [p boundingBox].origin.y);
                        CCLOG(@"E %f,%f",[e boundingBox].origin.x, [e boundingBox].origin.y);

                        [e setVisible:NO];
                        [p setVisible:NO];
                    }
                }
            }
        }
    }
   
}

@end
