//
//  GameData.h
//  Juego
//
//  Created by ALUMNO on 17/2/18.
//  Copyright © 2018 alumno. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GameData : NSObject


+(NSUserDefaults*)obtenerPartida;
+(long)obtenerVida;
+(long)obtenerMonedas;
+(NSString*)obtenerEscena;
+(void)guardarVida:(long)vida yMonedas:(long)monedas yEscena:(NSString*)escena;

@end
