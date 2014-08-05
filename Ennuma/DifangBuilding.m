//
//  DifangBuilding.m
//  Ennuma
//
//  Created by Zhaoyang on 14-7-31.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "DifangBuilding.h"
#import "GuoJia.h"
@implementation DifangBuilding
-(void)onEnter
{
    //CCLOG(@"%@",buildingRecordsSet);
    [super onEnter];
}
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    difangDic = [[NSDictionary alloc]init];
    buildingRecordsSet = [[NSMutableSet alloc]init];
    [self initLayout];
    return self;
}
static DifangBuilding* sharedDifangBuilding;

+(DifangBuilding*)sharedDifangBuilding
{
    if (sharedDifangBuilding) {
        return sharedDifangBuilding;
    }
    
    sharedDifangBuilding = [DifangBuilding node];
    return sharedDifangBuilding;
}
-(void)resetBuildingRecords
{
    [buildingRecordsSet removeAllObjects];
}
-(void)initLayout
{
    difangDic = [[GuoJia sharedGuoJia]getDiFangDic];
    CCLayoutBox* layout = [[CCLayoutBox alloc]init];
    NSMutableArray* temp = [[NSMutableArray alloc]init];
    NSArray* keys = difangDic.allKeys;
    for (int m = 0;  m < keys.count/5+1; m++) {
        CCLayoutBox* sublayout = [[CCLayoutBox alloc]init];
        for (int n = 0; n<5; n++) {
            if ((5*m+n+1)>=keys.count) {
                break;
            }
            NSString* key = [keys objectAtIndex:(5*m+n)];
            CCButton* bt = [CCButton buttonWithTitle:key];
            bt.name = key;
            [bt setTarget:self selector:@selector(buttonClicked:)];
            [sublayout addChild:bt];
        }
        sublayout.direction = CCLayoutBoxDirectionHorizontal;
        sublayout.spacing = 10;
        [sublayout layout];
        [temp addObject:sublayout];
    }
    temp = [self reversedArray:temp];
    for (CCNode* obj in temp) {
        [layout addChild:obj];
    }
    layout.direction = CCLayoutBoxDirectionVertical;
    layout.spacing = 10;
    [layout layout];
    layout.position = ccp(self.contentSize.width/2-layout.contentSize.width/2, self.contentSize.height/2);
    [self addChild:layout];
}
-(void)buttonClicked:(id)button
{

    CCButton* bt = button;
    if ([buildingRecordsSet containsObject:[bt name]]) {
        [[CCDirector sharedDirector]popScene];
        //already has building this time
    }else{
        [buildingRecordsSet addObject:[bt name]];
        DifangBuildingSub* subScene = [DifangBuildingSub initWithDifang:bt.name];
        [[CCDirector sharedDirector]pushScene:subScene];
    }
}
- (NSMutableArray *)reversedArray:(NSMutableArray*)arr {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arr count]];
    NSEnumerator *enumerator = [arr reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}
@end

@implementation DifangBuildingSub
@synthesize difangDetailDic = _difangDetailDic;
@synthesize cityName = _cityName;
-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    
    return self;
}
+(id)initWithDifang:(NSString*)difangName;
{
    DifangBuildingSub *ret = [DifangBuildingSub node];
    if (!self) {
        return nil;
    }
    ret.cityName = difangName;
    ret.difangDetailDic = [[[GuoJia sharedGuoJia]getDiFangDic] objectForKey:difangName];
    [ret initLayout];
    return ret;
}
-(void)initLayout
{
    CCLayoutBox* layout = [[CCLayoutBox alloc]init];
    NSMutableArray* temp = [[NSMutableArray alloc]init];
    NSArray* keys = _difangDetailDic.allKeys;
    for (int m = 0;  m < keys.count/5+1; m++) {
        CCLayoutBox* sublayout = [[CCLayoutBox alloc]init];
        for (int n = 0; n<5; n++) {
            if ((5*m+n+1)>=keys.count) {
                break;
            }
            NSString* key = [keys objectAtIndex:(5*m+n)];
            CCButton* bt = [CCButton buttonWithTitle:key];
            bt.name = key;
            [bt setTarget:self selector:@selector(buttonClicked:)];
            [sublayout addChild:bt];
        }
        sublayout.direction = CCLayoutBoxDirectionHorizontal;
        sublayout.spacing = 10;
        [sublayout layout];
        [temp addObject:sublayout];
    }
    temp = [self reversedArray:temp];
    for (CCNode* obj in temp) {
        [layout addChild:obj];
    }
    layout.direction = CCLayoutBoxDirectionVertical;
    layout.spacing = 10;
    [layout layout];
    layout.position = ccp(self.contentSize.width/2-layout.contentSize.width/2, self.contentSize.height/2);
    [self addChild:layout];
}
-(void)buttonClicked:(id)button
{
    CCButton* bt = button;
    [[GuoJia sharedGuoJia]buildBuilding:bt.name AtCity:_cityName];
    CCLOG(@"%@",[[[GuoJia sharedGuoJia]getDiFangDic]objectForKey:_cityName ]);
    [[CCDirector sharedDirector]popScene];
    [[CCDirector sharedDirector]popScene];
    //build here
}
- (NSMutableArray *)reversedArray:(NSMutableArray*)arr {
    NSMutableArray *array = [NSMutableArray arrayWithCapacity:[arr count]];
    NSEnumerator *enumerator = [arr reverseObjectEnumerator];
    for (id element in enumerator) {
        [array addObject:element];
    }
    return array;
}
@end
