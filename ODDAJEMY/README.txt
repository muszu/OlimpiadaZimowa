				Olimpiada sportowa
Twórcy:
Aleksandra Mêdrek, Marcin Muszalski, Jakub Szarawarski


Widoki:
- tabela_medalowa - wyœwietla wszystkie pañstwa bior¹ce udzia³ w olimpiadzie i liczbê zdobytych przez nie medali
- multimedalisci - wyœwietla wszystkich uczestników olimpiady i liczbê zdobytych przez nich medali (w tym dru¿ynowo)
- wyniki_hokeja - wyœwietla wyniki wszystkich meczów hokeja (kobiet i mê¿czyzn)
- wyniki_lyzwiarstwo - wyœwietla wyniki wszystkich konkurencji ³y¿wiarstwa szybkiego

Triggery:
- after update/insert on doping
	jeœli wynik jest pozytywny, ustawia wszystkie statusy zawodnika na 'DSQ' i wywo³uje funkcjê aktualizuj¹c¹ klasyfikacjê medalow¹
- before delete on sedziowie
	jeœli jest mo¿liwoœæ, znajduje zastêpstwo i wpisuje do tabeli sedziowie_rozgrywki
- before insert/update on biegi_narciarskie, skoki_narciarskie, lyzwiarstwo_szybkie
	sprawdza, czy w pola definiuj¹ce wynik zawodnika nie s¹ puste (o ile zawodnik ma status 'OK')
- before insert/update on biegi_narciarskie, skoki_narciarskie, lyzwiarstwo_szybkie, hokej
	- zabrania dodania wyniku zawodnika, który nie jest przypisany do danej dyscypliny (w tabeli zawodnicy_dyscypliny)
	- zabrania dodania wyniku, jeœli dyscyplina siê ju¿ zakoñczy³a
	- sprawdza, czy dodawana rozgrywka jest przypisana do odpowiedniej dyscypliny
- before insert/update on zawodnicy_druzyny
	sprawdza, czy zawodnik jest tej samej narodowoœci co dru¿yna, oraz czy jest tej samej p³ci co inni cz³onkowie dru¿yny
- before insert/updtae on zawodnicy_dyscypliny
	sprawdza, czy zawodnik jest odpowiedniej p³ci 
- before insert/update on sedziowie_rozgrywki
	sprawdza, czy dany sêdzia mo¿e sêdziowaæ dan¹ rozgrywkê (czy jest przypisany do odpowiedniej dyscypliny)


Funkcje
- wyniki_ind(integer id_dysc) - przyznaje medale i zwraca wyniki fina³u dyscypliny indywidualnej, której wynikiem jest czas (bez skoków)
- dru_wyniki_bezsk_f(integer id_dysc)  - przyznaje medale i zwraca wyniki fina³u dyscypliny dru¿ynowej, której wynikiem jest suma czasów (bez skoków)
- skoki_dru_wyniki_f(integer id_dysc) - przyznaje medale i zwraca wyniki fina³u dyscypliny indywidualnej, której wynikiem jest suma punktow (tylko skoki)
- skoki_ind_wyniki_f(integer id_dysc)  - przyznaje medale i zwraca wyniki fina³u dyscypliny dru¿ynowej, której wynikiem jest suma punktow (tylko skoki)


