#import "Note.h"
#import "DBService.h"
#import "Lecture.h"
#import "Message.h"
#import "Menu.h"
#import "User.h"

NSString *const usersDB = @"http://you.iriscouch.com/schoolp-users/";
NSString *const lecturesDB = @"http://you.iriscouch.com/schoolp-schedules/";
NSString *const notificationsDB = @"http://you.iriscouch.com/schoolp-notifications/";
NSString *const getAll = @"_all_docs?include_docs=true";


@implementation DBService {
    
    NSMutableDictionary *users;
    NSMutableDictionary *notifications;
    NSMutableArray *lectures;
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
        users = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                 [NSMutableArray array], @"ADMIN",
                 [NSMutableArray array], @"STUDENT", nil];
        notifications = [NSMutableDictionary dictionaryWithObjectsAndKeys:
                         [NSMutableArray array], @"NOTES",
                         [NSMutableArray array], @"MESSAGES", nil];
        lectures = [NSMutableArray array];
    }
    return self;
}

/*********************************************************************
 METHOD : POST DATA TO DATABASE - DIRECT SOURCE TO DATABASE PATH
 ACCEPTS: NSString URL to database, NSString PATH to JSON DATA    
 RETURNS: NONE
 *********************************************************************/
+(void) postToDatabase:(NSString *) urlAdress sourcePath:(NSString *)theSource{
    
    //prepare request
    NSString *urlString = [NSString stringWithString: urlAdress];
    //@"http://127.0.0.1:5984/users"];
    //@"http://Zephyr:zephyr@zephyr.iriscouch.com/schoolp-notifications"];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:[NSData dataWithContentsOfFile:theSource]];
    //@"/Users/DQF/Desktop/CodeBakery/JSON/Glen.json"
    
    //post
    [request setHTTPBody:postBody];
    
    //get response
    NSHTTPURLResponse* urlResponse = nil;  
    NSError *error = [[NSError alloc] init];  
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %ld", [urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
        
        //here you get the response
    }
}

/*********************************************************************
 METHOD : POST LECTURE OBJECT TO LECTURE DATABASE
 ACCEPTS: Lecture object as NSDictionary    
 RETURNS: NONE
 *********************************************************************/
+(void) lectureToDataBase:(NSDictionary *)dictionary{
    NSData *tempData;
    
    if([NSJSONSerialization isValidJSONObject:dictionary])
    {
        tempData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:NULL];
    }
    //prepar request
    NSString *urlString = [NSString stringWithString: lecturesDB];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:tempData];
    //@"/Users/DQF/Desktop/CodeBakery/JSON/Glen.json"
    
    //post
    [request setHTTPBody:postBody];
    
    //get response
    NSHTTPURLResponse* urlResponse = nil;  
    NSError *error = [[NSError alloc] init];  
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %ld", [urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
        
        //here you get the response
    }
}

/*********************************************************************
 METHOD : POST NOTE OR MESSAGE OBJECT TO NOTIFICATION DATABASE
 ACCEPTS: Note or Message object as NSDictionary    
 RETURNS: NONE
 *********************************************************************/
+(void) noteficationToDataBase:(NSDictionary *)dictionary{
    NSData *tempData;
    
    if([NSJSONSerialization isValidJSONObject:dictionary])
    {
        tempData = [NSJSONSerialization dataWithJSONObject:dictionary
                                                   options:NSJSONWritingPrettyPrinted
                                                     error:NULL];
    }
    //prepare request
    NSString *urlString = [NSString stringWithString: notificationsDB];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"POST"];
    
    //set headers
    NSString *contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField: @"Content-Type"];
    
    //create the body
    NSMutableData *postBody = [NSMutableData data];
    
    [postBody appendData:tempData];
    //@"/Users/DQF/Desktop/CodeBakery/JSON/Glen.json"
    
    //post
    [request setHTTPBody:postBody];
    
    //get response
    NSHTTPURLResponse* urlResponse = nil;  
    NSError *error = [[NSError alloc] init];  
    NSData *responseData = [NSURLConnection sendSynchronousRequest:request returningResponse:&urlResponse error:&error];  
    NSString *result = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Response Code: %ld", [urlResponse statusCode]);
    if ([urlResponse statusCode] >= 200 && [urlResponse statusCode] < 300) {
        NSLog(@"Response: %@", result);
        //here you get the response
    }
}

/*********************************************************************
 METHOD : GET ALL USER OBJECTS FROM USERS DATABASE
 ACCEPTS: NONE    
 RETURNS: NSDictionary with lists of Student and Admin objects
 *********************************************************************/
