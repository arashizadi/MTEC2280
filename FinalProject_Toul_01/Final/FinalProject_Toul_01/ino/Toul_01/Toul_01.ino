const int BUTTONs[7] = {13, 12, 11, 10, 9, 8, 7};
const int POTENTIAMETERs[2] = {A0, A1};
int values[9] = {0, 0, 0, 0, 0, 0, 0, 0, 0}; //{pot1, pot2, btn1...btn7}
void setup() {
  Serial.begin(9600);
  for (int i = 0; i <= (sizeof(POTENTIAMETERs) / sizeof(POTENTIAMETERs[0]))-1; i++)
    pinMode(BUTTONs[i], INPUT);
  for (int i = 0; i <= (sizeof(POTENTIAMETERs) / sizeof(POTENTIAMETERs[0]))-1; i++)
    pinMode(POTENTIAMETERs[i], INPUT);
}
void loop() {
  delay(50);
  for (int i = 0; i <= (sizeof(values) / sizeof(values[0]))-1; i++){
    if (i < 2)
      values[i] = map(analogRead(POTENTIAMETERs[i]), 0, 1023, 0, 255);
    else
      values[i] = digitalRead(BUTTONs[i-2]);
  }

//source: https://itp.nyu.edu/physcomp/labs/labs-serial-communication/two-way-duplex-serial-communication-using-an-arduino/
  for (int thisSensor = 0; thisSensor < 9; thisSensor++) {
    int sensorValue = values[thisSensor];
    Serial.print(sensorValue);
    Serial.print(",");
  }
  Serial.print("\n");

}