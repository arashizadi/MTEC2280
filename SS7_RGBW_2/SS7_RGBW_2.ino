//RGBW by A.I,
//instruction: tap the button once to toggle the lights.
const int LEDs[8] = { 13, 12, 11, 10, 9, 8, 7, 6 };
const int BUTTONPIN = 2;
int buttonState = 0, phase = 7;
bool buttonToggle = false;
unsigned long currentTime = 0, savedTime = 0, buttonCoolDown = 0;

const unsigned long phaseTime[6][20] = {
{ 2000, 4000, 6000, 8000, 10000, 12000, 13000, 13125, 13250, 13375, 13500, 13625, 13750, 13875, 13900, 13950, 14000, 14050, 14100, 14200 },
{ 400, 800, 1200, 1600, 2000, 2400, 2800, 3200, 3600, 4000, 4400, 4800, 5200, 5600, 6000, 6400, 6800, 7200, 7600, 8000 },
{ 3000, 2000, 3500, 3000, 2000, 4000, 4000, 6000, 6500, 937, 950, 1625, 1750, 2875, 2900, 4950, 4000, 1050, 1100, 14200 },
{ 1000, 1065, 1130, 1195, 1260, 1325, 1390, 1455, 1520, 1585, 1650, 1715, 1780, 1845, 1910, 1975, 2040, 2105, 2170, 2235 },
{ 100, 200, 300, 400, 500, 600, 700, 800, 900, 1000, 1100, 1200, 1300, 1400, 1500, 1600, 1700, 1800, 1900, 2000 },
{ 800, 800, 800, 450, 450, 450, 800, 800, 800, 450, 450, 450, 800, 800, 800, 450, 450, 450, 1000, 1000 }};

void setup() {
  Serial.begin(9600);
  for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
    pinMode(LEDs[i], OUTPUT);
  pinMode(BUTTONPIN, INPUT);
}

void loop() {
  currentTime = millis();
  buttonState = digitalRead(BUTTONPIN);
  //delay(10);
  if (buttonState == HIGH && currentTime - buttonCoolDown > 500) {
    buttonCoolDown = currentTime;
    savedTime = currentTime - 2000; //force to start LED pattern from beginning
      if (phase != 7)
        phase++;
      else
        phase = 0;
    Serial.println(String(phase));
  }
  if (phase < 7) {
      if (currentTime - savedTime > phaseTime[phase][0] && currentTime - savedTime < phaseTime[phase][1]) {
        //turn on red LEDs
        digitalWrite(LEDs[0], HIGH);
        digitalWrite(LEDs[1], HIGH);
      }
      if (currentTime - savedTime > phaseTime[phase][1] && currentTime - savedTime < phaseTime[phase][2]) {
        //turn on green LEDs
        for (float k = 0; k < 254; k+= 0.02)
          analogWrite(LEDs[3], k);
        digitalWrite(LEDs[4], HIGH);
      }
      if (currentTime - savedTime > phaseTime[phase][2] && currentTime - savedTime < phaseTime[phase][3]) {
        //turn on blue LEDs
        digitalWrite(LEDs[6], HIGH);
        digitalWrite(LEDs[7], HIGH);
      }
      if (currentTime - savedTime > phaseTime[phase][3] && currentTime - savedTime < phaseTime[phase][4]) {
        //turn on white LEDs
        digitalWrite(LEDs[2], HIGH);
        digitalWrite(LEDs[5], HIGH);
      }
      //show different LED patterns
      if (currentTime - savedTime > phaseTime[phase][4] && currentTime - savedTime < phaseTime[phase][5]) {
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], LOW);
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i += 2)
          digitalWrite(LEDs[i], HIGH);
      }
      if (currentTime - savedTime > phaseTime[phase][5] && currentTime - savedTime < phaseTime[phase][6])
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], HIGH);
      if (currentTime - savedTime > phaseTime[phase][6] && currentTime - savedTime < phaseTime[phase][7])
        digitalWrite(LEDs[0], LOW);
      if (currentTime - savedTime > phaseTime[phase][7] && currentTime - savedTime < phaseTime[phase][8])
        digitalWrite(LEDs[1], LOW);
      if (currentTime - savedTime > phaseTime[phase][8] && currentTime - savedTime < phaseTime[phase][9])
        digitalWrite(LEDs[2], LOW);
      if (currentTime - savedTime > phaseTime[phase][9] && currentTime - savedTime < phaseTime[phase][10])
        digitalWrite(LEDs[3], LOW);
      if (currentTime - savedTime > phaseTime[phase][10] && currentTime - savedTime < phaseTime[phase][11])
        digitalWrite(LEDs[4], LOW);
      if (currentTime - savedTime > phaseTime[phase][11] && currentTime - savedTime < phaseTime[phase][12])
        digitalWrite(LEDs[5], LOW);
      if (currentTime - savedTime > phaseTime[phase][12] && currentTime - savedTime < phaseTime[phase][13])
        digitalWrite(LEDs[6], LOW);
      if (currentTime - savedTime > phaseTime[phase][13] && currentTime - savedTime < phaseTime[phase][14])
        digitalWrite(LEDs[7], LOW);
      if (currentTime - savedTime > phaseTime[phase][14] && currentTime - savedTime < phaseTime[phase][15])
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], HIGH);
      if (currentTime - savedTime > phaseTime[phase][15] && currentTime - savedTime < phaseTime[phase][16])
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], LOW);
      if (currentTime - savedTime > phaseTime[phase][16] && currentTime - savedTime < phaseTime[phase][17])
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], HIGH);
      if (currentTime - savedTime > phaseTime[phase][17] && currentTime - savedTime < phaseTime[phase][18])
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], LOW);
      if (currentTime - savedTime > phaseTime[phase][18] && currentTime - savedTime < phaseTime[phase][19])
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], HIGH);
      if (currentTime - savedTime > phaseTime[phase][19]) {
        for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
          digitalWrite(LEDs[i], LOW);
        savedTime = currentTime;
      }
    }
  else
    for (int i = 0; i <= sizeof(LEDs) / sizeof(LEDs[0]); i++)
      digitalWrite(LEDs[i], LOW);
}