//
//  SHDBManager.m
//  Frey
//
//  Created by huangdeyu on 16/3/7.
//  Copyright © 2016年 shcem. All rights reserved.
//

#import "SHDBManager.h"
@implementation SHDBManager

+(instancetype)sharedInstance{
    static SHDBManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[SHDBManager alloc] init];
    });
    return manager;
}

-(NSString *)dbPathWithDirectoryName:(NSString *)dbName{
    NSString * docPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSFileManager * fileManager = [NSFileManager defaultManager];
    if (dbName == nil || dbName.length == 0) {
        docPath = [docPath stringByAppendingPathComponent:@"SHCEMDB"];
    }else{
        docPath = [docPath stringByAppendingPathComponent:dbName];
    }
    BOOL isDir;
    BOOL exit =[fileManager fileExistsAtPath:docPath isDirectory:&isDir];
    if (!exit || !isDir) {
        [fileManager createDirectoryAtPath:docPath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    NSString * dbFile = [docPath stringByAppendingPathComponent:@"SHCEM.db"];
    return dbFile;
}
-(BOOL)isExistTable:(NSString *)tableName{
    __block BOOL ret = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db tableExists:tableName];
    }];
    return ret;
}
-(BOOL)createTable:(NSString *)tableName{
    if (tableName == nil  || tableName.length == 0) {
        return NO;
    }
    __block BOOL ret = YES;
    [self.dbQueue inTransaction:^(FMDatabase *db, BOOL *rollback) {
        if (![db executeUpdate:[NSString stringWithFormat:@"CREATE TABLE IF NOT EXISTS %@ (id integer PRIMARY KEY,item blob NOT NULL);",tableName]]) {
            ret = NO;
            *rollback = YES;
            return;
        }
    }];
    return ret;
}

-(BOOL)insertInTable:(NSString *)tableName withDic:(NSDictionary *)dic{
    __block BOOL ret = YES;
    if (![self isExistTable:tableName]) {
        [self createTable:tableName];
    }
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dic];
        NSNumber * pk = [dic objectForKey:@"pk"];
        int intPk = [pk intValue];
        ret = [db executeUpdate:[NSString stringWithFormat:@"INSERT INTO %@(id,item) VALUES (%d,%@)",tableName,intPk,data]];
    }];
    return ret;
}
-(BOOL)updateInTable:(NSString *)tableName withDic:(NSDictionary *)dic{
    __block BOOL ret = YES;
    if (![self isExistTable:tableName]) {
        [self createTable:tableName];
    }
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        NSData * data = [NSKeyedArchiver archivedDataWithRootObject:dic];
        NSNumber * pk = [dic objectForKey:@"pk"];
        int intPk = [pk intValue];
        ret = [db executeUpdate:[NSString stringWithFormat:@"UPDATE %@ SET  item=%@ WHERE id = %d;",tableName,data,intPk]];
    }];
    return ret;
}


-(NSArray *)selectAllFromTable:(NSString *)tableName{
   __block NSMutableArray * list = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * set = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@;",tableName]];
        while (set.next) {
            NSData * dicData = [set objectForColumnName:@"item"];
            NSDictionary * dict = [NSKeyedUnarchiver unarchiveObjectWithData:dicData];
            [list addObject:dict];
        }
    }];
    return list;
}
-(NSArray *)selectFromTable:(NSString *)tableName withPrimaryKey:(int)primaryId{
    NSString * res = [NSString stringWithFormat:@"WHERE id=%d;",primaryId];
    return [self selectFRomTable:tableName WithCriteria:res];
}
-(NSArray *)selectFromTable:(NSString *)table withFormat:(NSString *)formart,...{
    va_list ap;
    va_start(ap, formart);
    NSString *criteria = [[NSString alloc] initWithFormat:formart locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    return [self selectFRomTable:table WithCriteria:criteria];
}
-(NSArray *)selectFRomTable:(NSString *)table WithCriteria:(NSString *)criteria{
   __block NSMutableArray * array = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        FMResultSet * res = [db executeQuery:[NSString stringWithFormat:@"SELECT * FROM %@ %@",table,criteria]];
        while ([res next]) {
            NSData * data = [res objectForColumnName:@"item"];
            NSDictionary * dic = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [array addObject:dic];
        }
    }];
    return array;
}

-(BOOL)clearTable:(NSString *)tableName{
    __block BOOL ret = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@;",tableName]];
    }];
    return ret;
}
-(BOOL)deleteFromTable:(NSString*)tableName withPrimaryKey:(int)primaryId{
    NSString * res = [NSString stringWithFormat:@"WHERE id = %d;",primaryId];
    return  [self deleFromTable:res withCriteria:res];
}
-(BOOL)deleteFromTable:(NSString *)table withFormat:(NSString *)format,...{
    va_list ap;
    va_start(ap, format);
    NSString *criteria = [[NSString alloc] initWithFormat:format locale:[NSLocale currentLocale] arguments:ap];
    va_end(ap);
    
    return [self deleFromTable:table withCriteria:criteria];
}
-(BOOL)deleFromTable:(NSString *)table withCriteria:(NSString *)criteria{
    __block BOOL ret = YES;
    [self.dbQueue inDatabase:^(FMDatabase *db) {
        ret = [db executeUpdate:[NSString stringWithFormat:@"DELETE FROM %@ %@",table,criteria]];
    }];
    return YES;
}
//保留
-(BOOL)changeDBWithDirectoryName:(NSString *)dicName{
    if (self.dbQueue) {
        self.dbQueue = nil;
    }
    self.dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self dbPathWithDirectoryName:nil]];
    return YES;
}

#pragma mark - private method

-(NSData *)dicToData:(NSDictionary * )dic{
    NSJSONSerialization
}


#pragma mark - setter
-(FMDatabaseQueue *)dbQueue{
    if (_dbQueue == nil) {
        _dbQueue = [[FMDatabaseQueue alloc] initWithPath:[self dbPathWithDirectoryName:nil]];
    }
    return _dbQueue;
}

@end
