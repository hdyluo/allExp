//
//  SHDBManager.h
//  Frey
//
//  Created by huangdeyu on 16/3/7.
//  Copyright © 2016年 shcem. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <FMDB.h>
@interface SHDBManager : NSObject
@property(nonatomic,strong) FMDatabaseQueue * dbQueue;
+(instancetype) sharedInstance;

-(NSString *)dbPathWithDirectoryName:(NSString *)dbName;

-(BOOL)changeDBWithDirectoryName:(NSString * )dicName;


-(BOOL)isExistTable:(NSString *)tableName;
-(BOOL)createTable:(NSString *)table;

-(BOOL)insertInTable:(NSString *)tableName withDic:(NSDictionary *)dic;
-(BOOL)updateInTable:(NSString *)tableName withDic:(NSDictionary *)dic;



-(NSArray *)selectAllFromTable:(NSString *)tableName;
-(NSArray *)selectFromTable:(NSString *)tableName withPrimaryKey:(int)primaryId;
-(NSArray *)selectFromTable:(NSString *)table withFormat:(NSString *)formart,...;
-(NSArray *)selectFRomTable:(NSString *)table WithCriteria:(NSString *)criteria;

-(BOOL)clearTable:(NSString *)tableName;
-(BOOL)deleteFromTable:(NSString*)tableName withPrimaryKey:(int)primaryId;
-(BOOL)deleteFromTable:(NSString *)table withFormat:(NSString *)format,...;
-(BOOL)deleFromTable:(NSString *)table withCriteria:(NSString *)criteria;

@end
