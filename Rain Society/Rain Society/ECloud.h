//
//  ECloud.h
//  Rain Society
//
//  Created by Jucelio Fonseca on 31/03/15.
//  Copyright (c) 2015 Jucelio Fonseca. All rights reserved.
//

#import "RSSprite.h"

@interface ECloud : RSSprite

//Pressure property (balance the y position of cloud)
@property (nonatomic) int pressure;

//Init with position
-(id) initWithPosition: (CGPoint) position;
//Show a popup to change the pressure value
-(void)showPopup;
@end
