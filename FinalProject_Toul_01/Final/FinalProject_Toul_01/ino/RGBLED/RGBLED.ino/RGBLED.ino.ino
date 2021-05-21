const int LED1[3] {13, 12, 11}; //PWM for fine tuning, but I don't need it in the project

void setup() {
  for (int i = 0; i <= sizeof(LED1) / sizeof(LED1[0]); i++)
    pinMode(LED1[i], OUTPUT);
}

void loop() {
  digitalWrite(LED1[0], LOW);
  digitalWrite(LED1[1], HIGH);
  digitalWrite(LED1[2], HIGH);
  delay(300);
  digitalWrite(LED1[0], HIGH);
  digitalWrite(LED1[1], LOW);
  digitalWrite(LED1[2], HIGH);
  delay(300);
  digitalWrite(LED1[0], HIGH);
  digitalWrite(LED1[1], HIGH);
  digitalWrite(LED1[2], LOW);
  delay(300);
}
