//
//  DYTagContainer.h
//  DYTag
//
//  Created by huangdeyu on 16/1/21.
//  Copyright © 2016年 huangdeyu. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DYTagContainerDelegate<NSObject>
@required
-(void)ChooseTags:(NSArray *)tags;
@end

@interface DYTagContainer : UIView
@property(nonatomic,strong) NSMutableArray * buttontags;

@property(nonatomic,strong) NSMutableArray * currentChoosedText;
@property(nonatomic,weak) id<DYTagContainerDelegate> delegate;
@end
