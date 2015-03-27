//
//  Field.m
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSField.h"

@implementation RSField


-(void)setWindWithVelocity:(int) velocity{
    NSArray *childrenOfSelf = [self children];
    for (SKNode *node in childrenOfSelf){
        [node removeFromParent];
    }
    _ySpeed=0;
    [self verifyPressure];
    vector_float3 speed = {velocity,_ySpeed,0};
    _wind = [SKFieldNode velocityFieldWithVector:speed];
    [_wind setEnabled:YES];
    [self addChild:_wind];
    
}

-(void) setRegion: (CGPoint) origin with:(CGFloat) dx and:(CGFloat) dy{
    _wind.position=origin;
    _wind.region = [[SKRegion alloc] initWithSize: CGSizeMake(500, 500)];
    self.position=origin;
}

-(void) verifyPressure{
    if(_pressure<1) _ySpeed=(1-_pressure)*10;
}
@end
