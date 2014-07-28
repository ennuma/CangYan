//
//  RandomNameGenerater.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-28.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "RandomNameGenerater.h"

@implementation RandomNameGenerater
static RandomNameGenerater* sharedGenerator;
+(RandomNameGenerater*)sharedRandomNameGenerator
{
    if (sharedGenerator) {
        return sharedGenerator;
    }
    sharedGenerator = [[self alloc] init];
    return sharedGenerator;
}
-(NSString*)generateName:(NSString *)male
{
    NSString* first = @"";
    NSString* last = [self generateLastName];
    if ([male isEqualToString:@"男"]) {
        first = [self generateFirstNameForMale];
    }else if ([male isEqualToString:@"女"]){
        first = [self generateFirstNameForFemale];
    }else{
        CCLOG(@"gender is not male or female");
    }
    NSString* ret = [last stringByAppendingString:first];
    return ret;
}
-(NSString*)generateLastName
{
    NSMutableArray* lastNameArr = [NSMutableArray arrayWithObjects:@"赵",@"钱",@"孙",@"李",@"周",@"吴",@"郑",@"王",@"冯",@"陈",@"卫",@"蒋"
                                    ,@"沈",@"韩",@"杨",@"朱",@"秦",@"许",@"何",@"吕",@"施",@"张",@"孔",@"曹",@"严",@"魏",@"陶",@"姜", nil];
    int index = CCRANDOM_0_1()*lastNameArr.count;
    return [lastNameArr objectAtIndex:index];
}
-(NSString*)generateFirstNameForMale
{
    NSMutableArray* firstNameArr = [NSMutableArray arrayWithObjects:@"轩",@"雨泽",@"子轩",@"剑臣",@"之熙",@"剑枫",@"凡",@"遗风",@"清歌",@"正羽",@"萧",@"正宗"
                                    ,@"渊",@"云",@"再兴",@"大力",@"采臣",@"朝阳",@"志建",@"问水",@"山居",@"达",@"英",@"断背",@"庶",@"操",@"备",@"羽", nil];
    int index = CCRANDOM_0_1()*firstNameArr.count;
    return [firstNameArr objectAtIndex:index];
}
-(NSString*)generateFirstNameForFemale
{
    NSMutableArray* firstNameArr = [NSMutableArray arrayWithObjects:@"莫莫",@"兮兮",@"浅兮",@"采花",@"云歌",@"铛",@"婵娟",@"婵",@"茉莉",@"杜鹃",@"牡丹",@"丹红"
                                    ,@"云",@"雪",@"雨荷",@"弱弱",@"黛玉",@"宝钗",@"早春",@"朝露",@"小童",@"心仪",@"序彤",@"晨",@"之惠",@"惠芬",@"惠芳",@"银屏", nil];
    int index = CCRANDOM_0_1()*firstNameArr.count;
    return [firstNameArr objectAtIndex:index];
}
@end
