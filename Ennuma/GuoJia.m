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
@end
