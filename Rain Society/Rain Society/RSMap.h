//
//  RSMap.h
//  Rain Society
//
//  Created by Letícia Gonçalves on 3/30/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>
#import "RSField.h"
#import "RSSprite.h"
#import "RSSound.h"
#import "RSAudioPlayer.h"

@interface RSMap : NSObject

//@property (nonatomic) CGSize
//Basic properties of map
@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic) int numberOfFieldsAxisX;
@property (nonatomic) int numberOfFieldsAxisY;
//Fields in Map
@property (nonatomic,strong) NSMutableArray *fields;
@property (nonatomic) SKNode *scene;

//Sound properties of map
@property (nonatomic, strong) RSAudioPlayer *audioPlayer;

//Auxiliary booleans
@property (nonatomic) BOOL isCloud;


//Init with width and height
-(id) initWithWidth: (int) width Height: (int) height;
//Create x*y Fields
-(void) createFields: (int) x and: (int) y;
//Load all sounds used
-(void) loadSounds;
//Return the touched Field in position touch
-(RSField*) touchedField : (CGPoint) touch;
//Add Sprite to field located self.fields in x and y
-(void) addSprite: (RSSprite*) sprite inField:(int) fieldx and:(int) fieldy;

//Update Fields of Maps, if it had any change.
-(void)updateFields;

@end
