//
//  Entity_QingChengDiZi.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Entity_QingChengDiZi.h"
#import "Wugong_SongFengJianFa.h"


@implementation Entity_QingChengDiZi
-(void)initEntity
{
    self.entityName = @"青城弟子";
    self.entityMale = @"男";
    self.atk = 10;
    self.def = 10;
    self.agile = 10;
    self.maxhealth = 150;
    self.maxacume = 100;
    self.wugongchangshi = 30;
    self.wuLinName = @"青城少侠";
    self.jianfa = 30;
    self.talent = 40;
    
    Wugong_SongFengJianFa* songfeng = [Wugong_SongFengJianFa node];
    [self learnWugong:songfeng];

}
@end
