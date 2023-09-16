#include <utility>
#include <vector>
#include <iostream>
#include <set>

#define tablero  std::vector<std::string>
#define posicion  std::pair<int, int>
#define camino std::vector<std::vector<bool>>
int alto {};
int largo {};
std::set<unsigned int> longCaminos {};
//tablero t {};
void hayCamino(tablero &t, posicion& aterrice, posicion& desde, camino& c, char& simbolo, int longitud);

/*
 * rotaciones:
 *            0: I    ;  L; +    ; #
 *            1: -    ;  F; +(no); #(no)
 *            2: I(no);  7; +(no); #(no)
 *            3: -(no); _|; +(no); #(no)
 */

bool perteneAltablero(posicion& p)
{
    return (0 <= p.first  && p.first  < alto &&
            0 <= p.second && p.second < largo);
}

bool esPosibleIr(posicion& p, camino& c)
{
    return (perteneAltablero(p) && !c[p.first][p.second]);
}

void irA (tablero& t, posicion& hasta, posicion& desde, camino& c, int longitud)
{
    c[desde.first][desde.second] = true;
    hayCamino(t, hasta, desde,c, t[hasta.first][hasta.second], longitud + 1);
    c[desde.first][desde.second] = false;
}

void hayCamino(tablero &t, posicion& aterrice, posicion& desde, camino& c, char& simbolo, int longitud)
{
    if ((aterrice.first == alto-1) && (aterrice.second == largo - 1))
    {
        longCaminos.insert(longitud);
        return;
    }
    posicion arriba {aterrice.first - 1,aterrice.second};
    posicion derecha {aterrice.first,aterrice.second + 1};
    posicion abajo {aterrice.first + 1,aterrice.second};
    posicion izquierda {aterrice.first,aterrice.second - 1};


    posicion relativa {aterrice.first - desde.first, aterrice.second - desde.second};
    switch (simbolo)
    {
        case '#':
            return;
        case '+':
            if (esPosibleIr(arriba, c))
                irA(t, arriba,aterrice,c, longitud);

            if (esPosibleIr(derecha, c))
                irA(t, derecha,aterrice,c, longitud);

            if (esPosibleIr(abajo, c))
                irA(t, abajo,aterrice,c, longitud);

            if (esPosibleIr(izquierda, c))
                irA(t, izquierda,aterrice,c, longitud);
            break;
        case 'I':
            if (relativa.first == 1)
            {
                if (esPosibleIr(abajo,c))
                    irA(t, abajo, aterrice, c, longitud);
                else
                    return;
            }
            else if (relativa.first == -1)
            {
                if (esPosibleIr(arriba,c))
                    irA(t, arriba, aterrice, c, longitud);
                else
                    return;
            }
            else if (relativa.second == 1)
            {
                if (esPosibleIr(derecha,c))
                    irA(t, derecha, aterrice, c, longitud);
                else
                    return;
            }
            else
            {
                if (esPosibleIr(izquierda,c))
                    irA(t, izquierda, aterrice, c, longitud);
                else
                    return;
            }
            break;
        case 'L':
            if (relativa.first!=0)
            {
                if (esPosibleIr(derecha,c))
                    irA(t, derecha, aterrice, c, longitud);
                if (esPosibleIr(izquierda,c))
                    irA(t, izquierda, aterrice, c, longitud);
            }
            else
            {
                if (esPosibleIr(abajo,c))
                    irA(t, abajo, aterrice, c, longitud);
                if (esPosibleIr(arriba,c))
                    irA(t, arriba, aterrice, c, longitud);
            }
            break;
        default:
            return;
    }
}

std::string resolverTablero (tablero& t)
{
    std::string res {"IMPOSIBLE"};
    if (alto == largo && largo == 1)
        return "POSIBLE 0 0";
    if (*t.rbegin()->rbegin() == '#')
        return res;
    posicion cero {0,0};
    posicion abajo {1,0};
    posicion derecha {0,1};
    camino c (alto,std::vector<bool> (largo, false));
    c[cero.first][cero.second] = true;
    if (alto > 1)
        hayCamino(t, abajo,cero,c, t[1][0], 1);
    if (largo > 1)
        hayCamino(t, derecha,cero,c, t[0][1], 1);
    if (!longCaminos.empty())
    {
        unsigned int min {*longCaminos.begin()};
        unsigned int max {*longCaminos.rbegin()};
        res = "POSIBLE " + std::to_string(min) +' ' + std::to_string(max);
    }
    return res;
}

int main()
{
    int testCases {};
    std::cin >> testCases;
    for (tablero t (alto); testCases > 0; --testCases)
    {
        std::cin >> alto;
        std::cin >> largo;
        t = tablero(alto);
        for (int i {0}; i < alto; ++i)
            std::cin >> t[i];

        std::cout << resolverTablero(t) << '\n';

        alto = 0;
        largo = 0;
        longCaminos = {};
    }
    return 0;
}
