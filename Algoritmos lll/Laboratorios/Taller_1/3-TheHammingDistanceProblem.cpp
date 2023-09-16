#include<iostream>

using namespace std;

void solve(string res, int N, int H) {
    if (N == 0 || N < H) {               // Filtros
        if (N == 0 && H == 0) {         // Procesar(x)
            cout << res << endl;
        } 
    } else {
        solve(res + "0", N-1, H);
        if (H != 0) {
            solve(res + "1", N-1, H-1);
        }
    }
}

int main() {
    int T, N, H;
    cin >> T;
    
    
    for (int i = 0; i < T; i++) {
        if (i != 0) {
            cout << endl;
        }
        cin >> N >> H;
        solve("", N, H);
    }
}