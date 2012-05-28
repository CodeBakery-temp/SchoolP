#import <Foundation/Foundation.h>

@interface DBService : NSObject

+(id)database;
+(id)createDatabase;
-(id)initDatabase;

-(void) postToDatabase: (NSString *) urlAdress
            sourcePath: (NSString *) theSource;

-(void) lectureToDataBase: (NSDictionary *) dictionary;
-(void) notificationToDataBase: (NSDictionary *) dictionary;

-(void) notificationToDataBase: (NSDictionary *) dictionary;

-(NSDictionary *) getUsers;
-(NSMutableArray *) getLectures;
-(NSDictionary *) getNotifications;


@end
