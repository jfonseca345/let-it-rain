//
//  Field.h
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface RSField : SKSpriteNode

@property int temperature;
@property float pressure;
@property (nonatomic) SKFieldNode *wind;
@property int ySpeed;


-(void) setWindWithVelocity:(int) velocity;
-(void) setRegion: (CGPoint) origin with:(CGFloat) dx and:(CGFloat) dy;
-(void) verifyPressure;

@end
