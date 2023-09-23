/* ************************************************************************* */
/* Organizacion del Computador II                                            */
/*                                                                           */
/*             Biblioteca de funciones para operar imagenes BMP              */
/*                                                                           */
/*   Esta biblioteca permite crear, abrir, modificar y guardar archivos en   */
/*   formato bmp de forma sencilla. Soporta solamente archivos con header de */
/*   versiones info_header (40 bytes) y info_v5_header (124 bytes). Para la  */
/*   primera imagenes de 24 bits (BGR) y la segunda imagenes de 32 (ABGR).   */
/*                                                                           */
/*   bmp.h : headers de la biblioteca                                        */
/*   bmp.c : codigo fuente de la biblioteca                                  */
/*   example.c : ejemplos de uso de la biblioteca                            */
/*               $ gcc example.c bmp.c -o example                            */
/* ************************************************************************* */

#include "libbmp.h"

/* ************************************************************************* */
BMPIH* get_BMPIH(uint32_t width, uint32_t height) {
  if(width%4!=0) return 0; // TODO: dont support padding
  BMPIH* new_bmp_info_ih = (BMPIH*)malloc(sizeof(BMPIH));
  new_bmp_info_ih->biSize   = sizeof(BMPIH);
  new_bmp_info_ih->biWidth  = width;
  new_bmp_info_ih->biHeight = height;
  new_bmp_info_ih->biPlanes = 1;
  new_bmp_info_ih->biBitCount = 32; //TODO: dont support other bitcount
  new_bmp_info_ih->biCompression = BI_RGB;
  new_bmp_info_ih->biSizeImage = width*height*(new_bmp_info_ih->biBitCount/8);
  new_bmp_info_ih->biXPelsPerMeter = 2952; // 75 dpi
  new_bmp_info_ih->biYPelsPerMeter = 2952; // 75 dpi
  new_bmp_info_ih->biClrUsed = 0;
  new_bmp_info_ih->biClrImportant = 0;
  return new_bmp_info_ih;
}

/* ************************************************************************* */
BMPV5H* get_BMPV5H(uint32_t width, uint32_t height) {
  if(width%4!=0) return 0; // TODO: dont support padding
  BMPV5H* new_bmp_info_v5h = (BMPV5H*)malloc(sizeof(BMPV5H));
  new_bmp_info_v5h->bV5Size   = sizeof(BMPV5H);
  new_bmp_info_v5h->bV5Width  = width;
  new_bmp_info_v5h->bV5Height = height;
  new_bmp_info_v5h->bV5Planes = 1;
  new_bmp_info_v5h->bV5BitCount = 32; //TODO: dont support other bitcount
  new_bmp_info_v5h->bV5Compression = BI_BITFIELDS;
  new_bmp_info_v5h->bV5SizeImage = width*height*(new_bmp_info_v5h->bV5BitCount/8);
  new_bmp_info_v5h->bV5XPelsPerMeter = 2952; // 75 dpi
  new_bmp_info_v5h->bV5YPelsPerMeter = 2952; // 75 dpi
  new_bmp_info_v5h->bV5ClrUsed      = 0;
  new_bmp_info_v5h->bV5ClrImportant = 0;
  new_bmp_info_v5h->bV5RedMask   = 0x00ff0000;
  new_bmp_info_v5h->bV5GreenMask = 0x0000ff00;
  new_bmp_info_v5h->bV5BlueMask  = 0x000000ff;
  new_bmp_info_v5h->bV5AlphaMask = 0xff000000;
  new_bmp_info_v5h->bV5CSType = LCS_sRGB;
  CIEXYZTRIPLE bV5Endpoints_ = {{0,0,0},{0,0,0},{0,0,0}};
  new_bmp_info_v5h->bV5Endpoints = bV5Endpoints_;
  new_bmp_info_v5h->bV5GammaRed   = 0;
  new_bmp_info_v5h->bV5GammaGreen = 0;
  new_bmp_info_v5h->bV5GammaBlue  = 0;
  new_bmp_info_v5h->bV5Intent = LCS_GM_GRAPHICS;
  new_bmp_info_v5h->bV5ProfileData = 0;
  new_bmp_info_v5h->bV5ProfileSize = 0;
  new_bmp_info_v5h->bV5Reserved = 0;
  return new_bmp_info_v5h;
}



/* ************************************************************************* */
BMP* bmp_create(void* info_header, int init_data) {
  unsigned int i;
  BMPIH* ih = (BMPIH*)info_header;

  // (1) creo la data area
  unsigned int data_size = ih->biSizeImage;
  uint8_t* new_bmp_data = (uint8_t*)malloc(data_size);
  if(init_data)
    for(i=0;i<data_size;i++)
      new_bmp_data[i] = 0;

  // (2) creo un nuevo fh
  BMPFH* new_bmp_fh = (BMPFH*) malloc(sizeof(BMPFH));
  new_bmp_fh->bfType[0] = 'B';
  new_bmp_fh->bfType[1] = 'M';
  new_bmp_fh->bfOffBits = ih->biSize + sizeof(BMPFH);
  new_bmp_fh->bfSize = data_size + new_bmp_fh->bfOffBits;
  new_bmp_fh->bfReserved1 = 0;
  new_bmp_fh->bfReserved2 = 0;

  // (3) store information on a BMP struct
  BMP* bmp = (BMP*)malloc(sizeof(BMP));
  bmp->fh = new_bmp_fh;
  bmp->ih = info_header;
  bmp->data = new_bmp_data;

  return bmp;
}



