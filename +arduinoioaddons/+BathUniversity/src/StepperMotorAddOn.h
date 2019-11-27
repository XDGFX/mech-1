/**
 * @file HelloWorld.h
 *
 * MathWorks Arduino Add-on library template
 *
 * @copyright Copyright 2015-2016 The MathWorks, Inc.
 *
 */

// Step 1 - Include header files, if any, provided by the 3P library

#include "LibraryBase.h"

// Step 2 - Define debug message strings which will print back in MATLAB
//const char MSG_EXAMPLE_DEBUG[] 	PROGMEM = "Example debug message: cmdID %d\n";

// Define C++ class that inherits from LibraryBase to get properly registered in server
class StepperMotorAddOn : public LibraryBase
{
	public:
		StepperMotorAddOn(MWArduinoClass& a)
		{
            // Step 3 - Define 3P library name
            libName = "BathUniversity/StepperMotorAddOn";
            // Register library name and its pointer.
 			a.registerLibrary(this);
		}
		
	public:
		void commandHandler(byte cmdID, byte* dataIn, unsigned int payloadSize)
		{
            // Print debug message string each time a message is processed
            //debugPrint(MSG_EXAMPLE_DEBUG, cmdID);
            switch (cmdID){
                // Step 4 - Dispatch incoming commands using case statement
                case 0x01:{  
                    byte val [13] = "Pins Set";
                    pinMode(dataIn[0], OUTPUT);
                    pinMode(dataIn[1], OUTPUT);
                    pinMode(dataIn[2], OUTPUT);
                    pinMode(dataIn[3], OUTPUT);
                    digitalWrite(dataIn[0],HIGH);
                    digitalWrite(dataIn[1],LOW);
                    digitalWrite(dataIn[2],HIGH);
                    digitalWrite(dataIn[3],LOW);
                    sendResponseMsg(cmdID, val, 13);
                    break;
                }
                case 0x02:{
                    byte val [13] = "Steps Done";
                    
                    // Parse the input arguments from the data send
                    unsigned int Direction =dataIn[4];  // The direction (0 or 1)
					unsigned int Freq = ((unsigned int)dataIn[6] << 8) + dataIn[5]; // The frequency from 2 bytes (this is if you need numbers larger than 256)
                    unsigned int Pulses = ((unsigned int)dataIn[8] << 8) + dataIn[7]; // The number of pulses from 2 bytes (this is if you need numbers larger than 256)
                    
                    // Set the number of steps to ensure that we alsways end in the correct pin configuration 
                    int steps2do;
                    //steps2do = (int) round(Pulses/4)*4-1;
                    steps2do = Pulses;
                    
                    // Set the sequence values in decimal
                    int curSequence = 0; 
                    int SequenceValues[4] = {10, 6, 5, 9};
                    
                    //Define Period from Frequency
                    double T;
					T = 1/(double)Freq*1000;
					int Tmicro = 0;
					if (T/2<16) {
						double auxT = T*1000;
						Tmicro = (int)auxT;
					}
                    
                    //Execute the steps
                    for (int i=0; i<=steps2do; i++){
                         
                         // Set the pins according to the decimal bit values
                         digitalWrite(dataIn[0],bitRead(SequenceValues[curSequence], 3));
                         digitalWrite(dataIn[1],bitRead(SequenceValues[curSequence], 2));
                         digitalWrite(dataIn[2],bitRead(SequenceValues[curSequence], 1));
                         digitalWrite(dataIn[3],bitRead(SequenceValues[curSequence], 0));
                         
                         // Increment or decrement the next sequence value
                         if (Direction){
                            curSequence--;
                            if (curSequence == -1) {
                            	curSequence = 3;
                            }
                         } else {
                            curSequence++;
                            if (curSequence == 4) {
                            	curSequence = 0;
                            }
                         }
                         
                         // Execute the delay based on the desired period
                         if (Tmicro){
							delayMicroseconds(Tmicro/2);
                         } else {
							delay((int)T/2);
						 }
                         
                     }
                    
                    // Send the response
                    sendResponseMsg(cmdID, val, 10);
                    break;
                }
                default:{
                    // Do nothing
                }
            }
        }
};