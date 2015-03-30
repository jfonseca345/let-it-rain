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

@interface RSMap : NSObject

//@property (nonatomic) CGSize
@property (nonatomic) int width;
@property (nonatomic) int height;
@property (nonatomic) int numberOfFieldsAxisX;
@property (nonatomic) int numberOfFieldsAxisY;
@property (nonatomic,strong) NSMutableArray *fields;

-(id) initWithWidth: (int) width Height: (int) height;
-(void) createFields: (int) x and: (int) y;
-(RSField*) touchedField : (CGPoint) touch;


@end
