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
-(void)addGuanYuan:(GuanYuan*)gy;
-(NSMutableArray*)getXianGuan;
@end
