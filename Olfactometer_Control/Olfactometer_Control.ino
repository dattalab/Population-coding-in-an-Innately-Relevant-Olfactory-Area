// Ofer Mazor and Giuliano Iurilli

// User-modifiable global variables:
// =================================

boolean BNC_OUTPUT = true; // set to true/false for BNC to be output/input

boolean ONE_VALVE_OPEN = true; // When true, exactly one valve is open at a time. Value 1 is open by default.
// When false, every value openeing and closing is explicitly controlled by user.

boolean TRIGGER_WHEN_OPEN = true; // Outputs a TTL pulse every time a valve is open (besides valve 1).
// Will only work if BNC_OUTPUT and ONE_VALVE_OPEN are also true.

boolean DISPLAY_VALVE_STATUS = true; // Write all valve openings/closing to USB

float CARRIER_FLOW_RATE = 1; // in LPM
float ODOR_FLOW_RATE = 0.15; // in LPM


// =================================
// Pin Assignments
int RTS_pin = A5;
int BNC_pin = 2;
int V1 = 3;
int V2 = 4;
int V3 = 5;
int V4 = 6;
int V5 = 7;
int V6 = 8;
int V7 = 9;
int V8 = 10;
int V9 = 11;
int V10 = 12;
int V11 = 13;
int V12 = A0;
int V13 = A1;
int V14 = A2;
int V15 = A3;
int V16 = A4;

int num_valves = 16;
int all_valves[] = {V1, V2, V3, V4, V5, V6, V7, V8, V9, V10, V11, V12, V13, V14, V15, V16};
String odorants[15] = {"IA0", "IA1", "IA2", "IA3", "IA4", "TM0", "TM1", "TM2", "TM3", "TM4", "RO0", "RO1", "RO2", "RO3", "RO4"};

// =================================
// Experiment variables
int number_of_trials = 10;
int stimulus_duration = 2000;
//int inter_stimulus_interval = 28000;
int preTriggerDelay = 3000;

// =======================================
//     MFC Addresses
// (DO NOT CHANGE THESE)
char* default_address = "11";
char* carrier_address = "02";
char* odor_address = "04";

// =======================================
// Valve control functions

int current_valve = 1;
void OpenValve(int valveNum) {
  // error checking
  if (digitalRead(all_valves[valveNum - 1]) == HIGH) {
    Serial.print(F("Valve ")); Serial.print(valveNum); Serial.println(F("already open."));
    return;
  }
  if ((ONE_VALVE_OPEN) && (valveNum == 1)) {
    Serial.println(F("Warning: Valve 1 cannot be directly opened in 'ONE_VALVE_OPEN' mode."));
    return;
  }


  // close the currenly open valve, if necessary
  if (ONE_VALVE_OPEN) {
    if (TRIGGER_WHEN_OPEN) {
      digitalWrite(BNC_pin, HIGH);
    }
    delay(preTriggerDelay);
    // open the valve
    digitalWrite(all_valves[valveNum - 1], HIGH);
    digitalWrite(all_valves[current_valve - 1], LOW);
    //    if (current_valve==1) {
    //            Serial.println("-- V1 Closed --");
    //    }
    if (DISPLAY_VALVE_STATUS && (current_valve > 1)) {
      //Serial.print("Valve ");
      Serial.print(current_valve);
      Serial.print(",");
      //Serial.println(" CLOSED.");
    }
  }
  if (ONE_VALVE_OPEN) {
    current_valve = valveNum;
  }
  if (DISPLAY_VALVE_STATUS) {
    //Serial.print("   VALVE ");
    Serial.print(valveNum);
    Serial.print(",");
    //Serial.println(" OPEN.");
  }
}

void CloseValve(int valveNum) {
  // error checking
  if (digitalRead(all_valves[valveNum - 1]) == LOW) {
    Serial.print(F("Cannot close valve ")); Serial.print(valveNum); Serial.println(F(", it's not open."));
    return;
  }
  if (ONE_VALVE_OPEN && (valveNum == 1)) {
    Serial.println(F("Warning: Valve 1 cannot be directly closed in 'ONE_VALVE_OPEN' mode."));
    return;
  }

  // close valve
  digitalWrite(all_valves[valveNum - 1], LOW);

  // open valve 1 if necessary
  if (ONE_VALVE_OPEN) {
    current_valve = 1;
    digitalWrite(V1, HIGH);
    //    Serial.println("-- V1 Open --");
    if (TRIGGER_WHEN_OPEN) {
      digitalWrite(BNC_pin, LOW);
    }
  }
  if (DISPLAY_VALVE_STATUS) {
    //Serial.print("Valve ");
    Serial.print(valveNum);
    Serial.print(",");
    //Serial.println(" CLOSED.");
  }
}


// =======================================
// BNC Triggering Functions
void WaitForTrigger() {
  while (digitalRead(BNC_pin) == LOW) {};
}



