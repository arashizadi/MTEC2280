//RGBW by A.I,
//instruction: tap the button once to toggle the lights.
const int LEDs[8] = {13, 12, 11, 10, 9, 8, 7, 6};
const int totalLEDs = 7; //arduino doesn't support array.length
const int BUTTONPIN = 2;
int buttonState = 0;
bool buttonToggle = false;
unsigned long currentTime = 0, savedTime = 0, buttonCoolDown = 0;
void setup() {
  Serial.begin(9600);
  for (int i = 0; i <= totalLEDs; i++)
    pinMode(LEDs[i], OUTPUT);
  pinMode(BUTTONPIN, INPUT);
}

void loop() {
  currentTime = millis();
  buttonState = digitalRead(BUTTONPIN);
  delay(10);
  if (buttonState == HIGH && currentTime - buttonCoolDown > 500) {
    buttonCoolDown = currentTime;
    savedTime = currentTime - 2000; //force to start LED pattern from beginning
    buttonToggle = !buttonToggle;
    Serial.println(buttonToggle);
  }
  if (buttonToggle) {
    if (currentTime - savedTime > 2000) {
      //turn on red LEDs
      digitalWrite(LEDs[0], HIGH);
      digitalWrite(LEDs[1], HIGH);
    }
    if (currentTime - savedTime > 4000) {
      //turn on green LEDs
      digitalWrite(LEDs[3], HIGH);
      digitalWrite(LEDs[4], HIGH);
    }
    if (currentTime - savedTime > 6000) {
      //turn on blue LEDs
      digitalWrite(LEDs[6], HIGH);
      digitalWrite(LEDs[7], HIGH);
    }
    if (currentTime - savedTime > 8000) {
      //turn on white LEDs
      digitalWrite(LEDs[2], HIGH);
      digitalWrite(LEDs[5], HIGH);
    }
      //show different LED patterns
    if (currentTime - savedTime > 10000) {
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], LOW);
      for (int i = 0; i <= totalLEDs; i += 2)
        digitalWrite(LEDs[i], HIGH);
    }
    if (currentTime - savedTime >= 12000)
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], HIGH);
    if (currentTime - savedTime >= 13000)
      digitalWrite(LEDs[0], LOW);
    if (currentTime - savedTime >= 13125)
      digitalWrite(LEDs[1], LOW);
    if (currentTime - savedTime >= 13250)
      digitalWrite(LEDs[2], LOW);
    if (currentTime - savedTime >= 13375)
      digitalWrite(LEDs[3], LOW);
    if (currentTime - savedTime >= 13500)
      digitalWrite(LEDs[4], LOW);
    if (currentTime - savedTime >= 13625)
      digitalWrite(LEDs[5], LOW);
    if (currentTime - savedTime >= 13750)
      digitalWrite(LEDs[6], LOW);
    if (currentTime - savedTime >= 13875)
      digitalWrite(LEDs[7], LOW);
    if (currentTime - savedTime >= 13900)
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], HIGH);
    if (currentTime - savedTime >= 13950)
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], LOW);
    if (currentTime - savedTime >= 14000)
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], HIGH);
    if (currentTime - savedTime >= 14050)
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], LOW);
    if (currentTime - savedTime >= 14100)
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], HIGH);
    if (currentTime - savedTime >= 14200) {
      for (int i = 0; i <= totalLEDs; i++)
        digitalWrite(LEDs[i], LOW);
      savedTime = currentTime;
    }
  }
  else
    for (int i = 0; i <= totalLEDs; i++)
      digitalWrite(LEDs[i], LOW);
}
