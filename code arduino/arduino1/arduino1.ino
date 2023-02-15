
#include <ESP8266WiFi.h>
#include <WiFiUdp.h>
#include <PubSubClient.h>
#include <DHT.h>
#include <ArduinoJson.h>
#include <string.h>

// Cập nhật thông tin wifi
#define ssid "TP-LINK_B8EE" // TP-LINK_B8EE
#define password "123abc@A" //123abc@A
const long utcOffsetInSeconds = 25200;
// Define NTP Client to get time
WiFiUDP ntpUDP;
//NTPClient timeClient(ntpUDP, "pool.ntp.org", utcOffsetInSeconds);

// Thông tin về MQTT Broker
#define mqtt_server "broker.mqttdashboard.com" // Địa chỉ server
#define mqtt_topic_pub "demo"   //Tạo topic tên là demo

const uint16_t mqtt_port = 1883; //Port của CloudMQTT
//const int D0 = 16;
//const int D1 = 5;
//const int D2 = 4;
//const int D3 = 0;
//const int D4 = 2;
//const int D5 = 14;
//const int D6 = 12;
//const int D7 = 13;
//const int D8 = 15;

//Khai báo chân của cảm biến nhiệt độ
const int DHTTYPE = DHT11;
const int DHTPIN = 5;

const int lamp1 = 4;
int infrareStatus = 0;
int statusLamp1 = 0, timerLamp1 = 0, checkLamp1 = 0;
int statusLamp2 = 0, checkLamp2 = 0;
int statusPan = 0, timerPan = 0, checkPan = 0;
int statusLock = 0, checkLock = 0;
long startLamp1, startPan; 
DHT dht(DHTPIN, DHTTYPE);

WiFiClient espClient;
PubSubClient client(espClient);

long lastMsg = 0;
char msg[50];

void setup() {
  delay(200);
  Serial.begin(115200);
  //set up wifi
  setup_wifi();
  //set up sensor
  pinMode(16, INPUT_PULLUP); // Đặt chân D0 để làm cổng đọc digital
  pinMode(12, INPUT);
  pinMode(4, OUTPUT); //Đặt chân D2 ở chế độ output
  pinMode(0, OUTPUT);
  pinMode(2, OUTPUT);
  pinMode(14, OUTPUT);
  pinMode(15, OUTPUT);
  dht.begin();
//  timeClient.begin();
  //set up pubsub
 
  client.setServer(mqtt_server, mqtt_port);

  client.setCallback(callback);
}

// Hàm kết nối wifi
void setup_wifi() {
  delay(10);
  Serial.println();
  Serial.print("Connecting to ");
  Serial.println(ssid);
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
  }
  Serial.println("");
  Serial.println("WiFi connected");
  Serial.println("IP address: ");
  Serial.println(WiFi.localIP());
}

// Hàm call back để nhận dữ liệu.
void callback(char* topic, byte* payload, unsigned int length) {
  if (strcmp(topic, "lights1") == 0) {
    char messing[200];
    for (int i = 0; i < length; i++) {
      messing[i] = (char)payload[i];
   
    }
     Serial.println(messing);
    StaticJsonBuffer<200> subscribes;
    JsonObject& root = subscribes.parseObject(messing);
    const char* status = root["Status"];
    statusLamp1 = int(status[0] - 48);
     Serial.print("statusLamp1:");
     Serial.println(statusLamp1);
    digitalWrite(4, statusLamp1);//D2=4
    
  } else if (strcmp(topic, "lights2") == 0) {
    char messing[200];
    for (int i = 0; i < length; i++) {
      messing[i] = payload[i];
    }
    StaticJsonBuffer<200> subscribes;
    JsonObject& root = subscribes.parseObject(messing);
    const char* status = root["Status"];
    statusLamp2 = int(status[0] - 48);
    Serial.println(statusLamp2);
    digitalWrite(0, statusLamp2);//D3=0
  } else if (strcmp(topic, "lights3") == 0) {
    char messing[200];
    for (int i = 0; i < length; i++) {
      messing[i] = payload[i];
      //Serial.print(timer[i]);
    }
    StaticJsonBuffer<200> subscribes;
    JsonObject& root = subscribes.parseObject(messing);
    const char* status = root["Status"];
    statusLock = int(status[0] - 48);
    Serial.println(statusLock);
    digitalWrite(2, statusLock);//D4=2
  } else if (strcmp(topic, "lights4") == 0) {
    char messing[200];
    for (int i = 0; i < length; i++) {
      messing[i] = payload[i];
      //Serial.print(timer[i]);
    }
    StaticJsonBuffer<200> subscribes;
    JsonObject& root = subscribes.parseObject(messing);
    const char* status = root["Status"];
    statusPan = int(status[0] - 48);
    Serial.println(statusPan);
     digitalWrite(14, statusPan);//D5=14
//    checkPan = 1;
//    startPan = millis();
  }
}


// Hàm reconnect thực hiện kết nối lại khi mất kết nối với MQTT Broker
void reconnect() {
  // Chờ tới khi kết nối
  while (!client.connected()) {
    Serial.print("Attempting MQTT connection...");
    // Thực hiện kết nối với mqtt
    String clientId = "ESP8266Client-";
    clientId += String(random(0xffff), HEX);
    if (client.connect(clientId.c_str())) {
      Serial.println("connected");
      // Khi kết nối sẽ publish thông báo
      client.publish(mqtt_topic_pub, "ESP_reconnected");
      client.subscribe(mqtt_topic_pub);
      client.subscribe("lights1");
      client.subscribe("lights2");
      client.subscribe("lights3");
      client.subscribe("lights4");
    } else {
      Serial.print("failed, rc=");
      Serial.print(client.state());
      Serial.println(" try again in 5 seconds");
      // Đợi 5s
      delay(5000);
    }
  }
}


void loop() {
  // Kiểm tra kết nối
  if (!client.connected()) {
    reconnect();
  }

  client.loop();
  long now = millis();
  //infrareStatus = digitalRead(12);//D6=12
  
//  if (infrareStatus == 0) {
//      digitalWrite(0, 1); //D3=0
//    }

    
  if (now - lastMsg > 1000) {
    Serial.println(digitalRead(12));
//     if (digitalRead(12) == 1)
//        Serial.println("Toi");
//     else Serial.println("Sang");

    
    //đọc nhiệt độ, độ ẩm
    float h = dht.readHumidity();    //Đọc độ ẩm
    float t = dht.readTemperature(); //Đọc nhiệt độ

    lastMsg = now;
    StaticJsonBuffer<300> JSONbuffer;
    JsonObject& JSONencoder = JSONbuffer.createObject();
    JSONencoder["humidityAir"] = h;
    JSONencoder["temperature"] = t;

    char JSONmessageBuffer[100];
    JSONencoder.printTo(JSONmessageBuffer, sizeof(JSONmessageBuffer));
    //Serial.println(JSONmessageBuffer);
    client.publish(mqtt_topic_pub, JSONmessageBuffer);
  }
  delay(200);
}
