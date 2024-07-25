
#include "imagenes.h"

BMP *src_img, *src_img2, *dst_img;

void setear_buffer(buffer_info_t *buffer, BMP *bmp) {
    buffer->bytes              = bmp_data(bmp);
    buffer->width              = bmp_width(bmp);
    buffer->height             = bmp_height(bmp);
    buffer->row_size           = bmp_bytes_per_row(bmp);
}

void imagenes_abrir(configuracion_t *config) {
    // Cargo la imagen
    if ( (src_img = bmp_read (config->archivo_entrada)) == 0 ) {
        fprintf(stderr, "Error abriendo la imagen fuente\n");
        exit(EXIT_FAILURE);
    }
    if (bmp_compression(src_img) != BI_RGB) {
        fprintf(stderr, "Error: La imagen fuente esta comprimida\n");
        exit(EXIT_FAILURE);
    }

    if (bmp_bit_count(src_img) == 24) {
        bmp_convert_24_to_32_bpp(src_img);
    }

    if (config->bits_src == 8) {
        bmp_convert_32_to_8_bpp(src_img);
    }

    if (config->dst.width > 0) {
        dst_img = bmp_new(config->dst.width, config->dst.height);
    } else {
        dst_img = bmp_copy( src_img, 1 );
    }

    if (config->archivo_entrada_2 != NULL) {
        if ( (src_img2 = bmp_read (config->archivo_entrada_2)) == 0 ) {
            fprintf(stderr, "Error abriendo la imagen fuente 2\n");
            exit(EXIT_FAILURE);
        }
        if (bmp_compression(src_img2) != BI_RGB) {
            fprintf(stderr, "Error: La imagen fuente 2 esta comprimida\n");
            exit(EXIT_FAILURE);
        }

        if (bmp_bit_count(src_img2) == 24) {
            bmp_convert_24_to_32_bpp(src_img2);
        }
        setear_buffer(&config->src_2, src_img2);
    } else {
        src_img2 = NULL;
    }
    setear_buffer(&config->src, src_img);
    setear_buffer(&config->dst, dst_img);
}

void imagenes_flipVertical(buffer_info_t *buffer, BMP *bmp) {
    buffer->bytes = utils_verticalFlip(buffer->bytes, buffer->height, buffer->row_size);
    bmp->data = buffer->bytes;
}

void imagenes_guardar(configuracion_t *config) {
    if (config->bits_dst == 8)
        bmp_convert_8_to_32_bpp(dst_img);
    bmp_save(config->archivo_salida, dst_img);
}

void imagenes_liberar() {
    bmp_delete(src_img);
    if (src_img2 != NULL) {
        bmp_delete(src_img2);
    }
    bmp_delete(dst_img);
}



