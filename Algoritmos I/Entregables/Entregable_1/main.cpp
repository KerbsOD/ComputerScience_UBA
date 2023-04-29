#include <iostream>
#include <vector>

using namespace std;

bool sorted(vector<int> v);

int main(int, char**) {
    
    // MyVector
    vector<int> v = {1,2,3,2,3};
    
    // Is Sorted?
    bool res = sorted(v);
    
    // Res
    cout << (res?"True":"False");
}

bool sorted(vector<int> v) {
    
    if(v.size() <= 1) {
        return true;
    }

    if(v[0] >= v.back()) {
        for(int i = 0; i < v.size() - 1; i++) {
            if(v[i] < v[i+1]) {
                return false;
            }
        }
        return true;
    }

    
    if(v[0] <= v.back()) {
        for(int i = 0; i < v.size() - 1; i++) {
            if(v[i] > v[i+1]) {
                return false;
            }
        }
        return true;
    }
    
}
