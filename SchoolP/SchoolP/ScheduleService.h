#import <Foundation/Foundation.h>

@class User, Lecture;

@interface ScheduleService : NSObject

+(id)schedule;
+(id)createSchedule;
-(id)initSchedule;


-(NSArray*)getLecturesOfWeek: (User*)user
                    lectures: (NSArray *)lectures
                 currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getLecturesPerDays:(NSArray *)lectures;

-(NSDictionary*)getLecturesWithVersion:(NSDictionary*)lectures;

-(NSDictionary*)getLecturesPerDaysRefined:(NSArray*)lectures;

-(NSSet*)getLecturesOfDay:(NSDictionary*)lectures;

-(NSArray*)getNotesOfWeek: (User*)user
                    notes: (NSArray *)notes
              currentWeek: (NSUInteger)currentWeek;

-(NSDictionary*)getNotesPerDays:(NSArray *)notes;

-(NSSet*)getNotesOfDay:(NSDictionary*)notes;

-(NSArray*)getUserMessages: (User*)user
             notifications: (NSArray *)notifications;

-(void)createLecture:(NSArray *)lectures 
             jsonPath:(NSString *)jsonPath; 

-(void)createNote:(NSString *)jsonPath;

-(void)createMessage:(NSString *)jsonPath;

// TEST
-(void)updateLectureTemplate:(NSString*)courseID 
                    lectures:(NSArray*) lectures 
                    jsonPath:(NSString*)jsonPath;

-(void)updateLectureEvent:(NSString*)courseID 
                  version:(NSString*)version 
                 lectures:(NSArray*) lectures 
                 jsonPath:(NSString*)jsonPath;

// APP
-(void)updateLectureTemplate:(Lecture*)lecture;

-(void)updateLectureEvent:(Lecture*)lecture;


-(void)printCurrentWeek:(NSDictionary*)lectures 
                  notes:(NSDictionary*)notes;

-(void)printCurrentDay:(NSDictionary*)lectures 
                 notes:(NSDictionary*)notes;

@end
