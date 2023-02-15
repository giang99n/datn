#include <MQ2.h> // MQ2 Gas Sensor Library

//const int D0 = 16;
//const int D1 = 5;
//const int D2 = 4;
//const int D3 = 0;
//const int D4 = 2;
//const int D5 = 14;
//const int D6 = 12;
//const int D7 = 13;
//const int D8 = 15;

int pinAout = A0; // pin A0 of NodeMcu is connected to pin A0 of MQ-2
int inputPinMotion = 13;
float  LPG, Co, Smoke; // Variable values of lpg, CO-gas, and Smoke
  
MQ2 mq2(pinAout); //Declare pin A0 connected to A0 pin Arduino
  
void setup(){
 
   Serial.begin(115200); // Baudrate to display data on serial monitor
  pinMode(pinAout,INPUT); //Declare pin A0 as input
  pinMode(inputPinMotion, INPUT);
   mq2.begin(); // Instructions to start the MQ2 sensor

}
  
void loop(){
//   float* values= mq2.read(true); //if set to "false" will not appear on serial monitor
//   LPG = mq2.readLPG();
//   Co = mq2.readCO();
//   Serial.println(Co);
//   Smoke = mq2.readSmoke();

    int val = digitalRead(inputPinMotion);
     Serial.println(val);
//    if (val == HIGH) {
//      Serial.println("Motion detected!");
//    }
//    else {
//      Serial.println("No Motion detected!");
//    }
   delay(1000);
}
