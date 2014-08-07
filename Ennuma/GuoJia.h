//
//  GuoJia.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GuanYuan.h"
@interface GuoJia : CCNode
{
    NSMutableDictionary* guojiaDic;
}
+(GuoJia*)sharedGuoJia;
-(NSDictionary*)getGuoJiaDic;
-(NSDictionary*)getDiFangDic;
-(NSDictionary*)getGuanZhiDic;
-(NSDictionary*)getGuanYuanDic;
-(int)getGuoKu;
-(int)getWuQi;
-(void)addGuanYuan:(GuanYuan*)gy;
-(void)deleteGuanYuan:(GuanYuan*)gy;
-(NSMutableArray*)getXianGuan;
-(void)buildBuilding:(NSString*)buildingName AtCity:(NSString*) cityName;
-(void)changeMoney:(int)delta;
-(void)changeWuqi:(int)delta;
-(void)changePopulation:(int)delta;
-(void)changeSoldier:(int)delta;
-(void)updateGuoKu;
-(int)getMaxSoldierRecruitNum;
-(void)changeTaxTo:(int)result;
-(int)getTaxRatio;
-(int)getSoldierNum;
-(void)step;
-(void)spendMoney:(int)spend;
-(void)changeGuanZhi:(NSString*)currentGuanZhi ToGuanYuan:(NSString*)gy;
@end
