#Andmestiku lugemine + muud eeltööd----
#raamatud
bk <- read.csv("C:\\Users\\Kasutaja\\Downloads\\books_kaggle.csv", na.strings = c("", " ", "NA", "[]"))

##id-de fail ----
#mille alusel filtreerida, et andmestikud 
filter_text <- read.csv("C:\\Users\\Kasutaja\\Downloads\\filter.csv", 
                        header = TRUE, stringsAsFactors = FALSE)[,1]

# Veendu, et on character
filter_text <- as.character(filter_text)

# Jaga tühikute järgi ja tee numbriteks
filter_rows <- as.numeric(unlist(strsplit(filter_text, " ")))

# Kontrolli indekseid
filter_rows <- filter_rows[!is.na(filter_rows)]  # eemalda võimalikud NA-d

# Filtreeri andmestik
books <- bk[filter_rows, ]

# Vaata tulemust
View(books)
#palju on ridu
nrow(books)
#5000

#veergude kontroll ----
#palju on FirstPublishDate veerus tühje välju
sum(is.na(books$firstPublishDate))
#2081
#palju on tühje välju veerus publishDate
sum(is.na(books$publishDate))
#63
#seeria veerus on tühje välju kui palju
sum(is.na(books$series))
5000-2821

  
#publishDate standardiseerimine/puhastamine ----
# Paigaldame vajalikud paketid, kui pole veel olemas
install.packages("dplyr")
install.packages("stringr")
  
library(dplyr)
library(stringr)

# Funktsioon kuupäevade puhastamiseks ja standardiseerimiseks
  
clean_date <- function(x) {
    x <- as.character(x)
    x <- trimws(x)
    x_lower <- tolower(x)
    
    # Ignoreerime mittestandardsed tekstid ja loendurid
    if(is.na(x) || x == "" || str_detect(x_lower, "unknown|tba|books|voters") || str_detect(x, ",")) {
      return(NA)
    }
    
    # Eemaldame st/nd/rd/th
    x <- str_replace_all(x, "(st|nd|rd|th)", "")
    
    # Otsime neljakohalist aastat
    year_match <- str_extract(x, "\\d{4}")
    if(!is.na(year_match)) {
      year_num <- as.numeric(year_match)
      if(year_num >= 1400 & year_num <= 2025) return(year_num)
      else return(NA)
    }
    
    # Kui ainult kaks numbrit lõpus, oletame 1900 või 2000
    year_match2 <- str_extract(x, "\\d{2}$")
    if(!is.na(year_match2)) {
      year_num <- as.numeric(year_match2)
      if(year_num <= 25) return(2000 + year_num)
      else return(1900 + year_num)
    }
    
    return(NA)
  }
  
# Rakendamine 
##kirjuta tabelisse ----
books$stnd_publishDate <- sapply(books$publishDate, clean_date)
# Kontroll
summary(books$stnd_publishDate)
# Vaata tulemusi
head(books)
View(books)

#zanri-veerg ---- 
str(books$genres)
summary(books$genres[1])
sum(unique(books$genres, na.rm=TRUE))
#võta järjendist 1
books$genres[1]
first_genre <-sapply(books$genres, `[`, 1)
## loenda unikaalsed
length(unique(books$first_genre))
sum(is.na(books$genres))
#kuva välja read, kus on puudu žanr 464
books_na_titles <- books[is.na(books$genres), "title", drop = FALSE]
books_na_titles
#esimene žanr
###kirjuta tabelisse ----
books$first_genre <- sapply(books$genre, function(x) {
  x_clean <- gsub("\\[|\\]|'", "", x)       # eemalda [, ] ja '
  first <- trimws(strsplit(x_clean, ",")[[1]][1])  # võta esimene žanr
  return(first)
})

#sari/seeria-veerg ----
#seeria-ei, seeria-jah
series_yes <- factor(series, levels = 0:1 )
series_yes
##kirjuta_tabelisse ----
books$series_yes <- ifelse(is.na(books$series), 0, 1)
str(first_genre)
class(books$first_genre)
first_genre_factor<-factor(books$first_genre)
class(first_genre_factor)

#sagedustabel, et teha hii-ruut testi ----
## algne tabel ----
sagedustabel <- table(first_genre_factor, books$series_yes);sagedustabel

##read  ≥ 5 ----
valid_rows <- apply(sagedustabel, 1, function(x) all(x >= 5))
sagedustabel_filtered <- sagedustabel[valid_rows, ]

#hii-ruut test - žanr/sari ----
chisq.test(sagedustabel_filtered)
#Crameri V----
# Valimi suurus ja väiksem dimensioon
n <- sum(sagedustabel_filtered)
k <- min(dim(sagedustabel_filtered))
hii.ruut <- chisq.test(sagedustabel_filtered)$statistic
V <- sqrt(hii.ruut / (n * (k-1)))
names(V)<-Cramer
V
##graafik ----
barplot(sagedustabel_filtered)
library(dplyr)
library(tidyr)
library(ggplot2)

# Andmed
sagedus <- data.frame(
  Genre = c("BDSM", "Chick Lit", "Childrens", "Christian", "Christian Fiction", 
            "Classics", "Fantasy", "Fiction", "Graphic Novels", "Historical Fiction",
            "History", "Horror", "Humor", "LGBT", "M M Romance", "Middle Grade",
            "Mystery", "Mythology", "New Adult", "Nonfiction", "Novels", "Paranormal",
            "Picture Books", "Romance", "Science Fiction", "Thriller", "Young Adult"),
  No = c(5,14,18,19,13,80,93,507,11,128,61,56,12,5,11,13,40,7,7,234,32,9,15,72,55,26,172),
  Yes = c(8,8,30,5,25,31,466,132,25,93,15,31,5,6,20,10,140,5,28,21,8,76,12,201,68,30,190)
)

