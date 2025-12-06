_Minu osa andmeanalüüsi aine grupitööst._

#Žanri ja sarja seos

Lugemisel tuleb mõnede žanritega olla ettevaatlik, sest raamatu lõppedes selgub, et tegu oli kõigest sarja esimese osaga ning lugu läheb edasi. Lugemiskogemuse pealt võib öelda, et enim kipub sarju olema, nt fantaasia ja romantika vormides. Elulood aga sarjateostena praktiliselt ei esine. Joonis 8 paistab sama mõtet toetavat. See annab alust uurida, kas žanri ja sarja vahel on statistiliselt oluline seos. 

<img width="689" height="518" alt="image" src="https://github.com/user-attachments/assets/0f7cbd00-6f67-4ee1-9b05-c7a3f49730b4" />

Valimis on kokku nimetatud 139 žanri. 𝜒2 - testi eelduseks on, et igal žanril on vähemalt 5 vaatlust sarja olemasolu ja ka sarja puudumise kohta. Nii jäi testi analüüsimiseks alles 139-st alles 28 žanri.

##Püstitatud hüpoteesid:

H0: Žanr ja raamatu sarja kuulumine on sõltumatud tunnused.
H1: Žanr ja raamatu sarja kuulumine on sõltuvad tunnused.


<img width="689" height="518" alt="image" src="https://github.com/user-attachments/assets/0f7cbd00-6f67-4ee1-9b05-c7a3f49730b4" />


 Joonis 8. 5 suurima sarjaraamatute arvuga žanrit

**𝜒2 - test tulemused:**

Statistik on väga suur ( 937.18), mis näitab, et vaadeldud sagedused erinevad oluliselt oodatud sagedustest.

p-väärtuse märgatavalt väiksem olemine olulisuse nivoost ⍺ (2.2 x 10 -16 < 0.05) tõendab, et tegu on statistiliselt olulise seosega. Sel juhul lükkame tagasi H0 hüpoteesi ning võtame vastu alternatiivse hüpoteesi: žanri ja raamatu sarja kuulumise vahel on sõltuvus.

Seose tugevuse hindamiseks kasutatud Crameri V andis väärtuseks ~ 0.5, mis viitab mõõdukalt tugevale seosele nende kahe tunnuse vahel.

Seega võime öelda, et lugemiskogemus ega ka joonis 8 meie tehtud oletusi ei petnud.


#Sarja ja ilmumisaasta seos

Eelmise sajandivahetuse pöörisel leidis ka kõige kirjanduskaugem inimene ennast aeg-ajalt mõtlemast millegipärast Harry Potterile. Põhjus ilmselt meediakäras, mis iga uue osa saabudes aiva suurenes. Kokku ilmus Potteri sarjas 7 raamatut aastatel 1997-2007. Siit kasvas mõte uurida, kas aja jooksul on seeriate osakaal suurenenud.
Ilmumisaasta andmestikuga tutvudes selgus, et 150 raamatul antud tunnus puudus või oli vigaselt täidetud. Seega jäi sõelale 4850 raamatut, mille ilmumisaastate jaotus on pika vasakpoolse sabaga (joonis 9), peegeldades ajaliselt uuemate raamatute ülekaalu valimis.
Kõige vanem raamat pärineb aastast 1904. Tõesti, Holmes & Watson avastasid kuritegusid juba toona ja kõige uuemad raamatute avaldamise aastad on 2021. Meenutame, et tegu on 2022. a koostatud andmestikuga. 

<img width="655" height="468" alt="image" src="https://github.com/user-attachments/assets/ed360f93-1c02-41c2-9425-b90d25bcf160" />

Joonis 9. Raamatute ilmumisaastate jaotus

Enne ja pärast aasta defineerimiseks valisime mediaaniks oleva aasta 2009, sest see jagabki andmestiku täpselt pooleks. 2009 aasta ilmunud raamatud (219) liitusid grupiga pärast 2009 aastat.

Tabel 1. Raamatute kuulumine sarja enne ja pärast 2009 aastat.
<img width="642" height="235" alt="image" src="https://github.com/user-attachments/assets/4a73fe70-3361-41cd-95c2-2fed8c21df02" />


## Püstitatud hüpoteesid:
H0: p enne​ 2009 ≥ p pärast 2009 Sarja kuuluvate raamatute osakaal ei ole ajas kasvanud.
H1: p enne​ 2009 < p pärast  2009   Sarja kuuluvate raamatute osakaal on ajas kasvanud.

Läbi viidud proportsioonide võrdluse (prop.test() suunaga “less” ehk enne 2009 < pärast 2009, Yeatsi kordaja väljas) tulemuseks saime: 

p väärtus 7.23 × 10⁻¹⁶ < olulisuse nivoost ⍺ ehk statistiliselt on seos oluline. Seega lükkame H0 tagasi ja võtame vastu sisuka hüpoteesi, et sarja kuuluvate raamatute osakaal on ajas kasvanud. Proportsioon sarja kuuluvatest raamatutest vastavalt 38% ja 48% ehk tõus ca 11%. Seda illustreerib joonis 9.

<img width="671" height="564" alt="image" src="https://github.com/user-attachments/assets/90c10201-371f-4a76-9fc3-301cb6105c3f" />


Joonis 9. Sarja kuuluvate raamatute osakaal enne ja pärast 2009. aastat
Kas selle kõige taga on ainult Harry Potter? Raske öelda. Aja jooksul on muutunud kirjastamise dünaamikad (kirjastus vs isekirjastamine). Mitmekesisemad trükkimis- ja turundusvõimalused võimaldavad mängida eelarvega. Mis omakorda on kasvatanud nende inimeste arvu, kel soov teostada ennast kirjutamise kaudu.


### Andmestik: 
- 2022. aasta Goodreads’i parimate raamatute loetelu (https://www.kaggle.com/datasets/thedevastator/comprehensive-overview-of-52478-goodreads-best-b)
- sisaldab 25 tunnust 52 424 raamatu kohta
  
Sellest valiti juhuslikult välja 5000 raamatut. Filtrite vektor on failis

Analüüsimiseks kasutati R-i 

