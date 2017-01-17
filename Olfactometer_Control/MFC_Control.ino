// =======================================
// MFC control functions

boolean MFC_DEBUG = false;
int command_delay_time = 10;

void MFC_Println(char* text) {
  digitalWrite(RTS_pin, HIGH); // RTS low
  Serial1.println(text);
  Serial1.flush();
  digitalWrite(RTS_pin, LOW); // RTS low
  
  if (MFC_DEBUG) {
    Serial.print("==> ");
    Serial.println(text);
  }
}

char MFCBuffer[1024];
void MFC_Read() {
  char inByte;
  int len;
  MFCBuffer[0] = 0;
  len = Serial1.readBytesUntil('\n', MFCBuffer, 1024);
  MFCBuffer[len] = 0; 
  if (MFC_DEBUG) {
    Serial.print("<--   ");
    Serial.println(MFCBuffer);
  }
}




void setMFCToDigital(char* address) {
   String command = "!";
   command += address;
   command += ",M,D";
   command.toCharArray(MFCBuffer,1024);
   MFC_Println(MFCBuffer);
   MFC_Read();
   String response = MFCBuffer;
   
   if (!response.startsWith(String("!"+ String(address)))) {
     Serial.println("ERROR: bad MFC reponse.");
     return;
   }
}


float setMFCFlow(char* address, float flowRate) {
   String command = "!";
   command += address;
   command += ",S,";
   command += flowRate;
   command.toCharArray(MFCBuffer,1024);
   MFC_Println(MFCBuffer);
   MFC_Read();
   String response = MFCBuffer;
   
   if (!response.startsWith(String("!"+ String(address)+",S"))) {
     Serial.println("ERROR: bad MFC reponse.");
     return -1;
   }
   
   float val = response.substring(4).toFloat();
   
   return val;
} 

float getMFCFlowRate(char* address) {
   String command = "!";
   command += address;
   command += ",F";
   command.toCharArray(MFCBuffer,1024);
   MFC_Println(MFCBuffer);
   MFC_Read();
   String response = MFCBuffer;
   
   if (!response.startsWith(String("!"+ String(address)))) {
     Serial.println("ERROR: bad MFC reponse.");
     return -1.0;
   }
   
   float val = response.substring(4).toFloat();
   
   return val;
} 

void getMFCModelNumber(char* address) {
   String command = "!";
   command += address;
   command += ",MR,2";
   command.toCharArray(MFCBuffer,1024);
   MFC_Println(MFCBuffer);
   MFC_Read();
}


void setMFCAddress(char* current_address, char* new_address) {
   String command = "!";
   command += current_address;
   command += ",MW,7,";
   command += new_address;
   command.toCharArray(MFCBuffer,1024);
   MFC_Println(MFCBuffer);
   MFC_Read();
   String response = MFCBuffer;
   
   if (!response.startsWith(String("!"+ String(new_address)))) {
     Serial.println("ERROR: bad MFC reponse.");
     return;
   }
}

void setMFCUnitsToSLPM(char* address) {
   String command = "!";
   command += address;
   command += ",U,SLPM";
   command.toCharArray(MFCBuffer,1024);
   MFC_Println(MFCBuffer);
   MFC_Read();
   String response = MFCBuffer;
   
   if (!response.startsWith(String("!"+ String(address)+ ",USLPM"))) {
     Serial.println("ERROR: bad MFC reponse to units change.");
     return;
   }
}


void setupMFC(char* address, float flowRate) {
  getMFCModelNumber(address);
  delay(command_delay_time);
  setMFCToDigital(address);
  delay(command_delay_time);
  setMFCUnitsToSLPM(address);
  delay(command_delay_time);
  setMFCFlow(address, flowRate);
  delay(command_delay_time);
}

void changeMFCFlowRate(char* address, float flowRate) {
  setMFCFlow(address, flowRate);
  delay(command_delay_time);
}


