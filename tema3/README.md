Toma Mihai Dragos 312CB

Task1:
    La tasku asta am facut destu de usor. M-am gandit initila sa imi salvez locul unde e 1 intr-o var globala
    first_element. Pe aceasta o salvez in stiva
    Dupa fac un loop prin care iterez prin vector si caunt valoare din contor , care o cresc pana la n
    Cand gasesc aceasta valoare atunci imi salvez dau un pop la ecx 
    si dupa fac sa pointeze la elementul actual. Dupa bag elementul curent in stive si continui

Task2a:
    Aici a fost destul de simplu. Mai intai imi salvez valorile si dupa fac
    un simplu cmmdc prin scaderi repetate
    Dupa ce fac asta aplic foruma (a * b)/cmmdc (a,b) pe care l-am facu mai sus
    Asta am facut cu mul si div

Task2b:
    In cadrul acestui task am incercat sa fac o suma in esi . Daca e parantez ( adun 1 si 
    daca am ) scad unu. In momnetul in care ma intalnesc cu suma negativa atunci ies din loop si bag in vecor - 1
    Daca ies cu succes vad ce se intampla in suma. Daca e 0 atunci e parantezare corecta, daca nu atunci pun zero

    Am luat parantezele dand push de la adresa lui eax la cate 4 octeti
    Pe ecx o sa am cate 4 paranteze dar mie imi trb doar prima, dar sunt pe little endian
    asa ca fac and cu 255 ca sa iau doar primu octet. Astfel iua prima paranteza cu succes

Task3:
    La prima parte mi-am alocat dinamic in string in care mi-am bagat toti separatorii
    Dupa ma facut strtok pt prima oara ca sa definesc sirul (ca in c)
    dupa ce am facut primu strtok am salvat valoare in word si dupa am facut un loop while
    aici am facut iara strtok si am baga in sir si tot asa . Cam asta e treaba su strtok

    La QSORT:
        Mai intai mi-am salvat variabielele care imi trebuiau si dupa am apela fucntia cmp
        In aceasta fucntie efctiv am luat de pe stiva cele 2 valori si am comparat mai intai strlen de elementul
        Daca nu erau egale intorceam diferenta lor ,dar daca erau egale atunci bag cu strcmp ca sa fac lexicografic
        Cam asta am facut si atunci cand luam valorie dereferentiam de doua ori ca sa iau ca lumea valorie

        Daca ramaneti in pana de idei pt teme va ofer asta:
        https://www.youtube.com/watch?v=zrqLSi8NMaU

Task4:
    Aici doar am apealt niste chestii pe care le-am gasit in documentati:
        La ip am vazut ca trb eax sa fie 1 si dupa mut toate registerele in vector


        La apic am vazut ca eax = 1 si ce e pe al 9l-lae octet asa ca am facut un si loigic
        Apic e putin ezoteric
        La rdran am vazut ca era in ecx cred ca pe bitul 31 si am facut la first_element

        La urmtaroarele 2 am incercat sa intorc si -1 daca nu sunt pe intel sau amd (nu stiu daca e bine dar am incercat)
        Si am gasit valoriel lor tot in eax = 7 si ceva cu multe chestii

        La cach doar am luiat din eax - ul ala si am pus in string de caractere

