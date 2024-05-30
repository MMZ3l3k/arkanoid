// Parametry gry
int szerokoscPlatformy = 100;
int wysokoscPlatformy = 20;
int rozmiarPilki = 20;

float platformaX;
float platformaY;

float pilkaX;
float pilkaY;
float predkoscPilkiX;
float predkoscPilkiY;

int[][] klocki;
int liczbaKlockowWRzedzie = 10;
int liczbaRzedowKlockow = 5;
int szerokoscKlocka;
int wysokoscKlocka;

void setup() {
  size(800, 600); // Ustawia rozmiar okna gry
  platformaX = width / 2 - szerokoscPlatformy / 2;
  platformaY = height - 50;
  
  pilkaX = width / 2;
  pilkaY = height / 2;
  predkoscPilkiX = 3;
  predkoscPilkiY = -3;
  
  szerokoscKlocka = width / liczbaKlockowWRzedzie;
  wysokoscKlocka = 30;
  klocki = new int[liczbaRzedowKlockow][liczbaKlockowWRzedzie];
  for (int i = 0; i < liczbaRzedowKlockow; i++) {
    for (int j = 0; j < liczbaKlockowWRzedzie; j++) {
      klocki[i][j] = 1; // Klocki są aktywne
    }
  }
}

void draw() {
  background(0); // Ustawia tło na czarne
  
  // Rysowanie platformy
  rect(platformaX, platformaY, szerokoscPlatformy, wysokoscPlatformy);
  
  // Rysowanie piłki
  ellipse(pilkaX, pilkaY, rozmiarPilki, rozmiarPilki);
  
  // Rysowanie klocków
  for (int i = 0; i < liczbaRzedowKlockow; i++) {
    for (int j = 0; j < liczbaKlockowWRzedzie; j++) {
      if (klocki[i][j] == 1) {
        rect(j * szerokoscKlocka, i * wysokoscKlocka, szerokoscKlocka, wysokoscKlocka);
      }
    }
  }
  
  // Ruch piłki
  pilkaX += predkoscPilkiX;
  pilkaY += predkoscPilkiY;
  
  // Odbicie piłki od ścian
  if (pilkaX <= 0 || pilkaX >= width) {
    predkoscPilkiX *= -1;
  }
  if (pilkaY <= 0) {
    predkoscPilkiY *= -1;
  }
  
  // Odbicie piłki od platformy
  if (pilkaX >= platformaX && pilkaX <= platformaX + szerokoscPlatformy && pilkaY + rozmiarPilki / 2 >= platformaY) {
    predkoscPilkiY *= -1;
  }
  
  // Sprawdzenie, czy piłka uderza w klocki
  for (int i = 0; i < liczbaRzedowKlockow; i++) {
    for (int j = 0; j < liczbaKlockowWRzedzie; j++) {
      if (klocki[i][j] == 1) {
        float klocekX = j * szerokoscKlocka;
        float klocekY = i * wysokoscKlocka;
        if (pilkaX > klocekX && pilkaX < klocekX + szerokoscKlocka && pilkaY > klocekY && pilkaY < klocekY + wysokoscKlocka) {
          predkoscPilkiY *= -1;
          klocki[i][j] = 0; // Usunięcie klocka
        }
      }
    }
  }
  
  // Sprawdzenie, czy piłka spadła poniżej ekranu
  if (pilkaY > height) {
    resetujGre();
  }
  
  // Ruch platformy
  if (keyPressed) {
    if (key == CODED) {
      if (keyCode == LEFT) {
        platformaX -= 5;
      } else if (keyCode == RIGHT) {
        platformaX += 5;
      }
    }
  }
  
  // Ograniczenie ruchu platformy do obszaru okna
  platformaX = constrain(platformaX, 0, width - szerokoscPlatformy);
}

void resetujGre() {
  pilkaX = width / 2;
  pilkaY = height / 2;
  predkoscPilkiX = 3;
  predkoscPilkiY = -3;
}
