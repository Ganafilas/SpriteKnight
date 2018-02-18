//
//  GameMenuController.m
//  Juego
//
//  Created by ALUMNO on 17/2/18.
//  Copyright © 2018 alumno. All rights reserved.
//

#import "GameMenuController.h"
#import "GameMenu.h"
#import "GameScene.h"

@implementation GameMenuController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
    // including entities and graphs.
    GKScene *scene = [GKScene sceneWithFileNamed:@"Menu"];
    
    // Get the SKScene from the loaded GKScene
    GameMenu *sceneNode = (GameMenu *)scene.rootNode;
    
    // Copy gameplay related content over to the scene
    
    
    // Set the scale mode to scale to fit the window
    sceneNode.scaleMode = SKSceneScaleModeAspectFill;
    
    SKView *skView = (SKView *)self.view;
    
    // Present the scene
    [skView presentScene:sceneNode];
    
    skView.showsFPS = NO;
    skView.showsNodeCount = NO;
}

- (BOOL)shouldAutorotate {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations {
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        return UIInterfaceOrientationMaskAllButUpsideDown;
    } else {
        return UIInterfaceOrientationMaskAll;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)prefersStatusBarHidden {
    return YES;
}

- (void) motionBegan:(UIEventSubtype)motion withEvent:(UIEvent *)event {
    if (motion == UIEventSubtypeMotionShake) {
        SKView *skView = (SKView *)self.view;
        GameScene *scene = (GameScene *)skView.scene;
        
        [scene transformacion];
    }
}


@end
