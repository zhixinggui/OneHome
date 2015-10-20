//
//  DBManager.m
//  LimitFreeComplete
//
//  Created by Yuen on 15/6/7.
//  Copyright (c) 2015年 Yuen. All rights reserved.
//

#import "DBManager.h"
#import "FMDatabase.h"

@implementation DBManager
{
    FMDatabase *_database;
    NSLock     *_lock; // 锁
}

//+ (instancetype)shareManager
//{
//    static DBManager *manager = nil;
//    
//    static dispatch_once_t onceToken;
//    
//    dispatch_once(&onceToken, ^{
//        manager = [[[self class] alloc] init];
//    });
//    
//    return manager;
//}
//
//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        _lock = [[NSLock alloc] init];
//       // [self createDatabase];
//    }
//    return self;
//}

//- (void)createDatabase
//{
//    _database = [[FMDatabase  alloc] initWithPath:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/qsbk.db"]];
//    BOOL isOpen = [_database open];
//    if (!isOpen) {
//        NSLog(@"打开数据库失败:%@", _database.lastErrorMessage);
//    } else {
//        
//        NSString *createArticle = @"create table if not exists aticle(articleId varchar(100) , login varchar(50), content varchar(200),  imageURL varchar(255), status bit)";
//        
//        BOOL flag = [_database executeUpdate:createArticle];
//        if (!flag) {
//            NSLog(@"创建表失败:%@", _database.lastErrorMessage);
//        }
//    }
//}
//
//


//- (NSArray *)getAll
//{
//    return [NSArray array];
//}
//- (BOOL)deleteArticleWithID:(NSString *)articleID
//{
//    BOOL ret = [_database executeUpdate:@"delete from article where articleId = ?", articleID];
//    if (!ret) {
//        NSLog(@"删除数据失败: %@", _database.lastErrorMessage);
//    }
//    return ret;
//}


// 判断是否已经收藏
//- (BOOL)isExists:(NSString *)articleId;
//{
//    int count = 0;
//    
//    // sql
//    // as cnt   别名
//    // count(*) 搜索结果的个数
//    NSString *sql = @"select count(*) as cnt from article where articleId = ?";
//    FMResultSet *rs = [_database executeQuery:sql, articleId];
//    if ([rs next]) {
//        count = [rs intForColumn:@"cnt"];
//    }
//    
//    if (count > 0) {
//        return YES;
//    }
//    return NO;
//}

@end
