#include <Wire.h>
#include <LiquidCrystal_I2C.h>
#include <UTFT.h>
#include <URTouch.h>

LiquidCrystal_I2C lcd(0x27, 16, 2);
unsigned long currentTime = 0, savedTime = 0;
bool startLcd = true;
void setup() {
  // put your setup code here, to run once:
  lcd.begin();
  lcd.backlight();
}

void loop() {
  // put your main code here, to run repeatedly:
  lcdPrint("Warming Up", "Please Wait...", 5000, "Ready", "", startLcd);
}

void lcdPrint(String a, String b) {
  for (byte i = 0; i < 22 - (sizeof(a) / sizeof(a[0])); i++)
    a += " ";
  for (byte i = 0; i < 22 - (sizeof(b) / sizeof(b[0])); i++)
    b += " ";
  lcd.setCursor(0, 0);
  lcd.print(a);
  lcd.setCursor(0, 1);
  lcd.print(b);
}

void lcdPrint(byte a, String b) {

  for (byte i = 0; i < 22 - (sizeof(b) / sizeof(b[0])); i++)
    b += " ";
  if (a == 0) {
    lcd.setCursor(0, 0);
    lcd.print(b);
  }
  else if (a == 1) {
    lcd.setCursor(0, 1);
    lcd.print(b);
  }
}

void lcdPrint(String a, String b, long c, String d, String e, bool f) {
  for (byte i = 0; i < 22 - (sizeof(a) / sizeof(a[0])); i++)
    a += " ";
  for (byte i = 0; i < 22 - (sizeof(b) / sizeof(b[0])); i++)
    b += " ";
  for (byte i = 0; i < 22 - (sizeof(d) / sizeof(d[0])); i++)
    d += " ";
  for (byte i = 0; i < 22 - (sizeof(e) / sizeof(e[0])); i++)
    e += " ";

  currentTime = millis();
  if (currentTime - savedTime > c && f) {
    f = false;
d = String(millis()/1000/60);
e = String(millis()/1000);

lcd.setCursor(0, 0);
    lcd.print(d);
    lcd.setCursor(0, 1);
    lcd.print(e);
  }
  else {
    if (a != "                ") {
      lcd.setCursor(0, 0);
      lcd.print(a);
    }
    if (b != "                ") {
      lcd.setCursor(0, 1);
      lcd.print(b);
    }
    lcd.clear();
  }
}
