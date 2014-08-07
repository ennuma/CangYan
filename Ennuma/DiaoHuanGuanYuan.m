//
//  DiaoHuanGuanYuan.m
//  Ennuma
//
//  Created by Zhaoyang on 14-8-7.
//  Copyright (c) 2014年 Zhaoyang. All rights reserved.
//

#import "DiaoHuanGuanYuan.h"
#import "GuoJia.h"
#import "GuanYuan.h"
@implementation DiaoHuanGuanYuan
static DiaoHuanGuanYuan* sharedScene;
+(DiaoHuanGuanYuan*)sharedScene
{
    if (sharedScene) {
        return sharedScene;
    }
    
    sharedScene = [self node];
    return sharedScene;
}

-(id)init
{
    self = [super init];
    if (!self) {
        return nil;
    }
    [self setUserInteractionEnabled:YES];
    return self;
}
-(void)onEnter
{
    [self initLayout];
    [super onEnter];
}
-(void)initLayout
{
    [self generateScrollview];
}
-(void)finishchoose
{
    CCLOG(@"finish choose");
    [[CCDirector sharedDirector]popScene];
}

-(void)generateScrollview
{
    NSDictionary* guanzhi = [[GuoJia sharedGuoJia]getGuanZhiDic];
    CCLOG(@"%@",guanzhi);
    NSDictionary* guanyuan = [[GuoJia sharedGuoJia]getGuanYuanDic];
    CCLayoutBox* kaoshiLayout = [[CCLayoutBox alloc]init];
    CCButton* confirm = [CCButton buttonWithTitle:@"确定"];
    [confirm setTarget:self selector:@selector(finishchoose)];
    [kaoshiLayout addChild:confirm];
    
    CCLayoutBox* hori = [[CCLayoutBox alloc]init];
    CCButton* guanzhiButton = [CCButton buttonWithTitle:@"官职"];
    CCButton* nameButton = [CCButton buttonWithTitle:@"人名"];
    nameButton.preferredSize = CGSizeMake(40, 20);
    CCButton* wuli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"武力"]];
    wuli.preferredSize = CGSizeMake(40, 20);
    CCButton* zhihui = [CCButton buttonWithTitle:[NSString stringWithFormat:@"智慧"]];
    zhihui.preferredSize = CGSizeMake(40, 20);
    CCButton* qinglian = [CCButton buttonWithTitle:[NSString stringWithFormat:@"清廉"]];
    qinglian.preferredSize = CGSizeMake(40, 20);
    [hori addChild:guanzhiButton];
    [hori addChild:nameButton];
    [hori addChild:wuli];
    [hori addChild:zhihui];
    [hori addChild:qinglian];
    hori.spacing = 5;
    hori.direction = CCLayoutBoxDirectionHorizontal;
    [hori layout];
    
    for (NSString* key in guanzhi.keyEnumerator) {
        CCLayoutBox* hori = [[CCLayoutBox alloc]init];
        NSDictionary* guanzhidic = [guanzhi objectForKey:key];
        NSString* name = [guanzhidic objectForKey:@"官员"];
        NSDictionary* guanyuandic = [guanyuan objectForKey:name];
        GuanYuan* gy;
        
        if (guanyuandic) {
            gy = [GuanYuan initFromDictionary:guanyuandic];
        }else{
            gy = [GuanYuan node];
            //gy.guanyuanname = @"无";
        }
        
        CCButton* guanzhiButton = [CCButton buttonWithTitle:key spriteFrame:[CCSpriteFrame frameWithImageNamed:@"maphud.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"highlighted.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"selected.png"]];
        
        [guanzhiButton setTarget:self selector:@selector(generateXianGuan)];
        CCButton* nameButton = [CCButton buttonWithTitle:gy.guanyuanname];
        nameButton.preferredSize = CGSizeMake(40, 20);
        CCButton* wuli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.wuli]];
        wuli.preferredSize = CGSizeMake(40, 20);
        CCButton* zhihui = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.zhihui]];
        zhihui.preferredSize = CGSizeMake(40, 20);
        CCButton* qinglian = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.qinglian]];
        qinglian.preferredSize = CGSizeMake(40, 20);
        
        [hori addChild:guanzhiButton];
        [hori addChild:nameButton];
        [hori addChild:wuli];
        [hori addChild:zhihui];
        [hori addChild:qinglian];
        hori.spacing = 5;
        hori.direction = CCLayoutBoxDirectionHorizontal;
        [hori layout];
        [kaoshiLayout addChild:hori];
        
    }
    
    
    
    [kaoshiLayout addChild:hori];
    
    kaoshiLayout.spacing = 5;
    kaoshiLayout.direction = CCLayoutBoxDirectionVertical;
    [kaoshiLayout layout];
    kaoshiLayout.position = ccp(0,self.contentSize.height-kaoshiLayout.contentSize.height);
    
    //kaoshiLayout.position = ccp(self.contentSize.width/2,self.contentSize.height/2);
    //CCSprite* sprite = [CCSprite spriteWithImageNamed:@"kaoshi.png"];
    //sprite.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
    //[sprite addChild:kaoshiLayout];
    /**scrollView = [[CCScrollView alloc] initWithContentNode:kaoshiLayout];
    scrollView.contentSizeType = CCSizeTypeNormalized;
    //scrollView.contentSize = CGSizeMake(1, 1);
    scrollView.pagingEnabled = NO;
    //scrollView.delegate = self;
    scrollView.position = CGPointZero;
    scrollView.anchorPoint = CGPointZero;
    scrollView.horizontalScrollEnabled = NO;
    
    CCLOG(@"%f",scrollView.contentSize.width);

    scrollView.position = ccp(self.contentSize.width/2-scrollView.contentSize.width/2, 0);**/
    
    [self removeAllChildren];
    [self addChild: kaoshiLayout];
    
    layout = kaoshiLayout;
}
-(void)generateXianGuan
{
    NSMutableArray* arr = [[GuoJia sharedGuoJia] getXianGuan];
    
    CCLayoutBox* kaoshiLayout = [[CCLayoutBox alloc]init];
    CCButton* confirm = [CCButton buttonWithTitle:@"确定"];
    [confirm setTarget:self selector:@selector(generateScrollview)];
    [kaoshiLayout addChild:confirm];
    
    CCLayoutBox* hori = [[CCLayoutBox alloc]init];
    CCButton* nameButton = [CCButton buttonWithTitle:@"人名"];
    nameButton.preferredSize = CGSizeMake(40, 20);
    
    CCButton* wuli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"武力"]];
    wuli.preferredSize = CGSizeMake(40, 20);
    CCButton* zhihui = [CCButton buttonWithTitle:[NSString stringWithFormat:@"智慧"]];
    zhihui.preferredSize = CGSizeMake(40, 20);
    CCButton* qinglian = [CCButton buttonWithTitle:[NSString stringWithFormat:@"清廉"]];
    qinglian.preferredSize = CGSizeMake(40, 20);
    [hori addChild:nameButton];
    [hori addChild:wuli];
    [hori addChild:zhihui];
    [hori addChild:qinglian];
    hori.spacing = 5;
    hori.direction = CCLayoutBoxDirectionHorizontal;
    [hori layout];
    
    for (int i = 0; i<arr.count; i++) {
        CCLayoutBox* hori = [[CCLayoutBox alloc]init];
        GuanYuan* gy = [arr objectAtIndex:i];
        CCButton* nameButton = [CCButton buttonWithTitle:gy.guanyuanname spriteFrame:[CCSpriteFrame frameWithImageNamed:@"maphud.png"] highlightedSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"highlighted.png"] disabledSpriteFrame:[CCSpriteFrame frameWithImageNamed:@"selected.png"]];
        
        [nameButton setTarget:self selector:@selector(generateScrollview)];
        //add to dictionary
        [nameButton addChild:gy z:0 name:@"guanyuan"];
        //[xianguanDic setObject:nameButton forKey:gy.guanyuanname];
        //
        nameButton.preferredSize = CGSizeMake(40, 20);
        CCButton* wuli = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.wuli]];
        wuli.preferredSize = CGSizeMake(40, 20);
        CCButton* zhihui = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.zhihui]];
        zhihui.preferredSize = CGSizeMake(40, 20);
        CCButton* qinglian = [CCButton buttonWithTitle:[NSString stringWithFormat:@"%i",gy.qinglian]];
        qinglian.preferredSize = CGSizeMake(40, 20);
        
        [hori addChild:nameButton];
        [hori addChild:wuli];
        [hori addChild:zhihui];
        [hori addChild:qinglian];
        hori.spacing = 5;
        hori.direction = CCLayoutBoxDirectionHorizontal;
        [hori layout];
        [kaoshiLayout addChild:hori];
    }
    
    [kaoshiLayout addChild:hori];
    
    kaoshiLayout.spacing = 5;
    kaoshiLayout.direction = CCLayoutBoxDirectionVertical;
    [kaoshiLayout layout];
    //kaoshiLayout.position = ccp(20,self.contentSize.height-kaoshiLayout.contentSize.height);

    
    [self removeAllChildren];
    [self addChild: kaoshiLayout];
    
    layout = kaoshiLayout;
}
-(void)touchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCLOG(@"%f",layout.position.y);
    lastTouch = [touch locationInNode:self];
}
-(void)touchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    CGPoint currentTouch = [touch locationInNode:self];
    
    float diff = currentTouch.y -lastTouch.y;
    CCActionMoveBy* moveby = [CCActionMoveBy actionWithDuration:0 position:ccp(0,diff)];
    [layout runAction:moveby];
    
    lastTouch = currentTouch;
}
-(void)update:(CCTime)delta
{
    if(layout.position.y>0){
        if ([layout numberOfRunningActions]==0) {
        CCActionMoveBy* moveby = [CCActionMoveBy actionWithDuration:0 position:ccp(0,-(layout.position.y-0))];
        [layout runAction:moveby];
        }
    }
    
}
@end
