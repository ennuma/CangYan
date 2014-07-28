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
    CCLOG(@"%@",data);
    id object = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    if (localError!=nil) {
        CCLOG(@"error in parsing json file, error %@",localError);
        return;
    }
    if ([object isKindOfClass:[NSDictionary class]]) {
        guojiaDic = object;
    }
}
@end
