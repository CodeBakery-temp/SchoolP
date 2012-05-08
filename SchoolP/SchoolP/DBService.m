#import "DBService.h"
#import "Student.h"
#import "StudentService.h"

NSString *const usersDB = @"http://you.iriscouch.com/schema/";
NSString *const getAll = @"_all_docs?include_docs=true";


@implementation DBService {
    
    NSMutableArray *users;
}


+(id)database {
    return [self createDatabase];
}
+(id)createDatabase {
    return [[self alloc] initDatabase];
}

-(id)init {
    return [self initDatabase];
}
-(id)initDatabase {
    if(self = [super init])
    {
        users = [NSMutableArray array];
        //NSLog(@"DB: %@", self);
        //NSLog(@"Array: %@", users);
    }
    return self;
}


-(NSArray*)getAllUsers {
    NSString* urlString = [NSString stringWithFormat:@"http://zephyr.iriscouch.com/grand-schema/_all_docs?include_docs=true"];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request returningResponse:NULL error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *usersDic = [NSJSONSerialization 
                                         JSONObjectWithData:data 
                                         options:NSJSONReadingMutableContainers 
                                         error:NULL];
        
        usersDic = [usersDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in usersDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            //NSLog(@"OBJECT: %@", [dict allKeys]);
            Student* student = [Student studentWithName:[dict objectForKey:@"firstName"] 
                                               lastName:[dict objectForKey:@"lastName"] 
                                            mailAddress:[dict objectForKey:@"email"] 
                                            phoneNumber:[dict objectForKey:@"phone"]];
            [users addObject:student];
        }
        /*for (Student* student in users) {
         NSLog(@"%@", student);
         }*/
        return users;
    }
    
}

@end
