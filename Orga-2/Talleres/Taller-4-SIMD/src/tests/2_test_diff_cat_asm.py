#!/usr/bin/env python

from termcolor import colored
from libtest import *

print(colored('Iniciando test de diferencias C vs. la catedra...', 'blue'))

todos_ok = True

archivos = archivos_tests()
for corrida in corridas:
    for imagen in archivos:
        ok = verificar(corrida['filtro'], corrida['params'], corrida['tolerancia'], 'asm', imagen)
        todos_ok = todos_ok and ok

if todos_ok:
    print(colored("Test de filtros finalizados correctamente", 'green'))
else:
    print(colored("se encontraron diferencias en algunas de las imagenes", 'red'))
