# Arduino

- [Installation IDE](https://www.arduino.cc/en/software)
- [Tutoriels](https://www.arduino.cc/en/Tutorial/HomePage)
- [Documentation](https://www.arduino.cc/reference/en/)

## Composants

Microcontroller : [atmega328p](http://ww1.microchip.com/downloads/en/DeviceDoc/Atmel-7810-Automotive-Microcontrollers-ATmega328P_Datasheet.pdf)

## LED

```c
int ledPinDay = 3;
int ledPinNight = 4;
int btnPin = 2;
bool day = false;

void lightALed(int ledPin, bool isOn)
{
    if (isOn) {
        digitalWrite(ledPin, HIGH);
    } else {
        digitalWrite(ledPin, LOW);
    }
}

void setup()
{
    pinMode(ledPinDay, OUTPUT);
    pinMode(ledPinNight, OUTPUT);
    pinMode(btnPin, INPUT);
}

void loop()
{
    day = digitalRead(btnPin);

    lightALed(ledPinDay, day);
    lightALed(ledPinNight, !day);

    delay(100); // Advice to help reading data
}
```

## Infrared Remote

- [tuto drone bot workshop](https://dronebotworkshop.com/using-ir-remote-controls-with-arduino/)
- [tuto electronoobs](https://www.youtube.com/watch?v=7BoUCA8E4Ek)

- pin 3 obligatoire & résistance 150 Ohm pour la LED émettrice
- bouton poussoir & résistance 10 kOhm & relié GND

```c
/*
  IR Transmitter Demonstration 1
  IR-Xmit-Demo1.ino
  Control TV using IR Library
  IR LED must use Pin #3
  DroneBot Workshop 2017
  http://dronebotworkshop.com
*/

// Include IR Remote Library by Ken Shirriff

#include <IRremote.h>

// Define switch pin
const int switchPin = 7;

// Define a variable for the button state
int buttonState = 0;

// Create IR Send Object
IRsend irsend;

void setup()
{
  // Set Switch pin as Input
  pinMode(switchPin, INPUT);
}

void loop() {

  // Set button state depending upon switch position
  buttonState = digitalRead(switchPin);

  // If button is pressed send power code command
   if (buttonState == HIGH) {
    irsend.sendNEC(0xFEA857, 32); // TV power code
  }

    // Add a small delay before repeating
    delay(200);

}
```

## Radio Frequency remote control

- [RF remote control using Arduino and 433mhz ASK module](https://mechatrofice.com/arduino/rf-remote-controller-using-arduino-and-ask-module)
