#define N 100;
char pilha[N];
int t;

int bemFormada(char s[]);
void criapilha(void);
void empilha(char);
char desempilha(void);
int pilhavazia(void);

int main(){

  return 0;
}

int bemFormada(char s[]){
  criapilha();

  for(int i = 0; s[i] != '\0'; ++i){
    char c;
    switch (s[i]){
      case ')': if(pilhavazia()) return 0;
                c = desempilha();
                if (c != ')') return 0;
                break;
      case ']': if(pilhavazia()) return 0;
                c = desempilha();
                if (c != '[') return 0;
                break;
      default: empilha(s[i]);
    }
  }

  return pilhavazia();
}

void criapilha(void){
  t = 0;
}

void empilha(char y){
  pilha[t++] = y;
}

char desempilha(void){
  return pilha[--t];
}

int pilhavazia(void){
  return t <= 0;
}
