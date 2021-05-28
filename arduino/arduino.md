# Arduino

- [Installation IDE](https://www.arduino.cc/en/software)
- [Tutoriels](https://www.arduino.cc/en/Tutorial/HomePage)
- [Documentation](https://www.arduino.cc/reference/en/)

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