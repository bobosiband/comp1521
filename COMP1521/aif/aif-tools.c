#include "aif.h"
#include <stdint.h>
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#define TRUE 1
#define FALSE 0
// structs
struct aif_header {
    char magic[AIF_MAGIC_SIZE];    
    uint16_t checksum;             
    uint8_t pixel_format;           
    uint8_t compression;           
    uint32_t width;                 
    uint32_t height;                
    uint32_t pixel_data_offset;    
};

// Takes in a RGB color and brightens it by the given percentage amount
uint32_t brighten_rgb(uint32_t color, int amount);

uint16_t calc_checksum(FILE *f, long file_size) {
    uint16_t sum1 = 0;
    uint16_t sum2 = 0;

    fseek(f, 0, SEEK_SET);
    for (long i = 0; i < file_size; i++) {
        uint8_t byte;
        if (fread(&byte, 1, 1, f) != 1) break;
        // Skip checksum bytes
        if (i >= AIF_CHECKSUM_OFFSET && i < AIF_CHECKSUM_OFFSET + AIF_CHECKSUM_SIZE)
            byte = 0;
        sum1 = (sum1 + byte) % 256;
        sum2 = (sum2 + sum1) % 256;
    }
    return (sum2 << 8) | sum1;
}


void stage1_info(int n_files, const char **files) {
    for (int i = 0; i < n_files; i++) {
        const char *file = files[i];
        FILE *f = fopen(file, "rb");
        if (!f) {
            fprintf(stderr, "Error: could not open file %s\n", file);
            continue;
        }

        printf("<%s>:\n", file);

        // File size
        fseek(f, 0, SEEK_END);
        long file_size = ftell(f);
        fseek(f, 0, SEEK_SET);
        printf("File-size: %ld bytes\n", file_size);

        // Read header
        struct aif_header header;
        if (fread(&header, 1, sizeof(header), f) != sizeof(header)) {
            printf("Error: incomplete header\n");
            fclose(f);
            continue;
        }

        // Magic check
        int valid_magic = (memcmp(header.magic, AIF_MAGIC, 4) == 0);
        if (!valid_magic) {
            printf("Invalid header magic.\n");
        }

        // Checksum
        uint16_t calculated = calc_checksum(f, file_size);
        uint8_t stored_low  = header.checksum & 0xFF;
        uint8_t stored_high = (header.checksum >> 8) & 0xFF;

        // print checksum info
        printf("Checksum: %02x %02x", stored_high, stored_low);
        if (calculated != header.checksum) {
            printf(" INVALID, calculated %02x %02x",
                   (calculated >> 8) & 0xFF, calculated & 0xFF);
        }
        printf("\n");

        // Pixel format
        const char *fmt_name = aif_pixel_format_name(header.pixel_format);
        if (fmt_name == NULL) {
            printf("Pixel format: Invalid\n");
        } else {
            printf("Pixel format: %s\n", fmt_name);
        }
        // Compression
        const char *cmp_name = aif_compression_name(header.compression);
        if (cmp_name == NULL) {
            printf("Compression: Invalid\n");
        } else {
            printf("Compression: %s\n", cmp_name);
        }
        // Width
        printf("Width: %u px", header.width);
        if (header.width == 0) printf(" INVALID");
        printf("\n");

        // Height
        printf("Height: %u px", header.height);
        if (header.height == 0) printf(" INVALID");
        printf("\n");
        
        fclose(f);
    }
}

void stage2_brighten(int amount, const char *in_file, const char *out_file) {
    FILE *in = fopen(in_file, "rb");
    if (!in) {
        fprintf(stderr, "Error: could not open input file %s\n", in_file);
        return;
    }
    // Read header
    struct aif_header header;
    if (fread(&header, 1, sizeof(header), in) != sizeof(header)) {
        fprintf(stderr, "Error: could not read header from %s\n", in_file);
        fclose(in);
        return;
    }
    // Get bits per pixel
    int bpp = aif_pixel_format_bpp(header.pixel_format);    

    int bytes_per_pixel = bpp / 8;
    int total_pixels = header.width * header.height;
    int total_bytes = total_pixels * bytes_per_pixel;
    
    // read pixel data
    fseek(in, header.pixel_data_offset, SEEK_SET);
    uint8_t *pixels = malloc(total_bytes);
    if (fread(pixels, 1, total_bytes, in) != total_bytes) {
        fprintf(stderr, "Error: could not read pixel data from %s\n", in_file);
        free(pixels);
        fclose(in);
        return;
    }
    fclose(in);
    // Brighten pixel data
    if (header.pixel_format == AIF_FMT_RGB8) {
        for (int i = 0; i < total_pixels; i++) {
           uint32_t rgb = (pixels[i] << 16) | (pixels[i + 1] << 8) | (pixels[i + 2]);
            rgb = brighten_rgb(rgb, amount);
            pixels[i]     = (rgb >> 16) & 0xFF;
            pixels[i + 1] = (rgb >> 8) & 0xFF;
            pixels[i + 2] = rgb & 0xFF;
        }
    } else if (header.pixel_format == AIF_FMT_GRAY8) {
        for (int i = 0; i < total_pixels; i++) {
            int16_t gray = pixels[i];
            gray = gray + (gray * amount / 100);
            if (gray > 255) gray = 255;
            if (gray < 0) gray = 0;
            pixels[i] = (uint8_t)gray;
        }
    } else {
        fprintf(stderr, "Error: unsupported pixel format for brightening\n");
        free(pixels);
        return;
    }
    // Write output file
    FILE *out = fopen(out_file, "wb");
    fwrite(&header, 1, sizeof(header), out);
    fseek(out, header.pixel_data_offset, SEEK_SET);
    fwrite(pixels, 1, total_bytes, out);
    fclose(out);
    free(pixels);
}

void stage3_convert_color(const char *color, const char *in_file, const char *out_file) {

}

void stage4_decompress(const char *in_file, const char *out_file) {

}

void stage5_compress(const char *in_file, const char *out_file) {

}

///////////////////////////////
// PROVIDED CODE
// It is best you do not modify anything below this line
///////////////////////////////
uint32_t brighten_rgb(uint32_t color, int amount) {
    uint16_t brightest_color = 0;
    uint16_t darkest_color = 255;

    for (int i = 0; i < 24; i += 8) {
        uint8_t c = ((color >> i) & 0xff);
        if (c > brightest_color) {
            brightest_color = c;
        }

        if (c < darkest_color) {
            darkest_color = c;
        }
    }

    double luminance = (
        (brightest_color + darkest_color) / 255.0
    ) / 2;

    double chroma = (
        brightest_color - darkest_color
    ) / 255.0 * 2;

    // Now that we have chroma and luminanace,
    // we can subtract the constant factor from each component
    // m = L - C / 2
    double constant = luminance - chroma / 2;

    // find the new constant
    luminance *= (1.0 + amount / 100.0);

    double adjusted = luminance - chroma / 2;

    for (int i = 0; i < 24; i += 8) {
        int16_t new_val = ((color >> i) & 0xff);

        new_val = (((new_val / 255.0) - constant) + adjusted) * 255.0;

        if (new_val > 255) {
            color |= (0xff << i);
        } else if (new_val < 0) {
            color &= ~(0xff << i);
        } else {
            color &= ~(0xff << i);
            color |= (new_val << i);
        }
    }

    return color;
}
