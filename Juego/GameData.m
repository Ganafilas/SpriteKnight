//
//  GameData.m
//  Juego
//
//  Created by ALUMNO on 17/2/18.
//  Copyright © 2018 alumno. All rights reserved.
//

#import "GameData.h"

@implementation GameData

static NSUserDefaults *partida;
static long vida;
static long monedas;
static NSString* escena;

+(NSUserDefaults *)obtenerPartida{
    return partida;
}

+(long)obtenerVida{
    partida = [NSUserDefaults standardUserDefaults];
    vida = [partida integerForKey:@"vida"];
    return vida;
}

+(long)obtenerMonedas{
    partida = [NSUserDefaults standardUserDefaults];
    monedas = [partida integerForKey:@"monedas"];
    return monedas;
}

+(NSString*)obtenerEscena{
    partida = [NSUserDefaults standardUserDefaults];
    escena = [partida stringForKey:@"escena"];
    return escena;
}

+(void)guardarVida:(long)vida yMonedas:(long)monedas yEscena:(NSString *)escena{
    partida = [NSUserDefaults standardUserDefaults];
    [partida setInteger:monedas forKey:@"monedas"];
    [partida setInteger:vida forKey:@"vida"];
    [partida setObject:escena forKey:@"escena"];
    [partida synchronize];
}

@end
