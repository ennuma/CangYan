//
//  Entity_LingHuChong.m
//  Ennuma
//
//  Created by ennuma on 14-7-24.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import "Entity_LingHuChong.h"
#import "Special_LingHuChong.h"
#import "Wugong_TaiYueSanQingFeng.h"

@implementation Entity_LingHuChong
-(void)initEntity
{
    self.entityName = @"令狐冲";
    self.entityMale = @"男";
    self.atk = 15;
    self.def = 10;
    self.agile = 15;
    self.maxhealth = 200;
    self.maxacume = 150;
    self.wugongchangshi = 40;
    self.wuLinName = @"九剑传人";
    self.jianfa = 50;
    self.talent = 80;
    
    Wugong_TaiYueSanQingFeng* taiyue = [Wugong_TaiYueSanQingFeng node];
    Special_LingHuChong* linghuchong = [Special_LingHuChong node];
    [self learnSpecial:linghuchong];
    [self learnWugong:taiyue];
}
@end
