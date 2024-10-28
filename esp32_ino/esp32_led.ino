#include <BluetoothSerial.h>

BluetoothSerial SerialBT;
const int ledPin = 2;

void setup() {
  Serial.begin(115200);
  SerialBT.begin("esp32_zxuan32");
  pinMode(ledPin, OUTPUT);
  Serial.println("El dispositivo Bluetooth ha comenzado. Esperando conexión...");
}

void loop() {
  if (SerialBT.available()) {
    String command = SerialBT.readStringUntil('\n');
    command.trim();

    if (command == "LED ON") {
      digitalWrite(ledPin, HIGH);
      Serial.println("LED encendido.");
    } else if (command == "LED OFF") {
      digitalWrite(ledPin, LOW);
      Serial.println("LED apagado.");
    }
  }

  delay(100);
}
