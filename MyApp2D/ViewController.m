//
//  ViewController.m
//  MyApp2D
//
//  Created by HZhenF on 2017/6/17.
//  Copyright © 2017年 HuangZhenFeng. All rights reserved.
//

#import "ViewController.h"
#import "Scene.h"

@interface ViewController () <ARSKViewDelegate>

@property (nonatomic, strong) IBOutlet ARSKView *sceneView;

@end


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set the view's delegate
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and node count
    //显示帧率
    self.sceneView.showsFPS = YES;
    //显示界面节点(游戏开发中，一个角色对应一个节点)
    self.sceneView.showsNodeCount = YES;
    
    // Load the SKScene from 'Scene.sks'
    //加载2D场景
    Scene *scene = (Scene *)[SKScene nodeWithFileNamed:@"Scene"];
    
    // Present the scene
    //AR预览视图展现场景
    [self.sceneView presentScene:scene];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    //创建设备追踪设置，万恶之首，之所以要A9以上的设备，全是因为它
    ARWorldTrackingSessionConfiguration *configuration = [ARWorldTrackingSessionConfiguration new];
    
    // Run the view's session
    //启动AR
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    //暂停AR
    [self.sceneView.session pause];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - ARSKViewDelegate

/**
 点击界面会调用该方法，出现一个你要创建的节点内容
 
 @param view 2D的预览视图
 @param anchor 锚点，可以和UILayer的锚点联系起来理解
 @return 返回一个节点
 */
- (SKNode *)view:(ARSKView *)view nodeForAnchor:(ARAnchor *)anchor {
    // Create and configure a node for the anchor added to the view's session.
      SKSpriteNode *ssn = [SKSpriteNode spriteNodeWithTexture:[SKTexture textureWithImage:[UIImage imageNamed:@"IMG_3977.PNG"]]];
    //SKSpriteNode对象的x,y轴的位置信息
    ssn.position = CGPointZero;
    //锚点
    ssn.anchorPoint = CGPointMake(0.5, 0.5);
    //SKSpriteNode对象的宽度和高度信息的设置
    ssn.size = CGSizeMake(30, 30);
    //SKSpriteNode对象的名字,也就是SKSpriteNode对象的唯一标识符
    ssn.name = @"动漫小女孩";
    
    NSArray *emojiArray = [NSArray arrayWithObjects:@"🐶",@"🐔",@"🦑",@"🦐",@"🐠",@"🐬",@"🦀", nil];
    NSString *str = emojiArray[arc4random()%(emojiArray.count - 1)];
    SKLabelNode *labelNode = [SKLabelNode labelNodeWithText:str];
    labelNode.horizontalAlignmentMode = SKLabelHorizontalAlignmentModeCenter;
    labelNode.verticalAlignmentMode = SKLabelVerticalAlignmentModeCenter;

    NSMutableArray *arrM = [NSMutableArray array];
    [arrM addObject:labelNode];
    [arrM addObject:ssn];
    
    return arrM[arc4random()%2];
}

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}

@end
