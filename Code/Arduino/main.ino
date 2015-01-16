void setup()
{
  pinMode(7,OUTPUT);
  digitalWrite(7,LOW);
  Serial.begin(9600);
}

uint32_t s=0;

void loop()
{
  
  if(Serial.available()>0)
  {
    digitalWrite(7,LOW);
    s = Serial.read();
    Serial.print(s);
    digitalWrite(7,HIGH);
    delay_x(s*3.28-0); // change this delay depending on your application
    digitalWrite(7,LOW);
    s = 0;
  }
}

void delay_x(uint32_t millis_delay)
{
  uint16_t micros_now = (uint16_t)micros();

  while (millis_delay > 0) {
    if (((uint16_t)micros() - micros_now) >= 1000) {
      millis_delay--;
      micros_now += 1000;
    }
  }  
}
