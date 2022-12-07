#include <WiFi.h>
#include <ESPAsyncWebServer.h>
  
const char* ssid = "rede";
const char* password =  "senha";
  
AsyncWebServer server(80);
AsyncWebSocket ws("/ws");
  
void onWsEvent(AsyncWebSocket * server, AsyncWebSocketClient * client, AwsEventType type, void * arg, uint8_t *data, size_t len){
  
  if(type == WS_EVT_CONNECT){
  
    Serial.println("connected");
    ws.textAll("connected");
     
  } else if(type == WS_EVT_DISCONNECT){
 
    Serial.println("Client disconnected");
  
  } else if (type == WS_EVT_DATA) {
    handleWebSocketMessage(arg, data, len);
  }
}

void handleWebSocketMessage(void *arg, uint8_t *data, size_t len) {
  AwsFrameInfo *info = (AwsFrameInfo*)arg;
  if (info->final && info->index == 0 && info->len == len && info->opcode == WS_TEXT) {
    data[len] = 0;
    if (strcmp((char*)data, "subir") == 0) {
      // manda pro arduino
      ws.textAll("subir:success");
      Serial.println("subiu mlk");
    } else if (strcmp((char*)data, "descer") == 0) {
      // manda pro arduino
      ws.textAll("descer:success");
      Serial.println("desceu mlk");
    }
  }
}
  
void setup(){
  Serial.begin(115200);
  
  WiFi.begin(ssid, password);
  
  while (WiFi.status() != WL_CONNECTED) {
    delay(1000);
    Serial.println("Connecting to WiFi..");
  }
  
  Serial.println(WiFi.localIP());
  
  ws.onEvent(onWsEvent);
  server.addHandler(&ws);
  
  server.begin();
}
  
void loop(){
 
  delay(2000);
}
