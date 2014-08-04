//
//  GuoJia.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "GuoJia.h"

@implementation GuoJia
static GuoJia* sharedGuoJia;
+(GuoJia*)sharedGuoJia;
{
    if (sharedGuoJia) {
        return sharedGuoJia;
    }
    sharedGuoJia = [[self alloc]init];
    [sharedGuoJia initData];
    return sharedGuoJia;
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    guojiaDic = [[NSMutableDictionary alloc]init];
    return self;
}
-(void)initData
{
    NSError* localError = nil;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"data" ofType:@"json"];
    
    NSData* data = [NSData dataWithContentsOfFile:path options:0 error:&localError];
    if (data==nil) {
        CCLOG(@"data is nil, error %@",localError);
        return;
    }

    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError!=nil) {
        CCLOG(@"error in parsing json file, error %@",localError);
        return;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        guojiaDic = [object mutableCopy];
    }
    //NSMutableDictionary* difang = [guojiaDic objectForKey:@"官职"];
    //NSDictionary* jiangnan = [difang objectForKey:@"江南"];
    //NSString* number = [jiangnan objectForKey:@"类型"];
    //CCLOG(@"map: %@",difang);
}
-(NSMutableDictionary*)getGuoJiaDic
{
    return guojiaDic;
}
-(NSMutableDictionary*)getGuanYuanDic
{
    NSMutableDictionary* guanyuan = [guojiaDic objectForKey:@"官员"];
    return guanyuan;
}
-(NSMutableDictionary*)getDiFangDic
{
    NSMutableDictionary* difang = [guojiaDic objectForKey:@"地方"];
    return difang;
}
-(NSMutableDictionary*)getGuanZhiDic
{
    NSMutableDictionary* guanzhi = [guojiaDic objectForKey:@"官职"];
    //CCLOG(@"guanzhi:%@",guanzhi);
    return guanzhi;
}
-(NSInteger)getGuoKu
{
    NSNumber* i = [guojiaDic objectForKey:@"国库"];
    int ret = [i intValue];
    //CCLOG(@"%i", ret);
    return ret;
}
-(NSInteger)getWuQi
{
    NSNumber* i = [guojiaDic objectForKey:@"武器"];
    int ret = [i intValue];
    //CCLOG(@"%i", ret);
    return ret;
}
-(NSMutableArray*)getXianGuan
{
    NSMutableArray* ret = [[NSMutableArray alloc]init];
    for (NSString* key in [[self getGuanYuanDic]allKeys]) {
        if (![self hasGuanZhi:key]) {
            GuanYuan* gy = [GuanYuan initFromDictionary:[[self getGuanYuanDic]objectForKey:key]];
            [ret addObject:gy];
        }
    }
    return ret;
}
-(void)deleteGuanYuan:(GuanYuan*)gy
{
     NSMutableDictionary* guanyuan = [[guojiaDic objectForKey:@"官员"]mutableCopy];
    [guanyuan removeObjectForKey:gy.guanyuanname];
    [guojiaDic setObject:guanyuan forKey:@"官员"];
}
-(bool)hasGuanZhi:(NSString*)guanyuanName
{
    for (NSString* key in [[self getGuanZhiDic]allKeys]) {
        NSString* name = [[[self getGuanZhiDic] objectForKey:key] objectForKey:@"官员"];
        if ([guanyuanName isEqualToString:name]) {
            return true;
        }
    }
    return false;
}