-(NSDictionary*)getUsers {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", usersDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
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
            
            User* usr = [User userWithName:[dict objectForKey:@"firstName"] 
                                  lastName:[dict objectForKey:@"lastName"]
                                  password:[dict objectForKey:@"password"]
                               mailAddress:[dict objectForKey:@"mailAddress"]
                               phoneNumber:[dict objectForKey:@"phoneNumber"] 
                                     admin:[dict objectForKey:@"admin"]
                                   courses:[dict objectForKey:@"courses"]];
            
            if([[dict objectForKey:@"admin"]isEqualToString:@"0"]) {
                [[users objectForKey:@"STUDENT"] addObject:usr];
            }
            else {
                [[users objectForKey:@"ADMIN"] addObject:usr];
            }
        }
        return users;
    }
}

/*********************************************************************
 METHOD : GET ALL LECTURE OBJECTS FROM LECTURE DATABASE
 ACCEPTS: NONE    
 RETURNS: NSMutableArray list with Lecture objects
 *********************************************************************/
-(NSMutableArray*)getLectures {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", lecturesDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
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
            Lecture* lecture = [Lecture courseWithName:[dict objectForKey:@"course"] 
                                                 grade:[dict objectForKey:@"grade"]
                                               teacher:[dict objectForKey:@"teacher"] 
                                                  room:[dict objectForKey:@"room"]
                                              courseID:[dict objectForKey:@"courseID"]
                                               version:[dict objectForKey:@"version"]
                                             startTime:[dict objectForKey:@"startTime"] 
                                              stopTime:[dict objectForKey:@"stopTime"] 
                                            lunchStart:[dict objectForKey:@"lunchStart"] 
                                             lunchStop:[dict objectForKey:@"lunchStop"]
                                                  year:[dict objectForKey:@"year"]
                                            daysOfWeek:[dict objectForKey:@"daysOfWeek"]
                                                 weeks:[dict objectForKey:@"weeks"]
                                             couchDBId:[dict objectForKey:@"_id"] 
                                            couchDBRev:[dict objectForKey:@"_rev"]];
            
            [lectures addObject:lecture];
        }
        return lectures;
    }
}
/*********************************************************************
 METHOD : GET ALL NOTE AND MESSAGE OBJECTS FROM NOTIFICATION DATABASE
 ACCEPTS: NONE    
 RETURNS: NSDictionary with lists of Note and Message objects
 *********************************************************************/
-(NSDictionary*)getNotifications {
    NSString* urlString = [NSString stringWithFormat:@"%@%@", notificationsDB, getAll];
    NSMutableURLRequest* request = [[NSMutableURLRequest alloc] init];
    [request setURL:[NSURL URLWithString:urlString]];
    [request setHTTPMethod:@"GET"];
    
    NSString* contentType = [NSString stringWithFormat:@"application/json"];
    [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
    
    NSError* error;
    NSData* data = [NSURLConnection sendSynchronousRequest:request
                                         returningResponse:NULL
                                                     error:&error];
    if(!data) {
        NSLog(@"FAILED: %@", [error localizedDescription]);
        return nil;
    }
    else {
        NSMutableDictionary *noticesDic = [NSJSONSerialization 
                                           JSONObjectWithData:data 
                                           options:NSJSONReadingMutableContainers 
                                           error:NULL];
        
        noticesDic = [noticesDic objectForKey:@"rows"]; // Step into 'rows'
        for (NSDictionary *object in noticesDic) {    // Step into JSON array (single index)
            NSDictionary* dict = [object objectForKey:@"doc"]; // Step into 'doc' (current object key/values)
            //NSLog(@"OBJECT: %@", [dict allKeys]);
            if([[dict objectForKey:@"type"]isEqualToString:@"note"]) {
                Note* note = [Note noteWithText:[dict objectForKey:@"text"] 
                                           week:[dict objectForKey:@"week"] 
                                            day:[dict objectForKey:@"day"] 
                                       courseID:[dict objectForKey:@"courseID"]];
                [[notifications objectForKey:@"NOTES"] addObject:note];
            }
            else if ([[dict objectForKey:@"type"]isEqualToString:@"message"]){
                Message* message = [Message messageWithSender:[dict objectForKey:@"sender"] 
                                                     receiver:[dict objectForKey:@"receiver"] 
                                                         text:[dict objectForKey:@"text"]];
                [[notifications objectForKey:@"MESSAGES"] addObject:message];
            }
        }
        return notifications;
    }
}

@end
