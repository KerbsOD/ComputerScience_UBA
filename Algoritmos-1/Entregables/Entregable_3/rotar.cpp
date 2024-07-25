#include <iostream>
#include <string>

using namespace std;

string rotar(string s, int j) {
    
    string t = s;

    while(j > s.size()){
        j = j - s.size();
    }

    for(int i = 0; i < s.size(); i++){
        t[i] = s[(s.size() - j + i) % s.size()];
    }

    return t;
}


int main()
{
    /* No hace falta modificar el main */
    // Leo la entrada
    string s;
    int j;
    cin >> s >> j;
    
    string res = rotar(s, j);
    cout << res;
    return 0;
}
