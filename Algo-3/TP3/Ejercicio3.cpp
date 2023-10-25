#include<iostream>
#include<vector>
#include<climits>
#include<queue>
using namespace std;
int INF = INT_MAX;

struct Arista {
    int u;
    int v;
    int w;
    bool operator<(const Arista &arista) const {
        return w < arista.w;
    }
};




int main() {
    int C;
    cin >> C;    
    
    while (C > 0) {
        int N;
        cin >> N;
        vector<vector<bool>> tablero(N, vector<bool>(N, false));
        
        for (int i = 0; i < N; i++) {
            for (int j = 0; j < N; j++) {
                bool roto;
                cin >> roto;
                tablero[i][j] = roto;
            }
        }
     
        C--;
    }    
}
