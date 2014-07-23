//
//  BattleField.m
//  Ennuma
//
//  Created by ennuma on 14-7-7.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "BattleField.h"

@implementation BattleField
@synthesize height = _height;
@synthesize width = _width;

static float current_clock = 0;
//Test constant
CCSprite* sp1;
CCSprite* sp2;
CCSprite* bar;
//End of test
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    redTeam = [[NSMutableArray alloc] init];
    blueTeam = [[NSMutableArray alloc] init];
    whateverTeam = [[NSMutableArray alloc] init];
    
    interval = 0.1;
    tick = 0;
    maxJiQi = 1000;
    
    //Test Purpose
    //sp1 = [CCSprite spriteWithImageNamed:@"Enemy1.png"];
    //sp2 = [CCSprite spriteWithImageNamed:@"Enemy2.png"];
    bar = [CCSprite spriteWithImageNamed:@"hud.png"];
    bar.position = CGPointMake([self contentSize].width/2, [self contentSize].height- [bar contentSize].height);
    
    //[self addChild:sp1 z:99];
    //[self addChild:sp2 z:99];
    [self addChild:bar z:98];
    
    map = [CCTiledMap tiledMapWithFile:@"BattleField.tmx"];
    [self addChild:map z:-99];
    _width = map.mapSize.width;
    _height = map.mapSize.height;
    
    [self setUserInteractionEnabled:YES];
    
    return self;
}
+(BattleField*)scene
{
    BattleField* bf = [[self alloc]init];
    return bf;
}

-(void)startBattle
{
    [self schedule:@selector(startJiqi:) interval:0.01];
}

-(void)addEntity:(Invader *)obj ForTeam:(NSString*)teamtype AtPos:(CGPoint)spawnPos
{
    obj.map = map;
    if ([teamtype isEqualToString:@"red"]) {
        [redTeam addObject:obj];
        
        //Test
        //obj.smallIcon = sp1;
        obj.allie = redTeam;
        obj.enemy = blueTeam;
        [obj initPosition:spawnPos];
    }
    else if ([teamtype isEqualToString:@"blue"]){
        [blueTeam addObject:obj];
        
        //Test
        //obj.smallIcon = sp2;
        obj.allie = blueTeam;
        obj.enemy = redTeam;
        [obj initPosition:spawnPos];
    }
    
    [obj initForBattleWithParent:self];
    [whateverTeam addObject:obj];
    //CGPoint spp = CGPointMake([self contentSize].width/2-[bar contentSize].width/2+ [sp1 contentSize].width/2, [self contentSize].height- [bar contentSize].height);

    //test
    //obj.smallIcon.position = spp;
    float percentage = obj.amountofjiqi/maxJiQi;
    float newx = bar.contentSize.width*percentage + bar.position.x - bar.contentSize.width/2;
    obj.smallIcon.position = CGPointMake(newx, [self contentSize].height- [bar contentSize].height);
    [self addChild:obj.smallIcon z:99];
}

-(void)dealloc
{
    redTeam = nil;
    blueTeam = nil;
}

-(void)update:(CCTime)delta{
    //CCLOG(@"update");
    if ([self checkEndBattle]) {
        CCLOG(@"END BATTLE");
        self.paused = YES;
        //TODO
        //battle ends here, its time to change scene or pop scene
    }
    
}
-(bool)checkEndBattle
{
    bool aliveInRed = false;
    bool aliveInBlue = false;
    for (Invader* inv in redTeam) {
        if (!inv.isDead) {
            aliveInRed = true;
        }
    }
    
    for (Invader* inv in blueTeam) {
        if (!inv.isDead) {
            aliveInBlue = true;
        }
    }
    return !(aliveInRed&&aliveInBlue);
}
-(void)startJiqi:(CCTime) delta
{
    current_clock += delta;
    if (current_clock>interval) {
        tick++;
        [self updateAllObjsJiQi];
        current_clock = current_clock - interval;
    }
}
/**
 The objs may do action at the same time. fixed
 **/
static NSObject* isActing = nil;
-(void) updateAllObjsJiQi
{
    isActing = nil;
    //advise arrange element by jiqispeed
    /**
     sorted version of doaction. only the fastest one will act and put others to waitlist
     **/
    NSArray *sorted = [whateverTeam sortedArrayUsingComparator:^(id obj1, id obj2){
       
          Invader *s1 = obj1;
          Invader*s2 = obj2;
            
            if (s1.jiqispeed > s2.jiqispeed) {
                return (NSComparisonResult)NSOrderedAscending;
            } else if (s1.jiqispeed < s2.jiqispeed) {
                return (NSComparisonResult)NSOrderedDescending;
            }
        
        // TODO: default is the same?
        return (NSComparisonResult)NSOrderedSame;
    }];
    
    for (Invader* inv in sorted) {
        if (inv.isDead) {
            continue;
        }
        [self updateJiQi:inv];
    }

}

-(void) updateJiQi: (Invader*) obj
{
    
    [obj updateJiQi];
    
    float percentage = obj.amountofjiqi/maxJiQi;
    float newx = bar.contentSize.width*percentage + bar.position.x - bar.contentSize.width/2;
    obj.smallIcon.position = CGPointMake(newx, obj.smallIcon.position.y);
   // CCLOG(@"%f",obj.amountofjiqi);
    if (obj.amountofjiqi > maxJiQi) {
        //CCLOG(@"startact");
        if (!isActing) {
            [self unschedule:@selector(startJiqi:)];
            [obj doAction];
            isActing=obj;
            obj.amountofjiqi = obj.amountofjiqi - maxJiQi;
        }else{
            obj.amountofjiqi = maxJiQi-1;
        }
        //CCLOG(@"action");
        //Action Begins Here
    }
    
    
    
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    if ([self getChildByName:@"show" recursively:NO]!=nil) {
         [self removeChildByName:@"show"];
    }
    [self resumeAction];
}
-(void)notifyJiQiChangedForInvader:(id)invader
{
    Invader* obj = (Invader*)invader;
    float percentage = obj.amountofjiqi/maxJiQi;
    float newx = bar.contentSize.width*percentage + bar.position.x - bar.contentSize.width/2;
    CGPoint newpos = CGPointMake(newx, obj.smallIcon.position.y);
    //newpos = CGPointMake(0, obj.smallIcon.position.y);
    //The duration for this action may changed TODO
    CCActionMoveTo* moveTo = [CCActionMoveTo actionWithDuration:0.8 position:newpos];
    [obj.smallIcon runAction:moveTo];
}

-(void)pauseAction
{
    if (isActing) {
        [((Invader*)isActing).bigIcon setPaused:YES];
    }
}

-(void)resumeAction
{
    if (isActing) {
        [((Invader*)isActing).bigIcon setPaused:NO];
    }
}
@end
