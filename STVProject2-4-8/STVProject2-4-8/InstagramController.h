//
//  instagramController.h
//  STVProject2-4-8
//
//  Created by kawaharadai on 2017/09/07.
//  Copyright © 2017年 dai kawahara. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface InstagramController : UIViewController <UIDocumentInteractionControllerDelegate>
// プロパティを定義
@property (nonatomic,retain) UIDocumentInteractionController *documentInteractionController;
// メソッドを定義
+ (BOOL)canInstagramOpen;
- (void)setImage:(UIImage *)image;
- (void)openInstagram;
- (void)deleteView;

@end