-(void)addGuanYuan:(GuanYuan *)gy
{
    NSMutableDictionary* guanyuan = [[guojiaDic objectForKey:@"官员"]mutableCopy];
    NSMutableDictionary* newgy = [[NSMutableDictionary alloc] init];
    [newgy setObject:gy.guanyuanname forKey:@"姓名"];
    [newgy setObject:[NSNumber numberWithInt:gy.age] forKey:@"年龄"];
    [newgy setObject:[NSNumber numberWithInt:gy.zhihui] forKey:@"智慧"];
    [newgy setObject:[NSNumber numberWithInt:gy.wuli]forKey:@"武力"];
    [newgy setObject:[NSNumber numberWithInt:gy.zhongcheng]forKey:@"忠诚"];
    [newgy setObject:[NSNumber numberWithInt:gy.qinglian] forKey:@"清廉"];
    [guanyuan setObject:newgy forKey:gy.guanyuanname];
    
    [guojiaDic setObject:guanyuan forKey:@"官员"];
}
-(void)buildBuilding:(NSString *)buildingName AtCity:(NSString *)cityName
{
    NSMutableDictionary* difang = [[guojiaDic objectForKey:@"地方"]mutableCopy];
    NSMutableDictionary* difangsub = [[difang objectForKey:cityName]mutableCopy];
    NSNumber* i = [difangsub objectForKey:buildingName];
    CCLOG(@"%@",i);
    NSNumber* i2 = [NSNumber numberWithInt:[i intValue]+1];
    CCLOG(@"%@",i2);
    [difangsub setObject:i2 forKey:buildingName];
    [difang setObject:difangsub forKey:cityName];
    [guojiaDic setObject:difang forKey:@"地方"];
}
-(void)changeWuqi:(int)delta
{
    int wuqi = [[guojiaDic objectForKey:@"武器"] intValue];
    wuqi = wuqi + delta;
    [guojiaDic setObject:[NSNumber numberWithInt:wuqi] forKey:@"武器"];
}
-(void)changeSoldier:(int)delta
{
    int soldier = [[guojiaDic objectForKey:@"士兵"] intValue];
    soldier = soldier + delta;
    [guojiaDic setObject:[NSNumber numberWithInt:soldier] forKey:@"士兵"];
    [self changePopulation:delta];
}
-(void)changeMoney:(int)delta
{
    int money = [[guojiaDic objectForKey:@"国库"] intValue];
    money = money + delta;
    [guojiaDic setObject:[NSNumber numberWithInt:money] forKey:@"国库"];
}
-(int)getMaxSoldierRecruitNum
{
    int ret = 0;
    int totP = [self getTotPopulation];
    ret += totP* 8/100;
    return ret;
}
-(void)updateGuoKu
{
    int totalIncome = 0;
    
    //calculate tax
    //NSDictionary* difangDic = [self getDiFangDic];
    int totPopulation = [self getTotPopulation];
    NSNumber* temp = [guojiaDic objectForKey:@"税收"];
    int taxRatio = [temp intValue];
    int taxIncome = taxRatio*totPopulation;
    totalIncome += taxIncome;
    CCLOG(@"taxincome: %i",taxIncome);
    
    //calculate spend for soldiers
    NSNumber* temp2 = [guojiaDic objectForKey:@"士兵"];
    int soldierNum = [temp2 intValue];
    int costPerSoldier = 100;
    int totCostForSoldier = soldierNum*costPerSoldier;
    totalIncome -= totCostForSoldier;
    CCLOG(@"soldiercost: %i",totCostForSoldier);
    
    //calculate spend for officier
    int totCostForGuanYuan = 0;
    NSDictionary* guanyuanDic = [self getGuanYuanDic];
    int guanyuanNum = [guanyuanDic.allKeys count];
    int costPerGuanYuan = 1000;
    totCostForGuanYuan += costPerGuanYuan*guanyuanNum;
    NSDictionary* guanzhiDic = [self getGuanZhiDic];
    for (NSString* key in guanzhiDic.allKeys) {
        NSNumber* val = [[guanzhiDic objectForKey:key] objectForKey:@"俸禄"];
        int intVal = [val intValue];
        if ([[[guanzhiDic objectForKey:key]objectForKey:@"官员"] isEqualToString:@""]) {
            intVal = 0;
        }else{
            NSNumber* qinglianNum = [[guanyuanDic objectForKey:[[guanzhiDic objectForKey:key]objectForKey:@"官员"]]objectForKey:@"清廉"];
            int qinglian = [qinglianNum intValue];
            //CCLOG(@"%@",qinglianNum);
            //CCLOG(@"%i",qinglian);
            //some math TODO
            intVal*= (10100-qinglian*qinglian)/100;
        }
        totCostForGuanYuan += intVal;
    }
    totalIncome -= totCostForGuanYuan;
    CCLOG(@"guanyuancost: %i",totCostForGuanYuan);
    
    //add up total income
    CCLOG(@"totalIncom: %i",totalIncome);
    [self changeMoney:totalIncome];
}
-(int)getTotPopulation
{
    int totPopulation = 0;
    NSDictionary* difangDic = [self getDiFangDic];
    for (NSString* key in difangDic.allKeys) {
        NSNumber* val = [[difangDic objectForKey:key] objectForKey:@"人口"];
        int intVal = [val intValue];
        totPopulation += intVal;
        //TODO zhigu and zongbing affect income for province
    }
    return totPopulation;
}
-(void)changePopulation:(int)delta
{
    float percentage = (float)delta/(float)[self getTotPopulation];
    //CCLOG(@"percentage: %f",percentage);
    NSMutableDictionary* difangDic = [[self getDiFangDic]mutableCopy];
    for (NSString* key in difangDic.allKeys) {
        NSMutableDictionary* difangsub = [[difangDic objectForKey:key]mutableCopy];
        NSNumber* val = [difangsub objectForKey:@"人口"];
        int intVal = [val intValue];
        //CCLOG(@"%i",intVal);
        //CCLOG(@"%i",((int)(intVal-intVal*percentage)));
        int result = ((int)(intVal-intVal*percentage));
        [difangsub setObject:[NSNumber numberWithInt:(int)result]forKey:@"人口"];
        [difangDic setObject:difangsub forKey:key];
        [guojiaDic setObject:difangDic forKey:@"地方"];
        //TODO zhigu and zongbing affect income for province
    }
    //CCLOG(@"%@",guojiaDic);
}
@end