# Top 5 žanri sari "Jah" järgi
top5_jah <- sagedus %>%
  arrange(desc(Yes)) %>%
  slice(1:5)

# Muuda veerud eestikeelseks ja tidy-vorm
top5_long <- top5_jah %>%
  mutate(Genre = factor(Genre, levels = rev(top5_jah$Genre[order(-top5_jah$Yes)])))%>%
  rename(Ei = No, Jah = Yes) %>%  # siin nimetame ümber
  pivot_longer(cols = c(Ei, Jah), names_to = "Seeria", values_to = "Arv")

# Eestikeelne tõlge (kui näiteks 'Fantasy' peab olema 'Fantaasia' jne)
genre_translation <- c(
  "Fantasy" = "Fantaasia",
  "Fiction" = "Ilukirjandus",
  "Mystery" = "Põnevus",
  "Romance" = "Romantika",
  "Young Adult" = "Noorsookirjandus"
  # Lisa kõik tõlked vastavalt oma andmetele
)

# Graafik
ggplot(top5_long, aes(x = Genre, y = Arv, fill = Seeria)) +
  geom_bar(stat = "identity", position = "stack") +
  coord_flip() +
  labs(x = "Žanr", y = "Raamatute arv", fill = "Sari") +
  theme_minimal() +
  theme(panel.grid.major.y = element_blank(),  # horisontaalsed peamised jooned
        panel.grid.minor.y = element_blank())+
  scale_fill_manual(values = c("Ei" = "skyblue", "Jah" = "lightblue")) + 
  scale_x_discrete(labels = genre_translation)+
  geom_text(aes(label = Arv, group = Seeria), color = "#3E3E8A", size = 3.5, position = position_stack(vjust = 0.5)) 
#3E3E8A
#2A2A66
#Viis populaarseimat žanrit seeriaraamatute hulgas pealkiri
# Kontroll

#ilmumiaastate jaotus ----
summary(books$stnd_publishDate)
#Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#1904    2003    2009    2007    2013    2021     150 

# Arvuta mediaan ja standardhälve
median_year <- median(books$stnd_publishDate, na.rm = TRUE)
sd_year <- sd(books$stnd_publishDate, na.rm = TRUE)
par(mfrow=c(1,1))
# Histogramm
hist(books$stnd_publishDate, 
     breaks = 50, 
     col = "skyblue", 
     main = "",
     xlab = "Aasta", 
     ylab = "Raamatute arv")



# Lisa mediaani vertikaalne joon
abline(v = median_year, col = "black", lwd = 2)
y_max <- max(h$counts)
# Lisa mediaani aasta tippu
text(x=median_year, 
     y = y_max, # Määrame kõrguse, et tekst ei kattuks teiste elementidega 
     labels = paste("med:", round(median_year, 0)), col = "black", pos = 2, # Paigutab teksti paremale (4: paremal, 3: vasakul, 1: all, 2: üleval)
     cex = 0.8,# Teksti suurus offset = 0.5
)

#sagedustabel ----
#books$series_yes <- ifelse(is.na(books$series),0, 1)
sum(books$stnd_publishDate == 2009, na.rm = TRUE)
names(books)

books$period <- ifelse(books$stnd_publishDate < 2009,
                       "enne 2009",
                       "pärast 2009") 
books$series_yes <- ifelse(books$series_yes == 0, "sari_ei", "sari_jah")
t1<-addmargins(table(books$period, books$series_yes));
t1

#t-test osakaal ----
prop.test(
  x = c(886, 1247),
  n = c(2328, 2522),
  alternative = "less",   # enne < pärast
  correct = FALSE
)

#graafik ----
library(ggplot2)
library(scales)

# Loo andmestik
andmed_joonistamiseks <- data.frame(
  periood = c("enne 2009 a.", "pärast 2009 a."),
  prop_jah = c(0.3806, 0.4944)
)

#
ggplot(andmed_joonistamiseks, aes(x = periood, y = prop_jah, fill = periood)) +
  geom_col(width = 0.6) +  # Veergude joonistamine
  geom_text(aes(label = percent(prop_jah, accuracy = 1)),
            vjust = -0.5, size = 5) +  # Lisab väärtuse iga veeru peale
  scale_y_continuous(labels = percent_format(), limits = c(0, 1)) +  # Y-telg 0–100%
  scale_fill_manual(values = c("skyblue", "skyblue")) +
  labs(
    x = "",
    y = "Sarja raamatute osakaal"
  ) +
  theme_minimal(base_size = 15) +
  theme(
    legend.position = "none",
    panel.grid.major.x = element_blank(),
    panel.grid.minor.y = element_line(color = "#d0d3d4", size = 0.2),
    axis.text.y = element_text(color = "#d0d3d4", size = 14, face = "bold")
  ) +
  # Lisame trendijoon (kaldenurga graafiku) - lineaarne regressioonijoon
  geom_smooth(method = "lm", aes(group = 1), color = "#3E3E8A", linewidth = 0.5, linetype = "solid") +
  geom_point(aes(x = 2, y = 0.4944), color = "#3E3E8A", shape = 16, size = 2) +
  geom_point(aes(x = 1, y = 0.3806), color = "#3E3E8A", shape = 16, size = 2) +
  # Lisame märgi, mis näitab tõusu 11%
  annotate("text", x = 1.5, y = 0.47, label = "11%", color = "#3E3E8A", size = 5, fontface = "bold")








