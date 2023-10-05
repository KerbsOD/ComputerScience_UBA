
/** ~~~~~~~~~~ COMMAND LINE INTERFACE ~~~~~~~~~~ **/


/** ---------------------------------------------- *
 *                                                 *
 *  Este archivo contiene la implementacion de la  *
 *  lectura de argumentos genericos por linea de   *
 *  comandos (los argumentos particulares de cada  *
 *  filtro se leen en su respectivo .c)            *
 *                                                 *
 *  Autor: orga2                                   *
 *                                                 *
 * ----------------------------------------------- *
**/

#include <getopt.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <sys/stat.h>

#include "simd.h"

void procesar_opciones(int argc, char **argv, configuracion_t *config) {
    // Si se ejecuta sin parametros ni opciones
    if (argc == 1) {
        imprimir_ayuda (argv[0]);
        exit ( EXIT_SUCCESS );
    }

    char *tipo_filtro;
    int siguiente_opcion;

    // opciones por defecto
    config->es_video = false;
    config->verbose = false;
    config->frames = false;
    config->nombre = false;
    config->cant_iteraciones = 1;
    config->archivo_entrada = NULL;
    config->archivo_entrada_2 = NULL;
    config->carpeta_salida = ".";
    config->extra_archivo_salida = "";

    // extraemos opciones de la linea de comandos
    const char* const op_cortas = "hi:vt:fo:wn";

    const struct option op_largas[] = {
        { "help",           0, NULL, 'h' },
        { "implementacion", 1, NULL, 'i' },
        { "verbose",        0, NULL, 'v' },
        { "video",          0, NULL, 'w' },
        { "tiempo",         1, NULL, 't' },
        { "frames",         0, NULL, 'f' },
        { "nombre",         0, NULL, 'n' },
        { "output",         1, NULL, 'o' },
        { NULL,             0, NULL,  0  }
    };

    while (1) {
        siguiente_opcion = getopt_long ( argc, argv, op_cortas, op_largas, NULL);

        // No hay mas opciones
        if ( siguiente_opcion == -1 )
            break;

        // Procesar opcion
        switch ( siguiente_opcion ) {
            case 'h' : /* -h o --help */
                imprimir_ayuda (argv[0]);
                exit ( EXIT_SUCCESS );
                break;
            case 'i' : /* -i o --implementacion */
                tipo_filtro = optarg;
                break;
            case 't' : /* -t o --tiempo */
                config->cant_iteraciones = atoi ( optarg );
                break;
            case 'v' : /* -v o --verbose */
                config->verbose = true;
                break;
            case 'f' : /* -f o --frames */
                config->frames = true;
                break;
            case 'n' : /* -n o --nombre */
                config->nombre = true;
                break;
            case 'o' : /* -o o --output */
                config->carpeta_salida = optarg;
                break;
            case 'w' : /* -w o --video */
                config->es_video = true;
                break;
            case '?' : /* opcion no valida */
                imprimir_ayuda (argv[0]);
                exit ( EXIT_SUCCESS );
            default : /* opcion no valida */
                abort ( );
        }
    }

    // Verifico nombre del proceso
    config->nombre_filtro = argv[optind++];

    if (config->nombre_filtro == NULL) {
        imprimir_ayuda (argv[0]);

        exit ( EXIT_SUCCESS );
    }

    // Verifico nombre de la implementacion
    if (tipo_filtro == NULL ||
        (strcmp(tipo_filtro, "c") != 0 &&
        strcmp(tipo_filtro, "asm") != 0)) {
        imprimir_ayuda (argv[0]);

        exit ( EXIT_SUCCESS );
    }

    if (strcmp(tipo_filtro, "c") == 0) {
        config->tipo_filtro = FILTRO_C;
    } else {
        config->tipo_filtro = FILTRO_ASM;
    }

    // Verifico nombre de archivo
    config->archivo_entrada = argv[optind++];

    if (config->archivo_entrada == NULL) {
        imprimir_ayuda (argv[0]);
        exit ( EXIT_SUCCESS );
    }

    if (access( config->archivo_entrada, F_OK ) == -1) {
        printf("Error al intentar abrir el archivo: %s.\n", config->archivo_entrada);

        exit ( EXIT_SUCCESS );
    }
    //filtro_t * filtro = detectar_filtro(config);
    /*if (filtro != NULL && optind < argc && filtro->n_entradas > 1) {
        config->archivo_entrada_2 = argv[optind++];
        if (config->archivo_entrada_2 == NULL) {
            imprimir_ayuda (argv[0]);
            exit ( EXIT_SUCCESS );
        }

        if (access( config->archivo_entrada_2, F_OK ) == -1) {
            printf("Error al intentar abrir el archivo: %s.\n", config->archivo_entrada_2);

            exit ( EXIT_SUCCESS );
        }

    } */

}

extern filtro_t filtros[];

void imprimir_ayuda ( char *nombre_programa) {
    printf ( "Uso: %s opciones filtro nombre_archivo_entrada parametros_filtro\n",
            nombre_programa );
    printf ( "    Los filtros que se pueden aplicar son \n");

    for (int i = 0; filtros[i].nombre != 0; i++)
        filtros[i].ayuda();

    printf ( "\n" );
    printf ( "    -h, --help: \n");
    printf ( "                Imprime esta ayuda\n" );
    printf ( "\n" );
    printf ( "    -i, --implementacion NOMBRE_MODO\n");
    printf ( "                                     "
            "Implementación sobre la que se ejecutará el filtro\n"
            "                                     "
            "seleccionado. Los implementaciones disponibles\n"
            "                                     "
            "son: c, asm\n");
    printf ( "\n" );
    printf ( "    -t, --tiempo CANT_ITERACIONES\n");
    printf ( "                                   "
            "Mide el tiempo que tarda en ejecutar el filtro sobre la\n"
            "                                   "
            "imagen de entrada una cantidad de veces igual a\n"
            "                                   "
            "CANT_ITERACIONES\n");
    printf ( "\n" );
    printf ( "    -o, --output CARPETA\n");
    printf ( "                          "
            "Carpeta de salida. Por defecto es la misma que la de entrada\n");
    printf ( "    -n, --nombre\n");
    printf ( "                          "
            "No aplica el filtro, solo muestra el nombre del archivo de salida\n");
    printf ( "    -v, --verbose\n");
    printf ( "                   "
            "Imprime información adicional\n" );
    printf ( "\n" );

}