// === SETUP ===
// the setup function runs once when you press reset or power the board
void setup() {

  // Set up pins for valve control
  for (int i = 0; i < num_valves; i++) {
    pinMode(all_valves[i], OUTPUT);
    digitalWrite(all_valves[i], LOW);
  }
  if (ONE_VALVE_OPEN) {
    digitalWrite(V1, HIGH);
  }

  // Set up pin for BNC input/output
  if (BNC_OUTPUT) {
    pinMode(BNC_pin, OUTPUT);
    digitalWrite(BNC_pin, LOW); // BNC low
  } else {
    pinMode(BNC_pin, INPUT);
  }

  // start connections with the MFCs (Serial1 / RS485)
  pinMode(RTS_pin, OUTPUT);
  digitalWrite(RTS_pin, LOW); // RTS low
  Serial1.begin(9600);

  // start USB connection with the computer
  Serial.begin(9600);
  //while (!Serial) ;

  // Setup MFCs
  delay(3000); // wait unlit MFCs are active and ready for input...
  setupMFC(carrier_address, CARRIER_FLOW_RATE); // set carrier stream to 1 LPM
  setupMFC(odor_address, ODOR_FLOW_RATE);   // set odor stream to 0.1 LPM

  delay(3000);
  //  Serial.println("CARRIER Flow Rate: ");
  //  Serial.print(" Set to: ");
  //  Serial.print(CARRIER_FLOW_RATE);
  //  Serial.println(" LPM");
  //  Serial.print(" Actual: ");
  //  Serial.print(getMFCFlowRate(carrier_address));
  //  Serial.println(" LPM");
  //  Serial.println("");
  //
  //  Serial.println("ODOR Flow Rate: ");
  //  Serial.print(" Set to: ");
  //  Serial.print(ODOR_FLOW_RATE);
  //  Serial.println(" LPM");
  //  Serial.print(" Actual: ");
  //  Serial.print(getMFCFlowRate(odor_address));
  //  Serial.println(" LPM");
  //  Serial.println("");

}


// =================
// === MAIN LOOP ===
// =================





void loop() {
  if (Serial.available()) {
    char ch = Serial.read();
    if ( isDigit(ch) ) {
      if ( ch == '0' ) {
        idle();
      }
      else if ( ch == '1' ) {
        olfStim();
      }
    }
  }
}





void olfStim() {
  boolean quit = 0;
  boolean quitt = 0;
  if ( quit == 0 ) {
    for (int trial = 1; trial < number_of_trials + 1; trial++) {
      if (quitt == 0) {
        randomSeed(micros());
        int array[15] = {2,3,4,5,6,7,8,9,10,11,12,13,14,15,16};
        for (int i= 0; i< 15; i++) {
          int pos = random(14);
//      int array[13] = {2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13};
//        for (int i = 0; i < 13; i++) {
//          int pos = random(12);
          int temp = array[i];
          array[i] = array[pos];
          array[pos] = temp;
        }

        for (int v=0; v<15; v++) {
        //for (int v = 0; v < 13; v++) {
          if (Serial.available()) {
            char ch = Serial.read();
            if ( isDigit(ch) ) {
              if ( ch == '0' ) {
                idle();
                quit = 1;
                quitt = 1;
                break;
              }
            }
          }
          else {
            quitt = 0;
          }
          //Serial.print("TRIAL ");
          Serial.print(trial);
          Serial.print(",");
          Serial.print(v + 1);
          Serial.print(",");
          randomSeed(micros());
          int inter_stimulus_delay = random(25000, 45000);
          OpenValve(array[v]);
          //Serial.print(",");
          //Serial.print("CARRIER rate: ");
          Serial.print(getMFCFlowRate(carrier_address));
          Serial.print(",");
          //Serial.print("ODOR rate: ");
          Serial.print(getMFCFlowRate(odor_address));
          Serial.print(",");
          delay(stimulus_duration);
          CloseValve(array[v]);
          //Serial.print("CARRIER rate: ");
          Serial.print(getMFCFlowRate(carrier_address));
          Serial.print(",");
          //Serial.print("ODOR rate: ");
          Serial.print(getMFCFlowRate(odor_address));
          Serial.print(",");
          Serial.print(odorants[array[v] - 2]);
          Serial.print(",");
          inter_stimulus_delay = abs(inter_stimulus_delay);
          Serial.println(inter_stimulus_delay);
          //Serial.println("");
          delay(inter_stimulus_delay);
        }
      }
      else {
        break;
      }
    }
    quit = 1;
  }
}

void idle() {
  if (TRIGGER_WHEN_OPEN) {
    digitalWrite(BNC_pin, LOW);
  }
  // close valves
  for (int v = 0; v < 15; v++) {
    digitalWrite(all_valves[v], LOW);
  }
  // open valve 1 if necessary
  if (ONE_VALVE_OPEN) {
    current_valve = 1;
    digitalWrite(V1, HIGH);
    //Serial.println("DPG");
  }
  //Serial.print("CARRIER rate: ");
  //Serial.println(getMFCFlowRate(carrier_address));
  //Serial.print("ODOR rate: ");
  //Serial.println(getMFCFlowRate(odor_address));
  //Serial.println("");
  //Serial.print("  IDLING... ");
}

