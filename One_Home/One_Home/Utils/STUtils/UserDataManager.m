//
//  UserDataManager.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "UserDataManager.h"

#import "STKeychain.h"

@implementation UserDataManager
static NSString * const KEY_IN_KEYCHAIN = @"com.company.app.allinfo";

NSString * const KEY_USERNAME = @"com.company.app.username";
NSString * const KEY_PASSWORD = @"com.company.app.password";

NSString * const KEY_USERNAME_PASSWORD = @"com.company.app.usernamepassword";

+(void)savePassWord:(NSString *)password
{
    NSMutableDictionary *usernamepasswordKVPairs = [NSMutableDictionary dictionary];
    [usernamepasswordKVPairs setObject:password forKey:KEY_PASSWORD];
    [STKeychain save:KEY_IN_KEYCHAIN data:usernamepasswordKVPairs];
}

+(id)readPassWord
{
    NSMutableDictionary *usernamepasswordKVPair = (NSMutableDictionary *)[STKeychain load:KEY_IN_KEYCHAIN];
    return [usernamepasswordKVPair objectForKey:KEY_PASSWORD];
}

+(void)deletePassWord
{
    [STKeychain delete:KEY_IN_KEYCHAIN];
}
@end
