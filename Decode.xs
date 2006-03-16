#include "EXTERN.h"
#include "perl.h"
#include "XSUB.h"
#include "ppport.h"

#include <stdlib.h>
#include <stdio.h>
#include <memory.h>

#include "interf_dec.h"
#include "typedef.h"
#include "sp_dec.h"

#ifndef ETSI
#ifndef IF2
#include <string.h>
#define AMR_MAGIC_NUMBER "#!AMR\n"
#endif
#endif

int amr2raw(char *in, char *out) {
	FILE * file_speech, *file_analysis;
	short synth[160];
	int frames = 0;
	int * destate;
	int read_size;
#ifndef ETSI
	unsigned char analysis[32];
	enum Mode dec_mode;
#ifdef IF2
	short block_size[16]={ 12, 13, 15, 17, 18, 20, 25, 30, 5, 0, 0, 0, 0, 0, 0, 0 };
#else
	char magic[8];
	short block_size[16]={ 12, 13, 15, 17, 19, 20, 26, 31, 5, 0, 0, 0, 0, 0, 0, 0 };
#endif
#else
	short analysis[250];
#endif
	/* Process command line options */
	if (in != NULL && out != NULL){
		file_speech = fopen(out, "wb");
		if (file_speech == NULL){
			return 1;
		}
		file_analysis = fopen(in, "rb");
		if (file_analysis == NULL){
			fclose(file_speech);
			return 1;
		}
	} else {
		return 1;
	}

	/* init decoder */
	destate = Decoder_Interface_init();
#ifndef ETSI
#ifndef IF2
	fread( magic, sizeof( char ), strlen( AMR_MAGIC_NUMBER ), file_analysis );
	if ( strncmp( magic, AMR_MAGIC_NUMBER, strlen( AMR_MAGIC_NUMBER ) ) ) {
		fclose( file_speech );
		fclose( file_analysis );
		return 1;
	}
#endif
#endif

#ifndef ETSI
	while (fread(analysis, sizeof (unsigned char), 1, file_analysis ) > 0) {
#ifdef IF2
		dec_mode = analysis[0] & 0x000F;
#else
		dec_mode = (analysis[0] >> 3) & 0x000F;
#endif
		read_size = block_size[dec_mode];
		fread(&analysis[1], sizeof (char), read_size, file_analysis );
#else
	read_size = 250;
	while (fread(analysis, sizeof (short), read_size, file_analysis ) > 0) {
#endif
		frames ++;
		Decoder_Interface_Decode(destate, analysis, synth, 0);
		fwrite( synth, sizeof (short), 160, file_speech );
	}
	Decoder_Interface_exit(destate);
	fclose(file_speech);
	fclose(file_analysis);
	return 0;
}

MODULE = Audio::AMR::Decode		PACKAGE = Audio::AMR::Decode

int
amr2raw(in, out)
		char *in
		char *out
	OUTPUT:
		RETVAL
