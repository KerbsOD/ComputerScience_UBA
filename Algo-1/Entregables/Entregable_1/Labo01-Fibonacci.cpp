#include <iostream>

using namespace std;

// Funcion de fibonacci que calcula n-esimo termino
int fibonacci(int n){
    //COMPLETAR
    if(n == 0) {
        return 0;
    } else if (n == 1) {
        return 1;
    }
    return fibonacci(n-1) + fibonacci(n-2);
}
int main() 
{
    int n;
    cin >> n;
    cout << fibonacci(n) << endl;   
    return 0;
}