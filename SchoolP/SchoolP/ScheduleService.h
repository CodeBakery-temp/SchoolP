#import <Foundation/Foundation.h>

@class User, Lecture;

@interface ScheduleService : NSObject

+(id)schedule;
+(id)createSchedule;
-(id)initSchedule;


-(NSArray*)getLecturesOfWeek: (User*)user
                 currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getLecturesPerDays:(NSArray *)lectures;

-(NSDictionary*)getLecturesWithVersion:(NSDictionary*)lectures;

-(NSDictionary*)getLecturesPerDaysRefined:(NSArray*)lectures;

-(NSSet*)getLecturesOfDay:(NSDictionary*)lectures;

-(NSArray*)getNotesOfWeek: (User*)user
              currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getNotesPerDays:(NSArray *)notes;

-(NSSet*)getNotesOfDay:(NSDictionary*)notes;

-(NSArray*)getUserMessages:(User*)user;

-(void)createLecture:(NSString *)jsonPath; 

-(void)createNote:(NSString *)jsonPath;

-(void)createMessage:(NSString *)jsonPath;

// TEST
-(void)updateLectureTemplate:(NSString*)courseID  
                    jsonPath:(NSString*)jsonPath;

-(void)updateLectureEvent:(NSString*)courseID 
                  version:(NSString*)version  
                 jsonPath:(NSString*)jsonPath;

// APP
-(void)updateLectureTemplate:(Lecture*)lecture; // TO-DO

-(void)updateLectureEvent:(Lecture*)lecture; // TO-DO


-(void)printCurrentWeek:(NSDictionary*)lectures 
                  notes:(NSDictionary*)notes;

-(void)printCurrentDay:(NSDictionary*)lectures 
                 notes:(NSDictionary*)notes;

-(void)printInbox:(NSArray*)messages;

@end
