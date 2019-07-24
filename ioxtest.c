#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#define buf_size 20

char *g_Args[buf_size]; 											// need to split the string on ',' before use.
char *file_Args[buf_size];

void string_split (char *string) 
{
	int j = 0;
	char *token; 
	char *rest = string; 
    while ((token = strtok_r(rest, ",", &rest))) {
		g_Args[j++] = token;
		printf("%s\n", g_Args[j-1]);
	}

}

void file_parse(char *fname)
{
	int i = 0;
	FILE *fp = fopen(fname, "r");
	if (fp != NULL) {
		char *buffer = (char *)malloc(buf_size + 5);
		while ( fgets(buffer, buf_size, fp) != NULL ) {
			file_Args[i++] = buffer;
		}
	}
	else {
		printf("file not found\n");
	}
	
}

void help()
{
	printf("help\n");
}

int main (int argc, char *argv[])
{
	int opt;
	
	while ( (opt = getopt(argc, argv, "g:i:x:X:hl:")) != -1 ) {
		switch (opt) {
			case 'g' :
				string_split(argv[optind-1]);
				break;
			case 'l' :
				file_parse(argv[optind-1]);
				break;
			case 'i' :
				break;	
			case 'x' :
				break;
			case 'X' :
				break;
			case 'h' :
				help();
				break;
		}
		
	}
	return 0;
}
