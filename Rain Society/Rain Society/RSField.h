//
//  Field.h
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface RSField : SKNode

@property int temperature;
@property int pressure;
@property (nonatomic) SKFieldNode *wind;
@property int ySpeed;


-(void) setWind: (int) velocity;
-(void) setRegion: (CGPoint) origin with:(int) dx and:(int) dy;
-(void) verifyPressure;

@end
