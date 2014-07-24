//
//  Event.m
//  Ennuma
//
//  Created by ennuma on 14-7-23.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Event.h"
#import "CangYan.h"
#import "BattleField.h";

@implementation Event
@synthesize done = finish;
-(void)proceed
{
    CangYan* cangYan = [CangYan sharedScene];
    Entity* liumang = [Entity node];
    liumang.entityName = @"流氓";
    liumang.atk = 5;
    liumang.def = 3;
    liumang.agile = 3;
    liumang.maxhealth = 50;
    liumang.maxacume = 50;
    Wugong_SongFengJianFa* jianfa = [Wugong_SongFengJianFa node];
    [liumang.wugong addObject:jianfa];
    //CCLOG(@"count: %i",[liumang.wugong count]);
    stage ++;
    if (stage==1) {
            [cangYan.player say:@"一醉江湖三十春，安得书剑解红尘。"];
    }else if(stage==2){
            [liumang say:@"你别走，打死你！"];
    }else if(stage==3){
        
            BattleField* sc = [BattleField scene];
            [sc addEntity:[cangYan.player transformToInvaderForm] ForTeam:@"red" AtPos:CGPointMake(18, 18)];
            
            [sc addEntity:[liumang transformToInvaderForm] ForTeam:@"blue" AtPos:CGPointMake(19, 19)];
        
            [sc startBattle];
            [[CCDirector sharedDirector]pushScene:sc];
        
            [liumang say:@"好疼"];
    }
    else if(stage == 4){
        [liumang say:@"好疼!!!!"];
    }
    else{
        finish = YES;
    }
}

@end
