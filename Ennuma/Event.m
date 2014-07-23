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
    stage ++;
    if (stage==1) {
            [cangYan.player say:@"一醉江湖三十春，安得书剑解红尘。"];
    }else if(stage==2){
            [liumang say:@"你别走，打死你！"];
    }else if(stage==3){
        
        Wugong_SongFengJianFa* jianfa = [Wugong_SongFengJianFa node];
        //[wugong addObject:jianfa];
        Wugong_LuoHanFuMoGong* fumogong =[Wugong_LuoHanFuMoGong node];
        //[wugong addObject:fumogong];
        Wugong_LiuMaiShenJian* liumai = [Wugong_LiuMaiShenJian node];
        //[wugong addObject:liumai];
        Wugong_BaHuangLiuHeWeiWoDuZunGong* bahuang = [Wugong_BaHuangLiuHeWeiWoDuZunGong node];
        Wugong_HaMaGong* hama = [Wugong_HaMaGong node];
        Wugong_ChunYangWuJiGong* chunyang = [Wugong_ChunYangWuJiGong node];
        Wugong_HunYuanGong* hunyuan = [Wugong_HunYuanGong node];
        Wugong_KuiHuaShenGong* kuihua = [Wugong_KuiHuaShenGong node];
        Wugong_QianKunDaNuoYi* qiankun = [Wugong_QianKunDaNuoYi node];
        Wugong_ShenZhaoGong* shenzhao = [Wugong_ShenZhaoGong node];
        Wugong_ShiZiHou* shizi = [Wugong_ShiZiHou node];
        Invader* invader = [[Invader alloc]init];
        invader.attack=1;
        invader.armor = 15;
        invader.maxacume = 6000;
        invader.agile = 380;
        invader.maxhealth = 7000;
        
        [invader learnWugong:liumai];
        //[invader learnWugong:fumogong];
        //[invader learnWugong:chunyang];
        [invader learnWugong:hama];
        [invader learnWugong:shizi];
        invader.mainNeiGong = shizi;

        
            BattleField* sc = [BattleField scene];
            [sc addEntity:invader ForTeam:@"red" AtPos:CGPointMake(10, 10)];
            
            Invader* invader2 = [[Invader alloc]init];
            invader2.attack=20;
            invader2.armor = 1;
            invader2.maxacume = 4800;
            invader2.agile=61;
            invader2.maxhealth=2100;
            [sc addEntity:invader2 ForTeam:@"blue" AtPos:CGPointMake(19, 19)];
            
            [invader2 learnWugong:jianfa];
            [invader2 learnWugong:fumogong];
            
            Invader* invader3 = [[Invader alloc]init];
            invader3.attack=20;
            invader3.armor = 1;
            invader3.maxacume = 4800;
            invader3.agile=61;
            invader3.maxhealth=2100;
            [sc addEntity:invader3 ForTeam:@"blue" AtPos:CGPointMake(19, 18)];
            
            [invader3 learnWugong:jianfa];
            [invader3 learnWugong:fumogong];
            
            Invader* invader4 = [[Invader alloc]init];
            invader4.attack=20;
            invader4.armor = 1;
            invader4.maxacume = 4800;
            invader4.agile=61;
            invader4.maxhealth=2100;
            [sc addEntity:invader4 ForTeam:@"blue" AtPos:CGPointMake(18, 18)];
            
            [invader4 learnWugong:jianfa];
            [invader4 learnWugong:fumogong];
            [invader4 learnWugong:shenzhao];
            //invader4.mainNeiGong = shenzhao;
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
