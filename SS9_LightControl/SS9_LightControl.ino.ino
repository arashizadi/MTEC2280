#define LED 13
int val = 0;

void setup() {
  Serial.begin(9600);
  pinMode(LED, OUTPUT);
}

void loop() {
  if (Serial.available())
    val = Serial.read();
  if (val == 1)
    digitalWrite(LED, HIGH);
  else if (val == 0)                 
    digitalWrite(LED, LOW);
}