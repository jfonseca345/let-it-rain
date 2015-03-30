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
@property int pressure;
@property int wind;
@property NSMutableArray *sprites;

-(id) initWithProperties : (int) temperature and: (int) pressure and: (int) wind;
-(void) addSprite:(RSSprite*) sprite;
@end
