
#ifndef __SIMD__H__
#define __SIMD__H__

#include <stdbool.h>

#define FILTRO_C   0
#define FILTRO_ASM 1

typedef unsigned char uchar;
typedef unsigned short ushort;
typedef unsigned int uint;

typedef struct bgra_t {
    unsigned char b, g, r, a;
} __attribute__((packed)) bgra_t;

typedef struct bgra16_t {
    unsigned short b, g, r, a;
} __attribute__((packed)) bgra16_t;

typedef struct bgra32_t {
    unsigned int b, g, r, a;
} __attribute__((packed)) bgra32_t;

typedef struct bgr_t {
    unsigned char b, g, r;
} __attribute__((packed)) bgr_t;

typedef struct bgr16_t {
    unsigned short b, g, r;
} __attribute__((packed)) bgr16_t;

typedef struct bgr32_t {
    unsigned int b, g, r;
} __attribute__((packed)) bgr32_t;

typedef struct buffer_info_t
{
    int width, height, row_size;
    unsigned char *bytes;
    unsigned int tipo;
} buffer_info_t;

typedef struct configuracion_t {
    char *nombre_filtro;
    int  tipo_filtro;
    buffer_info_t src, src_2, dst;
    void *extra_config;

    char *archivo_entrada;
    char *archivo_entrada_2;
    char  archivo_salida[255];
    char *carpeta_salida;
    char *extra_archivo_salida;

    int bits_src;
    int bits_dst;
    bool es_video;
    bool verbose;
    bool frames;
    bool nombre;
    int cant_iteraciones;
} configuracion_t;

#define SWITCH_C_ASM(config,c_ver,asm_ver) ( config->tipo_filtro == FILTRO_C ? c_ver : asm_ver )
#define C_ASM(config) ( SWITCH_C_ASM(config, "C", "ASM") )

typedef void (lector_params_fn_t) (configuracion_t *config, int, char *[]);
typedef void (aplicador_fn_t) (configuracion_t*);
typedef void (mostrador_ayuda_fn_t) (void);
typedef void (liberar_fn_t) (configuracion_t*);

typedef struct filtro_t {
    char *nombre;
    lector_params_fn_t   *leer_params;
    mostrador_ayuda_fn_t *ayuda;
    aplicador_fn_t       *aplicador;
    liberar_fn_t         *liberar;
} filtro_t;

#define DEFINIR_FILTRO(nombre) filtro_t nombre = {#nombre, leer_params_##nombre, ayuda_##nombre, aplicar_##nombre, liberar_##nombre};

// ~~~ declaraciones de simd ~~~
filtro_t* detectar_filtro(configuracion_t *config);
void      correr_filtro_imagen(configuracion_t *config, aplicador_fn_t aplicador);
void      imprimir_tiempos_ejecucion(unsigned long long int start, unsigned long long int end, int cant_iteraciones);

// ~~~ declaraciones de cli.h ~~~
void      procesar_opciones(int argc, char **argv, configuracion_t *config);
void      imprimir_ayuda ( char *nombre_programa);


#endif   /* !__SIMD__H__ */


