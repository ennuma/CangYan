//
//  DifangBuilding.h
//  Ennuma
//
//  Created by Zhaoyang on 14-7-31.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "cocos2d-ui.h"

@interface DifangBuilding : CCScene
{
    NSDictionary* difangDic;
    NSString* pressedString;
    NSMutableSet* buildingRecordsSet;
}
+(DifangBuilding*)sharedDifangBuilding;
-(void)resetBuildingRecords;
@end

@interface DifangBuildingSub : CCScene
{
    NSDictionary* _difangDetailDic;
    NSString* _cityName;
}
+(id)initWithDifang:(NSString*)difangName;
-(void)initLayout;
@property NSDictionary* difangDetailDic;
@property NSString* cityName;
@end
