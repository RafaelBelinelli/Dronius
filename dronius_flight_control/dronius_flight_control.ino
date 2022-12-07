//DRONIUS - Controle de voo
//Acelerômetro e Giroscópio
//Felipe Kenji Yamanaka Kumagai    - 20131
//Gabriel Oliveira Silva           - 20134
//Rafael Dias Belinelli            - 20153

#include "I2Cdev.h"
#include "MPU6050_6Axis_MotionApps20.h"
#if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
    #include "Wire.h"
#endif

MPU6050 mpu;

#define OUTPUT_READABLE_YAWPITCHROLL
#define INTERRUPT_PIN 2 
#define LED_PIN 13
bool blinkState = false;

// Variáveis de controle e de status do MPU
bool dmpReady = false;  // Definir o valor para true caso o DMP seja configurado com sucesso
uint8_t mpuIntStatus;   // Armazena o status de interrupcao do MPU
uint8_t devStatus;      // Retorna o status de resultado (0 = successo, !0 = erro)
uint16_t packetSize;    // Tamanho de pacotes do DMP (o padrão é 42)
uint16_t fifoCount;     // Contagem dos bytes em FIFO
uint8_t fifoBuffer[64]; // Buffer de armazenamento em FIFO

// Variáveis de orientação/movimentação
Quaternion q;           // [w, x, y, z]         Container de quaternion
VectorInt16 aa;         // [x, y, z]            Medidas do acelerômetro
VectorInt16 aaReal;     // [x, y, z]            Medidas do acelerômetro desconsiderando a gravidade
VectorInt16 aaWorld;    // [x, y, z]            World-frame accel sensor measurements
VectorFloat gravity;    // [x, y, z]            Vetor de gravidade
float euler[3];         // [psi, theta, phi]    Vetor com os angulos de Euler
float ypr[3];           // [yaw, pitch, roll]   Vetor de yaw/pitch/roll e de gravidade


volatile bool mpuInterrupt = false;     // Indica se a interrupção do MPU foi ativada
void dmpDataReady() {
    mpuInterrupt = true;
}



void setup() {
    #if I2CDEV_IMPLEMENTATION == I2CDEV_ARDUINO_WIRE
        Wire.begin();
        Wire.setClock(400000);
    #elif I2CDEV_IMPLEMENTATION == I2CDEV_BUILTIN_FASTWIRE
        Fastwire::setup(400, true);
    #endif

    // Inicializando a comunicação serial
    Serial.begin(115200);

    // Inicializando o MPU
    Serial.println(F("Initializing I2C devices..."));
    mpu.initialize();
    pinMode(INTERRUPT_PIN, INPUT);

    // Verificando conexão
    Serial.println(F("Testing device connections..."));
    Serial.println(mpu.testConnection() ? F("MPU6050 connection successful") : F("MPU6050 connection failed"));

    // Esperando estabilidade
    Serial.println(F("\nSend any character to begin DMP programming and demo: "));
    while (Serial.available() && Serial.read()); // empty buffer
    while (!Serial.available());                 // wait for data
    while (Serial.available() && Serial.read()); // empty buffer again

    // Configurando o DMP
    Serial.println(F("Initializing DMP..."));
    devStatus = mpu.dmpInitialize();

    // Compensando o desvio dos sensores
    mpu.setXGyroOffset(220);
    mpu.setYGyroOffset(76);
    mpu.setZGyroOffset(-85);
    mpu.setZAccelOffset(1788); // 1688 factory default for my test chip

    if (devStatus == 0) {
        // Calibrando o MPU
        mpu.CalibrateAccel(6);
        mpu.CalibrateGyro(6);
        mpu.PrintActiveOffsets();
        // inicializando o DMP
        Serial.println(F("Enabling DMP..."));
        mpu.setDMPEnabled(true);

        // Ativando a detecção de interrupção do Arduino
        Serial.print(F("Enabling interrupt detection (Arduino external interrupt "));
        Serial.print(digitalPinToInterrupt(INTERRUPT_PIN));
        Serial.println(F(")..."));
        attachInterrupt(digitalPinToInterrupt(INTERRUPT_PIN), dmpDataReady, RISING);
        mpuIntStatus = mpu.getIntStatus();

        // Sinalizando que o DMP está pronto para uso
        Serial.println(F("DMP ready! Waiting for first interrupt..."));
        dmpReady = true;

        // Reecbendo pacote do DMP
        packetSize = mpu.dmpGetFIFOPacketSize();
    } else {
        Serial.print(F("Falha na inicialização do DMP (código "));
        Serial.print(devStatus);
        Serial.println(F(")"));
    }

    // Configurando o led para OUTPUT
    pinMode(LED_PIN, OUTPUT);
}


void loop() {
    // Se a configuração do DMP falhar, retorne
    if (!dmpReady) return;
    // Lendo pacotes do DMP
    if (mpu.dmpGetCurrentFIFOPacket(fifoBuffer)) { // Recebe o último pacote
      
        // Visualizando o pitch/yaw/roll
        #ifdef OUTPUT_READABLE_YAWPITCHROLL
            mpu.dmpGetQuaternion(&q, fifoBuffer);
            mpu.dmpGetGravity(&gravity, &q);
            mpu.dmpGetYawPitchRoll(ypr, &q, &gravity);
            Serial.print("ypr\t");
            Serial.print(ypr[0] * 180/M_PI);
            Serial.print("\t");
            Serial.print(ypr[1] * 180/M_PI);
            Serial.print("\t");
            Serial.println(ypr[2] * 180/M_PI);
        #endif


        // Pisca o led para verificar ativação
        blinkState = !blinkState;
        digitalWrite(LED_PIN, blinkState);
    }
}