/* ************************************************************************* */
BMP* bmp_copy(BMP* img, int copy_data) {
  unsigned int i;

  // (1) copy the fh
  BMPFH* new_bmp_fh = (BMPFH*) malloc(sizeof(BMPFH));
  (*new_bmp_fh) = (*(img->fh));

  // (2) copy the ih/v5h
  int info_header_size = new_bmp_fh->bfOffBits - sizeof(BMPFH);
  char* new_bmp_info = 0;
  if( info_header_size == sizeof(BMPIH) ) {
    BMPIH* new_bmp_info_ih = (BMPIH*)malloc(sizeof(BMPIH));
    (*new_bmp_info_ih) = *(BMPIH*)(img->ih);
    new_bmp_info = (char*)new_bmp_info_ih;
  } else
  if( info_header_size == sizeof(BMPV5H) ) {
    BMPV5H* new_bmp_info_v5h = (BMPV5H*)malloc(sizeof(BMPV5H));
    (*new_bmp_info_v5h) = *(BMPV5H*)(img->ih);
    new_bmp_info = (char*)new_bmp_info_v5h;
  }

  if( new_bmp_info == 0 ) return 0; // TODO: support other formats

  // (3) data area
  unsigned int data_size = ((BMPIH*)(new_bmp_info))->biSizeImage;
  uint8_t* new_bmp_data = (uint8_t*)malloc(data_size);
  if( copy_data )
    for(i=0;i<data_size;i++)
      new_bmp_data[i] = img->data[i];

  // (4) store information on a BMP struct
  BMP* bmp = (BMP*)malloc(sizeof(BMP));
  bmp->fh = new_bmp_fh;
  bmp->ih = new_bmp_info;
  bmp->data = new_bmp_data;

  return bmp;
}

#define TRUE 1

BMP* bmp_new(int width, int height)
{

  // (1) create bitmap file header?
  BMPFH* bmp_fh = (BMPFH*)get_BMPIH(width, height);

  return bmp_create(bmp_fh, TRUE);
}


/* ************************************************************************* */
BMP* bmp_read(char* src) {

  // (0) open file
  FILE* fsrc = fopen(src,"r");
  if (fsrc == 0) {
      fprintf(stderr, "Error al abrir el archivo.\n");
      return 0;
  } // Error al abrir el archivo

  // (1) read bitmap file header
  BMPFH* bmp_fh = (BMPFH*) malloc(sizeof(BMPFH));
  if(!fread(bmp_fh, sizeof(BMPFH), 1, fsrc)){
      fprintf(stderr, "Error al leer el archivo.\n");
      return 0;
  } // Error al leer el archivo

  // (2) read bitmap info header (TODO: only support BMPV5H(130B) and BMPIH(40B))
  int info_header_size = bmp_fh->bfOffBits - sizeof(BMPFH);
  char* bmp_info = 0;
  if( info_header_size == sizeof(BMPIH) ) {
    bmp_info = malloc(sizeof(BMPIH));
  } else
  if( info_header_size == sizeof(BMPV5H) ) {
    bmp_info = malloc(sizeof(BMPV5H));
  } else
  if( info_header_size == sizeof(BMPV3IH) ) {
    bmp_info = malloc(sizeof(BMPV3IH));
  }
  if(!bmp_info){
      fprintf(stderr, "Formato de archivo no soportado.\n");
      return 0;
  } // Error formato no soportado
  if(!fread(bmp_info, info_header_size, 1, fsrc)){ return 0; } // Error al leer el archivo

  // (3) read bitmap data pixels
  int image_data_size = bmp_fh->bfSize - info_header_size - sizeof(BMPFH);
  uint8_t* bmp_data = (uint8_t*) malloc(image_data_size);
  if(!fread(bmp_data, image_data_size, 1, fsrc)){ return 0; } // Error al leer el archivo

  // (4) store information on a BMP struct
  BMP* bmp = (BMP*)malloc(sizeof(BMP));
  bmp->fh = bmp_fh;
  bmp->ih = bmp_info;
  bmp->data = bmp_data;

  fclose(fsrc);

  return bmp;
}

/* ************************************************************************* */
int bmp_save(char* dst, BMP* img) {
  int r=0,b;

  // (0) open file
  FILE* fdst = fopen (dst,"w+");
  if(fdst == 0){ return 0; } // Error al abrir el archivo

  // (1) write bitmap file header
  b=fwrite(img->fh, sizeof(BMPFH), 1, fdst); r=b;
  if(!b){ return 0; } // Error al escribir el archivo

  // (2) write bitmap info header
  b=fwrite(img->ih, img->fh->bfOffBits-sizeof(BMPFH), 1, fdst); r=r+b;
  if(!b){ return 0; } // Error al escribir el archivo

  // (3) write bitmap data
  b=fwrite(img->data, img->fh->bfSize-img->fh->bfOffBits, 1, fdst); r=r+b;
  if(!b){ return 0; } // Error al escribir el archivo

  fclose(fdst);

  return r;
}

