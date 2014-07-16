//
//  Player.h
//  Ennuma
//
//  Created by ennuma on 14-6-25.
//  Copyright 2014年 ennuma. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Player : CCNode {
    NSMutableArray* _routine;
    CCActionSequence* moveSeq;
    //float moveDuration;
}
+(Player*) player;
-(void)setMoveSeq:(NSMutableArray*)arr;
-(void)endOfMove;
@property (nonatomic,readwrite) NSMutableArray* routine;
@end
