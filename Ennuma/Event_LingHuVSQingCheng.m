//
//  Event_LingHuVSQingCheng.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Event_LingHuVSQingCheng.h"
#import "BattleField.h"
#import "CangYan.h"
#import "Entity_LingHuChong.h"
#import "Entity_QingChengDiZi.h"
@implementation Event_LingHuVSQingCheng
-(void)proceed
{
    CangYan* cangYan = [CangYan sharedScene];
    Entity* xiaoer = [Entity node];
    xiaoer.entityName = @"店小二";
    Entity_QingChengDiZi* dizi = [Entity_QingChengDiZi node];
    Entity_LingHuChong* linghu = [Entity_LingHuChong node];

    stage ++;
    if (stage==1) {
        [cangYan.player say:@"哇，这里有间客栈！"];
    }else if(stage==2){
        [xiaoer say:@"客官，里面情！"];
    }else if(stage==3){
        [dizi say:@"小二，老子今天没钱，先走一步！"];
    }
    else if(stage == 4){
        [linghu say:@"哪里来的弟子，竟然如此不懂规矩，我来替你师傅教训教训你!"];
    }
    else if(stage==5){
        [cangYan.player say:@"这位少侠，我也来帮忙！"];
    }else if(stage==6){
        BattleField* sc = [BattleField scene];
        [sc addEntity:[cangYan.player transformToInvaderForm] ForTeam:@"red" AtPos:CGPointMake(12, 12)];
        [sc addEntity:[linghu transformToInvaderForm] ForTeam:@"red" AtPos:CGPointMake(14, 15)];
        [sc addEntity:[dizi transformToInvaderForm] ForTeam:@"blue" AtPos:CGPointMake(19, 18)];
        [sc addEntity:[dizi transformToInvaderForm] ForTeam:@"blue" AtPos:CGPointMake(18, 19)];
        [sc addEntity:[dizi transformToInvaderForm] ForTeam:@"blue" AtPos:CGPointMake(18, 18)];
        [sc addEntity:[dizi transformToInvaderForm] ForTeam:@"blue" AtPos:CGPointMake(17, 19)];
        
        [sc startBattle];
        [[CCDirector sharedDirector]pushScene:sc];
        [xiaoer say:@"多谢"];
    }else{
        finish = YES;
    }
}
@end
