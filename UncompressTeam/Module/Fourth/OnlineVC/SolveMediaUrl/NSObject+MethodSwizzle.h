//
//  NSObject+MethodSwizzle.h
//  PlaceHolderView
//
//  Created by dj on 17/5/16.
//  Copyright © 2017年 PPViedeo. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <objc/runtime.h>

@interface NSObject (MethodSwizzle)

+ (void)PPVideo_swizzleMethod:(SEL)origSelector withMethod:(SEL)newSelector;

@end
