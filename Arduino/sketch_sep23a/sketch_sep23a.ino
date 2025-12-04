const int ValorAr = 520;
const int ValorAgua = 200;

int ValorUmidadeSolo = 0;
float porcentagemUmidade = 0;

int random_variable;
int static_variable = 100;
int static_variable2 = 20;
int potentiometer;

void setup() {
  Serial.begin(9600);
}

void loop() {
  ValorUmidadeSolo = analogRead(A5);

  int faixa = ValorAr - ValorAgua;

  int distancia = ValorAr - ValorUmidadeSolo;

  porcentagemUmidade = (float)distancia / faixa * 100.0;

  if (porcentagemUmidade < 0) porcentagemUmidade = 0;
  if (porcentagemUmidade > 100) porcentagemUmidade = 100;

 
 Serial.println(porcentagemUmidade);


  delay(2000);

}
