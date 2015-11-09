//
//  ZXPostModel.h
//  LoveCar
//
//  Created by zency on 15/10/15.
//  Copyright © 2015年 Zency. All rights reserved.
//

#import "JSONModel.h"

@interface ZXPostModel : JSONModel

@property (copy, nonatomic)NSString <Optional>*author;

@property (strong, nonatomic)NSNumber <Optional>*createDate;

@property (copy, nonatomic)NSString <Optional>*forumName;

@property (strong, nonatomic)NSNumber <Optional>*hasImage;

@property (strong, nonatomic)NSNumber <Optional>*postId;

@property (copy, nonatomic)NSString <Optional>*postImage;

@property (copy, nonatomic)NSString <Optional>*postLink;

@property (copy, nonatomic)NSString <Optional>*postTitle;

@property (strong, nonatomic)NSNumber <Optional>*replyCount;

@property (strong, nonatomic)NSNumber <Optional>*replyDate;

@property (strong, nonatomic)NSNumber <Optional>*viewCount;

@property (strong, nonatomic)NSNumber <Optional>*postType;

@property (strong, nonatomic)NSNumber <Optional>*adId;

@property (copy, nonatomic)NSString <Optional>*essenceCategory;

@property (assign, nonatomic)NSNumber <Optional>*isTop;

@property (strong, nonatomic)NSNumber <Optional>*type;

@end
