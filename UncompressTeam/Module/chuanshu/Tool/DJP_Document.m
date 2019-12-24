//
//  ZZDocument.m
//  UncompressTeam
//
//  Created by MAC on 27/11/2019.
//  Copyright © 2019 ghostlord. All rights reserved.
//

#import "DJP_Document.h"

@implementation DJP_Document

- (BOOL)loadFromContents:(id)contents ofType:(NSString *)typeName error:(NSError * _Nullable __autoreleasing *)outError {
    self.data = contents;
    return YES;
}

@end
