_My part of the group project for the Data Analysis Course. 
The English translation was made with the help of AI. 
Pics/tables are in Estonian at the moment._

- [Genre and Series](#genre-and-series)
  - [Hypotheses]

- [Series and year](#series-and-year)
  - [Hypotheses]

- [Dataset](#dataset)

# Genre and Series

When reading, one needs to be careful with some genres, because by the end of the book it may turn out that it was only the 
first part of a series and the story continues. Based on reading experience, series tend to appear most often in genres such
as fantasy and romance. Biographies, however, practically never occur as series. 
Figure 8 appears to support the same idea. This provides a basis to investigate whether there is a statistically
significant relationship between genre and series.

<img width="689" height="518" alt="image" src="https://github.com/user-attachments/assets/0f7cbd00-6f67-4ee1-9b05-c7a3f49730b4" />


There are 139 genres in total in the sample. A prerequisite for the χ² (chi-square) test is that each
genre must have at least 5 observations for both the presence and absence of a series. Therefore, only 28 genres out
of the 139 remained for the analysis.

## Hypotheses:

H₀: Genre and whether a book belongs to a series are independent variables.

H₁: Genre and whether a book belongs to a series are dependent variables.

**Results of the χ² test:**

The test statistic is very large (937.18), indicating that the observed frequencies differ substantially from
the expected frequencies.

The p-value is significantly smaller than the significance level α (2.2 × 10⁻¹⁶ < 0.05), which shows that the
relationship is statistically significant. In this case, we reject the H₀ hypothesis and accept the alternative hypothesis:
there is a dependency between genre and whether a book belongs to a series.

To evaluate the strength of the relationship, Cramér’s V was used, which produced a value of ~0.5, indicating a 
moderately strong association between the two variables.

Therefore, we can conclude that reacher's reading experience and Figure 8 did not mislead our assumptions.

## Series and Publication Year

Around the turn of the previous century, even people far removed from literature occasionally found themselves 
thinking about Harry Potter. The reason was caused by the media buzz that kept growing with the release of each new book.
In total, 7 books in the series were published between 1997 and 2007. This inspired the idea to investigate whether the proportion of books that are part of a series has increased over time.

When examining the publication year dataset, it became apparent that 150 books were missing this attribute or had 
it filled in incorrectly. Therefore, 4,850 books remained in the sample.

The distribution of publication years has a long left tail (Figure 9), reflecting the dominance of more 
recently published books in the sample.

<img width="655" height="468" alt="image" src="https://github.com/user-attachments/assets/ed360f93-1c02-41c2-9425-b90d25bcf160" />

The oldest book in the dataset dates back to 1904. Indeed, Holmes & Watson were already solving crimes back then.
The most recent publication years in the dataset are from 2021. It’s worth noting that the dataset was compiled in 2022.

To define before and after the year, we chose the median year of 2009, as it divides the dataset exactly in half. 
Books published in 2009 (219) joined the group of books published after 2009.

<img width="642" height="235" alt="image" src="https://github.com/user-attachments/assets/4a73fe70-3361-41cd-95c2-2fed8c21df02" />


## Hypotheses:

H₀: 𝑝 before 2009 ≥ 𝑝 after 2009  The proportion of books belonging to a series has not increased over time.

H₁: 𝑝 before 2009 < 𝑝 after 2009   The proportion of books belonging to a series has increased over time.

**A proportion comparison (using prop.test() with the "less" direction, meaning before 2009 < after 2009) was conducted. 
The result of the test was:**

The p-value is 7.23 × 10⁻¹⁶, which is less than the significance level α, indicating that the relationship 
is statistically significant. Therefore, we reject H₀ and accept the alternative hypothesis: the proportion of books belonging to a series has increased over time.

The proportion of books that are part of a series is 38% before 2009 and 48% after 2009, 
indicating an increase of about 11%. This is illustrated in Figure 9.

<img width="671" height="564" alt="image" src="https://github.com/user-attachments/assets/90c10201-371f-4a76-9fc3-301cb6105c3f" />

Is Harry Potter the only thing behind all of this? Hard to say. Over time, the dynamics of publishing have 
changed (traditional publishing vs. self-publishing). More diverse printing and marketing options allow for budget flexibility. This, in turn, has increased the number of people with the desire to express themselves through writing.

### Dataset:
* [The Goodreads Best Books list of 2022 from Kaggle](https://www.kaggle.com/datasets/thedevastator/comprehensive-overview-of-52478-goodreads-best-b)
* includes 25 attributes for 52,424 books.

#### ID vector
From this, 5000 books were randomly selected, [filter vector](https://github.com/AnuVi/projekt_andmeanalyysi_aines/blob/main/filter.csv).

#### R file
R was used for analysis and creating graphs, [file](https://github.com/AnuVi/projekt_andmeanalyysi_aines/blob/main/raamatud_sari_%C5%BEanr_aasta.R).

