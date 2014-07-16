//
//  Soldier.m
//  Ennuma
//
//  Created by ennuma on 14-6-26.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Soldier.h"
#import "GameScene.h"
#import "MessageCache.h"
#import "Extension.h"
@implementation Soldier
@synthesize hero=_hero;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}

+(Soldier*)SoldierWithHero:(Hero*)hero
{
    NSAssert([hero isKindOfClass:[Hero class]], @"hero is not Hero class in Soldier->SoldierWithHero");
    Soldier* returnVal =  [[self alloc] initWithImageNamed:@"Projectile.png"];
    //[returnVal setTexture:[CCTexture textureWithFile:@"Projectile.png"]];
    //CCLOG(@"create");
    returnVal.hero = hero;
    return returnVal;
}

//not useful
-(void)addSoldier
{
    CCLOG(@"add soldier");
    CCLOG(@"%@",_hero);
}

-(void)update:(CCTime)delta
{
    //update method for soldier
    if (self.visible==NO) {
        return;
    }
    
    NSAssert([_hero isKindOfClass:[Hero class]], @"_hero is not Hero class in Soldier->update:CCtime");
    //CCLOG(@"%f",_hero.soldierActiveRange);
    float val = CCRANDOM_MINUS1_1();
    float val2 = CCRANDOM_MINUS1_1();
    //float val = CCRANDOM_0_1();
    
    if (ccpDistance(CGPointMake(val, val2), _hero.position)>_hero.soldierActiveRange) {
        return;
    }
    
    CCActionMoveBy* move = [CCActionMoveBy actionWithDuration:delta position:CGPointMake(val, val2)];
    if ([self numberOfRunningActions]==0) {
        [self runAction:move];
        /**
        MessageCache* _messages = (MessageCache*)[[GameScene sharedScene] getChildByName:kNameCacheMessage recursively:NO];
        CCSprite* message = [_messages nextMessage];
        message.visible=YES;
        message.position = [self.parent convertToGameSceneSpace:self.position];
         */
    }
}

-(CGRect)boundingBox
{
    CGRect bBox = [super boundingBox];
    bBox.origin = [self convertToGameSceneSpace:bBox.origin];
    return bBox;
}

@end
