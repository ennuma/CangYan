//
//  GuanYuan.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "GuanYuan.h"
#import "Wugong_SongFengJianFa.h"
@implementation GuanYuan
@synthesize guanyuanname = _guanyuanname;
@synthesize qinglian = _qinglian;
@synthesize zhihui = _zhihui;
@synthesize zhongcheng = _zhongcheng;
@synthesize age = _age;
@synthesize juewei = _juewei;
@synthesize guanzhi = _guanzhi;
@synthesize fenglu = _fenglu;

-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    self.guanyuanname = @"无";
    self.qinglian = 0;
    self.zhihui = 0;
    self.wuli = 0;
    self.zhongcheng=0;
    self.age = 0;
    self.juewei = @"无";
    self.guanzhi = @"无";
    return self;
}
+(GuanYuan*)initFromDictionary:(NSDictionary *)dic
{
    GuanYuan* ret = [[self alloc] init];
    ret.guanyuanname = [dic objectForKey:@"姓名"];
    ret.qinglian =[((NSNumber*)[dic objectForKey:@"清廉"]) intValue];
    ret.wuli = [((NSNumber*)[dic objectForKey:@"武力"]) intValue];
    ret.zhihui = [((NSNumber*)[dic objectForKey:@"智慧"]) intValue];
    ret.zhongcheng =[((NSNumber*)[dic objectForKey:@"忠诚"]) intValue];
    ret.age = [((NSNumber*)[dic objectForKey:@"年龄"]) intValue];
    return ret;


}

-(Invader*)transformToInvader
{
    Invader* ret = [[Invader alloc]init];
    ret.attack = _wuli;
    ret.armor = _wuli-10;
    ret.agile = _zhihui;
    ret.poision = 0;
    ret.health = _wuli*10;
    ret.maxhealth = _wuli*10;
    ret.acume = _wuli*10;
    ret.maxacume = _wuli*10;
    ret.quanFa = 10;
    ret.jianFa = 10;
    ret.daoFa = 10;
    ret.qiMen = 10;
    ret.antiPoisionIndex = 0;
    ret.attackHasPoisionIndex = 0;//may be to much
    ret.wuxueKnowledge = 100;
    ret.talent = 20;
    ret.isPlayer = false;
    NSMutableArray* retwugong = [[NSMutableArray alloc] init];
    //CCLOG(@"%i",[_wugong count]);
    Wugong_SongFengJianFa* jianfa =[Wugong_SongFengJianFa node];
    [retwugong addObject:jianfa];
    ret.wugongArr = retwugong;
    
    //头像
    //ret.bigIcon = [CCSprite spriteWithTexture:[_bigIcon texture]];
    //ret.smallIcon = [CCSprite spriteWithTexture:[_smallIcon texture]];
    //ret.headIcon = [CCSprite spriteWithTexture:[_statusIcon texture]];
    
    return ret;
}

@end