/* ************************************************************************* */
void bmp_delete(BMP* img) {
  free(img->fh);
  free(img->ih);
  free(img->data);
  free(img);
}

/* ************************************************************************* */
uint32_t bmp_width(BMP* img) {
  return (((BMPIH*)(img->ih))->biWidth);
}

/* ************************************************************************* */
uint32_t bmp_height(BMP* img) {
  return (((BMPIH*)(img->ih))->biHeight);
}

/* ************************************************************************* */
uint8_t* bmp_data(BMP* img) {
  return img->data;
}
/* ************************************************************************* */
uint16_t bmp_bit_count(BMP* img) {
  return (((BMPIH*)(img->ih))->biBitCount);
}

/* ************************************************************************* */
uint32_t bmp_compression(BMP* img) {
  return (((BMPIH*)(img->ih))->biCompression);
}

void bmp_set_bit_count(BMP* img, uint16_t new_bit_count) {
  (((BMPIH*)(img->ih))->biBitCount = new_bit_count);
}

/* ************************************************************************* */
uint32_t bmp_bytes_per_row(BMP* img)
{
	return ((bmp_width(img) * bmp_bit_count(img) + 31) >> 5) << 2;
}


/* ************************************************************************* */
void bmp_convert_24_to_32_bpp (BMP *img)
{
	unsigned int * data32 = (unsigned int *)malloc(32 * bmp_height(img) * bmp_width(img));
    unsigned char * data24 = (unsigned char *)img->data;
    unsigned int i = 0;
    unsigned int val;
    for (i = 0; i < bmp_height(img) * bmp_width(img); i++) {
        val = 0xFF;
        val = (val << 8) + data24[3 * i + 2];
        val = (val << 8) + data24[3 * i + 1];
        val = (val << 8) + data24[3 * i];
        data32[i] = val;
    }
    free(data24);
    bmp_set_bit_count(img, 32);
    img->data = (uint8_t*) data32;
    ((BMPIH*)(img->ih))->biSizeImage = bmp_height(img) * bmp_width(img) * 4;
    uint32_t file_size = ((BMPIH*)(img->ih))->biSizeImage + ((BMPIH*)(img->ih))->biSize + sizeof(BMPFH);
    ((BMPFH*)(img->fh))->bfSize = file_size;
}

typedef unsigned char uchar_t;

uchar_t MAX (uchar_t a, uchar_t b)
{
	return a < b? b : a;
}

void bmp_convert_32_to_8_bpp (BMP *img)
{
	unsigned char * data8  = (unsigned char *)malloc(bmp_height(img) * bmp_width(img));
    unsigned char * data32 = (unsigned char *)img->data;
 
	int height = bmp_height(img);
	int width = bmp_width(img);

	//printf("convirtiendo tamaño %d x %d de 32 a 8...\n", width, height);
	for (int i = 0; i < height; i++) {
		for (int j = 0; j < width; j++) {
			uchar_t *p_d = &data8 [(i*width+j)];
			uchar_t *p_s = &data32[(i*width+j)*4];

			*p_d = MAX (p_s[0], MAX ( p_s[1], p_s[2] ) );
		}
	}

    img->data = (uint8_t*) data8;
    bmp_set_bit_count(img, 8);
    ((BMPIH*)(img->ih))->biSizeImage = bmp_height(img) * bmp_width(img);
    uint32_t file_size = ((BMPIH*)(img->ih))->biSizeImage + ((BMPIH*)(img->ih))->biSize + sizeof(BMPFH);
    ((BMPFH*)(img->fh))->bfSize = file_size;

    free(data32);
}


void bmp_convert_8_to_32_bpp (BMP *img)
{
	unsigned char * data32 = (unsigned char *)malloc(4 * bmp_height(img) * bmp_width(img));
    unsigned char * data8  = (unsigned char *)img->data;

	int height = bmp_height(img);
	int width = bmp_width(img);

//	printf("convirtiendo tamaño %d x %d de 8 a 32\n", width, height);
	for (int i = 0; i < height; i++) {
		for (int j = 0; j < width; j++) {
			uchar_t *p_d = &data32[(i*width+j)*4];
			uchar_t *p_s = &data8 [(i*width+j)];

			p_d[0] = *p_s;
			p_d[1] = *p_s;
			p_d[2] = *p_s;
			p_d[3] = 255;
		}
	}
    img->data = (uint8_t*) data32;
    bmp_set_bit_count(img, 32);
    ((BMPIH*)(img->ih))->biSizeImage = bmp_height(img) * bmp_width(img) * 4;
    uint32_t file_size = ((BMPIH*)(img->ih))->biSizeImage + ((BMPIH*)(img->ih))->biSize + sizeof(BMPFH);
    ((BMPFH*)(img->fh))->bfSize = file_size;	printf("done\n");

    free(data8);
}


