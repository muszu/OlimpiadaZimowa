				Olimpiada sportowa
Tw�rcy:
Aleksandra M�drek, Marcin Muszalski, Jakub Szarawarski


Widoki:
- tabela_medalowa - wy�wietla wszystkie pa�stwa bior�ce udzia� w olimpiadzie i liczb� zdobytych przez nie medali
- multimedalisci - wy�wietla wszystkich uczestnik�w olimpiady i liczb� zdobytych przez nich medali (w tym dru�ynowo)
- wyniki_hokeja - wy�wietla wyniki wszystkich mecz�w hokeja (kobiet i m�czyzn)
- wyniki_lyzwiarstwo - wy�wietla wyniki wszystkich konkurencji �y�wiarstwa szybkiego

Triggery:
- after update/insert on doping
	je�li wynik jest pozytywny, ustawia wszystkie statusy zawodnika na 'DSQ' i wywo�uje funkcj� aktualizuj�c� klasyfikacj� medalow�
- before delete on sedziowie
	je�li jest mo�liwo��, znajduje zast�pstwo i wpisuje do tabeli sedziowie_rozgrywki
- before insert/update on biegi_narciarskie, skoki_narciarskie, lyzwiarstwo_szybkie
	sprawdza, czy w pola definiuj�ce wynik zawodnika nie s� puste (o ile zawodnik ma status 'OK')
- before insert/update on biegi_narciarskie, skoki_narciarskie, lyzwiarstwo_szybkie, hokej
	- zabrania dodania wyniku zawodnika, kt�ry nie jest przypisany do danej dyscypliny (w tabeli zawodnicy_dyscypliny)
	- zabrania dodania wyniku, je�li dyscyplina si� ju� zako�czy�a
	- sprawdza, czy dodawana rozgrywka jest przypisana do odpowiedniej dyscypliny
- before insert/update on zawodnicy_druzyny
	sprawdza, czy zawodnik jest tej samej narodowo�ci co dru�yna, oraz czy jest tej samej p�ci co inni cz�onkowie dru�yny
- before insert/updtae on zawodnicy_dyscypliny
	sprawdza, czy zawodnik jest odpowiedniej p�ci 
- before insert/update on sedziowie_rozgrywki
	sprawdza, czy dany s�dzia mo�e s�dziowa� dan� rozgrywk� (czy jest przypisany do odpowiedniej dyscypliny)


Funkcje
- wyniki_ind(integer id_dysc) - przyznaje medale i zwraca wyniki fina�u dyscypliny indywidualnej, kt�rej wynikiem jest czas (bez skok�w)
- dru_wyniki_bezsk_f(integer id_dysc)  - przyznaje medale i zwraca wyniki fina�u dyscypliny dru�ynowej, kt�rej wynikiem jest suma czas�w (bez skok�w)
- skoki_dru_wyniki_f(integer id_dysc) - przyznaje medale i zwraca wyniki fina�u dyscypliny indywidualnej, kt�rej wynikiem jest suma punktow (tylko skoki)
- skoki_ind_wyniki_f(integer id_dysc)  - przyznaje medale i zwraca wyniki fina�u dyscypliny dru�ynowej, kt�rej wynikiem jest suma punktow (tylko skoki)


