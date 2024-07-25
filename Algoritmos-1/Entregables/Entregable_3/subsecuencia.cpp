#include <iostream>
#include <string>

using namespace std;

bool subsecuencia(string s, string t) {
    
    int j = 0;

    for(int i = 0; i < t.size(); i++){
        if(j < s.size() && s[j] == t[i]){
            j++;
        }
    }

    return(s.size() == j);
}


int main()
{
    /* No hace falta modificar el main */
    // Leo la entrada
    string s, t;
    cin >> s >> t;
    
    bool res = subsecuencia(s, t);
    cout << (res ? "true" : "false");
    return 0;
}

