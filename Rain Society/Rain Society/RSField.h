//
//  Field.h
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/26/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "RSContainer.h"
#import "RSButton.h"
#import "RSStepper.h"
#import "RSSprite.h"

@interface RSField : SKSpriteNode
//Properties of field
@property int temperature;
@property int pressure;
@property int wind;
//Sprites in field
@property NSMutableArray *sprites;
//Region of field
@property CGRect region;
//If a field should or not be updated
@property BOOL changed;
//popup to change field
@property (nonatomic) RSContainer *popup;


//Init with temperature, pressure and wind
-(id) initWithTemperature : (int) temperature Pressure: (int) pressure Wind: (int) wind;
//Add a sprite in field
-(void) addSprite:(RSSprite*) sprite;
//-(RSField*) touchedField : (CGPoint) touch;

//Show popup to change field
-(void) showPopup:(SKNode*)gameScene;
@end
