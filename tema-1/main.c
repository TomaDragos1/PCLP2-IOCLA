#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "structs.h"
#include <inttypes.h>

//alocare pt fiecare structura primita
data_structure *alocare_data(char *line)
{
	line = strtok(NULL, " \n");
	data_structure *crt_data = malloc(sizeof(data_structure));
	crt_data->header = malloc(sizeof(head));
	crt_data->data = NULL;
	crt_data->header->len = 0;
	crt_data->header->type = line[0];
	char *dedicator = strtok(NULL, " \n");
	int lungime1 = strlen(dedicator) + 1;
	crt_data->data = malloc(lungime1);
	if (crt_data->data == NULL)
	{
		free(crt_data->header);
		free(crt_data);
		return NULL;
	}
	//dedicator inserare in sir
	memcpy(crt_data->data, dedicator, lungime1);
	crt_data->header->len += lungime1;
	//fac suma pt fiecare caz
	if (crt_data->header->type == '1')
	{
		crt_data->data = realloc(crt_data->data, crt_data->header->len + sizeof(int8_t) + sizeof(int8_t));
		int8_t suma1;
		line = strtok(NULL, " \n");
		suma1 = (int8_t)atoi(line);
		int8_t suma2;
		line = strtok(NULL, " \n");
		suma2 = (int8_t)atoi(line);
		memcpy(crt_data->data + crt_data->header->len, &suma1, sizeof(suma1));
		crt_data->header->len += sizeof(suma1);
		memcpy(crt_data->data + crt_data->header->len, &suma2, sizeof(suma2));
		crt_data->header->len += sizeof(suma2);
	}
	if (crt_data->header->type == '2')
	{
		crt_data->data = realloc(crt_data->data, crt_data->header->len + sizeof(int32_t) + sizeof(int16_t));
		int16_t suma1;
		line = strtok(NULL, " \n");
		suma1 = (int16_t)atoi(line);
		int32_t suma2;
		line = strtok(NULL, " \n");
		suma2 = (int32_t)atoi(line);
		memcpy(crt_data->data + crt_data->header->len, &suma1, sizeof(suma1));
		crt_data->header->len += sizeof(suma1);
		memcpy(crt_data->data + crt_data->header->len, &suma2, sizeof(suma2));
		crt_data->header->len += sizeof(suma2);
	}
	if (crt_data->header->type == '3')
	{
		crt_data->data = realloc(crt_data->data, crt_data->header->len + sizeof(int32_t) + sizeof(int32_t));
		int32_t suma1;
		line = strtok(NULL, " \n");
		suma1 = (int32_t)atoi(line);
		int32_t suma2;
		line = strtok(NULL, " \n");
		suma2 = (int32_t)atoi(line);
		memcpy(crt_data->data + crt_data->header->len, &suma1, sizeof(suma1));
		crt_data->header->len += sizeof(suma1);
		memcpy(crt_data->data + crt_data->header->len, &suma2, sizeof(suma2));
		crt_data->header->len += sizeof(suma2);
	}
	char *dedicatul = strtok(NULL, " \n");
	int lungime2 = strlen(dedicatul) + 1;
	void *temp = realloc(crt_data->data, crt_data->header->len + lungime2);
	if (temp == NULL)
	{
		free(crt_data->header);
		free(crt_data);
		return NULL;
	}
	else
	{
		crt_data->data = temp;
	}
	//aici insereaza dedicatul
	memcpy(crt_data->data + crt_data->header->len, dedicatul, lungime2);
	crt_data->header->len += lungime2;
	return crt_data;
}
//printare pentru vector arr
void print(void *arr, int len)
{
	head *pars_header = malloc(sizeof(head));
	if (pars_header == NULL)
	{
		return;
	}

	int parcurgere = 0;
	while (parcurgere < len)
	{
		pars_header->len = 0;
		pars_header->type = 0;
		memcpy(pars_header, arr + parcurgere, sizeof(head));
		int lungime1 = 0;
		printf("Tipul %c\n", pars_header->type);
		//printare dedicator
		while (*(char *)(arr + parcurgere + sizeof(head) + lungime1) != '\0')
		{
			printf("%c", *(char *)(arr + parcurgere + sizeof(head) + lungime1));
			lungime1++;
		}
		parcurgere = parcurgere + lungime1 + 1;
		int suma = 0;
		if (pars_header->type == '1')
		{
			suma = sizeof(int8_t) + sizeof(int8_t);
			parcurgere = parcurgere + suma;
		}
		if (pars_header->type == '2')
		{
			suma = sizeof(int32_t) + sizeof(int16_t);
			parcurgere = parcurgere + suma;
		}
		if (pars_header->type == '3')
		{
			suma = sizeof(int32_t) + sizeof(int32_t);
			parcurgere = parcurgere + suma;
		}
		int lungime2 = 0;
		printf(" pentru ");
		//print dedicat
		while (*(char *)(arr + parcurgere + sizeof(head) + lungime2) != '\0')
		{
			printf("%c", *(char *)(arr + parcurgere + sizeof(head) + lungime2));
			lungime2++;
		}
		printf("\n");
		lungime2++;
		parcurgere = parcurgere - suma;
		//pt sume fac in functie de caz
		if (pars_header->type == '1')
		{
			int8_t suma1;
			int8_t suma2;
			memcpy(&suma1, arr + parcurgere + sizeof(head), sizeof(int8_t));
			parcurgere += sizeof(int8_t);
			memcpy(&suma2, arr + parcurgere + sizeof(head), sizeof(int8_t));
			parcurgere += sizeof(int8_t);
			printf("%" PRId8 "\n", suma1);
			printf("%" PRId8 "\n", suma2);
		}
		if (pars_header->type == '2')
		{
			int16_t suma1;
			int32_t suma2;
			memcpy(&suma1, arr + parcurgere + sizeof(head), sizeof(int16_t));
			parcurgere += sizeof(int16_t);
			memcpy(&suma2, arr + parcurgere + sizeof(head), sizeof(int32_t));
			parcurgere += sizeof(int32_t);
			printf("%" PRId16 "\n", suma1);
			printf("%" PRId32 "\n", suma2);
		}
		if (pars_header->type == '3')
		{
			int32_t suma1;
			int32_t suma2;
			memcpy(&suma1, arr + parcurgere + sizeof(head), sizeof(int32_t));
			parcurgere += sizeof(int32_t);
			memcpy(&suma2, arr + parcurgere + sizeof(head), sizeof(int32_t));
			parcurgere += sizeof(int32_t);
			printf("%" PRId32 "\n", suma1);
			printf("%" PRId32 "\n", suma2);
		}
		printf("\n");
		parcurgere = parcurgere + sizeof(head) + lungime2;
	}
	free(pars_header);
}
//functie adaugare final
int add_last(void **arr, int *len, data_structure *data)
{
	if ((*arr) == NULL)
	{
		(*arr) = malloc(data->header->len + sizeof(head));
		if ((*arr) == NULL)
		{
			return 1;
		}
	}
	else
	{
		void *temp;
		temp = realloc((*arr), (*len) + data->header->len + sizeof(head));
		if (temp == NULL)
		{
			free(*arr);
			return 1;
		}
		else
		{
			*arr = temp;
		}
	}
	//mut memoria in fata
	memmove((*arr) + (*len), data->header, sizeof(head));
	(*len) = (*len) + sizeof(head);
	memmove((*arr) + (*len), data->data, data->header->len);
	(*len) = (*len) + data->header->len;
	return 0;
}
//functie adaugare intre 2 sau final
int add_at(void **arr, int *len, data_structure *data, int index)
{
	int contor = 0;
	int lungime_data = 0;
	int lungime_crt = 0;
	//header de parsare
	head *head_pars = malloc(sizeof(head));
	if (head_pars == NULL)
	{
		return 0;
	}
	lungime_data = data->header->len + sizeof(head);
	//vreau doar sa imi termin functia
	if (index < 0)
	{
		free(head_pars);
		return 2;
	}
	while (1)
	{
		//conditie pt a nu face memcpy in caz ca e peste marime
		//o sa stagneze pt a imi adauga la final in caz ca imi da index mare
		if ((lungime_crt < (*len)))
			memcpy(head_pars, (*arr) + lungime_crt, sizeof(head));
		if (contor == index || (lungime_crt >= (*len)))
		{
			void *temp = realloc((*arr), (*len) + lungime_data);
			if (temp == NULL)
			{
				free(*arr);
				free(head_pars);
				return 0;
			}
			else
			{
				*arr = temp;
			}
			//mut memoria pt a avea loc in sir si adaug elementul
			memmove((*arr) + lungime_crt + lungime_data, (*arr) + lungime_crt, (*len) - lungime_crt);
			memmove((*arr) + lungime_crt, data->header, sizeof(head));
			memmove((*arr) + lungime_crt + sizeof(head), data->data, data->header->len);
			(*len) = (*len) + sizeof(head) + data->header->len;
			break;
		}
		lungime_crt += sizeof(head);
		lungime_crt += head_pars->len;
		contor++;
	}
	free(head_pars);
	return 1;
}
//find si ma folosesc de functia de print
void find(void *data_block, int len, int index)
{
	//header de parsare
	head *head_pars = malloc(sizeof(head));
	if (head_pars == NULL)
	{
		return;
	}
	int contor = 0;
	int lungime_crt = 0;
	if (index < 0)
		return;
	while (1)
	{
		//conditie de iesire
		if (lungime_crt >= (len))
			break;
		memcpy(head_pars, (data_block) + lungime_crt, sizeof(head));
		if (contor == index)
		{
			//apelez print pt 1 element anume
			print((data_block + lungime_crt), sizeof(head) + head_pars->len);
			break;
		}
		lungime_crt += sizeof(head);
		lungime_crt += head_pars->len;
		contor++;
	}
	free(head_pars);
}
//functie delete
int delete_at(void **arr, int *len, int index)
{
	//header de parsare
	head *head_pars = malloc(sizeof(head));
	if (head_pars == NULL)
	{
		return 0;
	}
	int contor = 0;
	int lungime_crt = 0;
	while (1)
	{
		memcpy(head_pars, (*arr) + lungime_crt, sizeof(head));
		if (contor == index)
		{
			int distanta = sizeof(head) + head_pars->len;
			//suprasciu sir pt eliminare
			memmove((*arr) + lungime_crt, (*arr) + lungime_crt + distanta, (*len) - distanta - lungime_crt);
			(*len) = (*len) - distanta;
			//nu am facut if null pt ca nu are cum sa nu fie memorie pt ca scad din len mereu
			*arr = realloc((*arr), (*len));
			break;
		}
		lungime_crt += sizeof(head);
		lungime_crt += head_pars->len;
		contor++;
	}
	free(head_pars);
	return 1;
}
int main()
{
	// the vector of bytes u have to work with
	// good luck :)
	void *arr = NULL;
	int len = 0;
	char *line = (char *)malloc(sizeof(char) * 256);
	char *parsare;
	//aici parsez tot
	while (fgets(line, 256, stdin))
	{
		parsare = strtok(line, " \n");
		if (!strcmp(parsare, "insert"))
		{
			data_structure *crt_data;
			crt_data = alocare_data(parsare);
			if (crt_data == NULL)
			{
				free(arr);
				free(line);
				return 0;
			}
			int rez = add_last(&arr, &len, crt_data);
			free(crt_data->header);
			free(crt_data->data);
			free(crt_data);
			if (rez == 1)
			{
				free(arr);
				free(line);
				return 0;
			}
		}
		if (!strcmp(parsare, "insert_at"))
		{
			parsare = strtok(NULL, " \n");
			int index = atoi(parsare);
			data_structure *crt_data;
			crt_data = alocare_data(parsare);
			if (crt_data == NULL)
			{
				free(arr);
				free(line);
				return 0;
			}
			int rez = add_at(&arr, &len, crt_data, index);
			free(crt_data->header);
			free(crt_data->data);
			free(crt_data);
			if (rez == 0)
			{
				free(arr);
				free(line);
				return 0;
			}
		}
		if (!strcmp(parsare, "print"))
		{
			print(arr, len);
		}
		if (!strcmp(parsare, "delete_at"))
		{
			parsare = strtok(NULL, " \n");
			int index = atoi(parsare);
			int rez = delete_at(&arr, &len, index);
			if (rez == 0)
			{
				free(arr);
				free(line);
				return 0;
			}
		}
		if (!strcmp(parsare, "find"))
		{
			parsare = strtok(NULL, " \n");
			int index = atoi(parsare);
			find(arr, len, index);
		}
		if (!strcmp(parsare, "exit"))
		{
			free(arr);
		}
	}
	free(line);
	return 0;
}
