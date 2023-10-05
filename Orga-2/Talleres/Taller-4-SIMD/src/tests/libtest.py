import os
import subprocess
from os import listdir
from os.path import isfile, join
from termcolor import colored

DATADIR = "./data"
TESTINDIR = DATADIR + "/imagenes_a_testear"
CATEDRADIR = DATADIR + "/resultados_catedra"
ALUMNOSDIR = DATADIR + "/resultados_nuestros"
SIMDALU = "../build/simd"
SIMDCAT = "./simdcatedra"
DIFF = "../build/bmpdiff"
DIFFFLAGS = ""

corridas = [
    {'filtro': 'Pintar', 'tolerancia': 5, 'params': ''},
    {'filtro': 'temperature', 'tolerancia': 5, 'params': ''}
]

def make_dir(name):
    if not os.path.exists(name):
        os.mkdir(name)

def assure_dirs():
    make_dir(TESTINDIR)
    make_dir(CATEDRADIR)
    make_dir(ALUMNOSDIR)


def archivos_tests():
    return [f for f in listdir(TESTINDIR) if isfile(join(TESTINDIR, f))]


def correr_catedra(filtro, implementacion, archivo_in, extra_params):
    comando = SIMDCAT + " " + filtro
    argumentos = " -i " + implementacion + " -o " + CATEDRADIR + "/ " + TESTINDIR + "/" + archivo_in + ' ' + extra_params
    print(comando + argumentos)
    subprocess.call(comando + argumentos, shell=True)
    archivo_out = subprocess.check_output(comando + ' -n ' + argumentos, shell=True)
    return archivo_out.decode('utf-8').strip()


def correr_alumno(filtro, implementacion, archivo_in, extra_params):
    comando = SIMDALU + " " + filtro
    argumentos = " -i " + implementacion + " -o " + ALUMNOSDIR + "/ " + TESTINDIR + "/" + archivo_in + ' ' + extra_params
    subprocess.call(comando + argumentos, shell=True)
    archivo_out = subprocess.check_output(comando + ' -n ' + argumentos, shell=True)
    return archivo_out.decode('utf-8').strip()


def hay_diferencias(out_cat, out_alu, tolerancia):
    comando = DIFF + " " + DIFFFLAGS + " " + CATEDRADIR + "/" + out_cat + " " + ALUMNOSDIR + "/" + out_alu + " " + str(
        tolerancia)
    print(comando)
    return subprocess.call(comando, shell=True)


def verificar(filtro, extra_params, tolerancia, implementacion, archivo_in):
    mensaje = "filtro " + filtro + " version catedra contra tu " + implementacion
    print(colored(mensaje, 'blue'))

    archivo_out_cat = correr_catedra(filtro, 'c', archivo_in, extra_params)
    archivo_out_alu = correr_alumno(filtro, implementacion, archivo_in, extra_params)

    if hay_diferencias(archivo_out_cat, archivo_out_alu, tolerancia):
        print(colored("error en " + archivo_out_alu, 'red'))
        return False
    else:
        print(colored("iguales!", 'green'))
        return True
