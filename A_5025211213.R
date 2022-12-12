# Nomor 1

## (a)

### Memasukkan data

respondent <- c(1, 2, 3, 4, 5, 6, 7, 8, 9)
x <- c(78, 75, 67, 77, 70, 72, 78, 74, 77)
y <- c(100, 95, 70, 90, 90, 90, 89, 90, 100)

### Memasukkan ke dalam data frame

df <- data.frame(respondent, x, y)
df

### Menghitung selisih antara data sebelum dan sesudah

difference <- abs(df[,3] - df[,2])
difference

### Menghitung standar deviasi

stddev <- sd(difference)
stddev

## (b)

### Mencari nilai t (p-value)

t.test(y, x, paired = TRUE)

## (c)

### Jawaban ada di README.md

# Nomor 2

## (a)

### Jawaban ada di README.md

install.packages("BSDA")
library(BSDA)

## (b)

tsum.test(mean.x = 23500, s.x = 3900, n.x = 100)

## (c)

### Jawaban ada di README.md

# Nomor 3

## (a)

### Jawaban ada di README.md

## (b)

tsum.test(mean.x = 3.64, s.x = 1.67, n.x = 19,
          mean.y = 2.79, s.y = 1.32, n.y = 27,
          alternative = "greater", var.equal = TRUE)

## (c)

install.packages("mosaic")
library(mosaic)

plotDist(dist = 't', df = 2, col = "blue")

## (d)

qchisq(p = 0.05, df = 2, lower.tail = FALSE)

## (e)

### Jawaban ada di README.md

## (f)

### Jawaban ada di README.md

# Nomor 4

## (a)

anovaData <- read.table("onewayanova.txt", header = TRUE)
attach(anovaData)
names(anovaData)

anovaData$Group <- as.factor(anovaData$Group)
anovaData$Group <- factor(anovaData$Group,
                          labels = c("Kucing Oren", "Kucing Hitam", "Kucing Putih"))

class(anovaData$Group)

groupKO <- subset(anovaData, Group == "Kucing Oren")
groupKH <- subset(anovaData, Group == "Kucing Hitam")
groupKP <- subset(anovaData, Group == "Kucing Putih")

qqnorm(groupKO$Length)
qqline(groupKO$Length)

qqnorm(groupKH$Length)
qqline(groupKH$Length)

qqnorm(groupKP$Length)
qqline(groupKP$Length)

## (b)

bartlett.test(Length ~ Group, data = anovaData)

## (c)

model1 <- lm(Length ~ Group, data = anovaData)
anova(model1)

## (d)

### Jawaban ada di README.md

## (e)

TukeyHSD(aov(model1))

## (f)

#install.packages("ggplot2")
library(ggplot2)

ggplot(anovaData, aes(x = Group, y = Length)) + geom_boxplot(fill = "grey70", colour = "black") + scale_x_discrete() + xlab("Treatment Group") + ylab("Length (cm)")

# Nomor 5

## (a)

install.packages("multcompView")
library(readr)
library(multcompView)
library(dplyr)

gtl <- read.csv("GTL.csv")
qplot(x = Temp, y = Light, geom = "point", data = gtl) + facet_grid(.~Glass, labeller = label_both)

## (b)

gtl$Glass <- as.factor(gtl$Glass)
gtl$Temp_Factor <- as.factor(gtl$Temp)

anovaData <- aov(Light ~ Glass*Temp_Factor, data = gtl)
summary(anovaData)

## (c)

summarizedData <- group_by(gtl, Glass, Temp) %>%
  summarise(mean = mean(Light), sd = sd(Light)) %>%
  arrange(desc(mean))

print(summarizedData)

## (d)

tukey <- TukeyHSD(anovaData)
print(tukey)

## (e)

tukey.cld <- multcompLetters4(anovaData, tukey)
print(tukey.cld)

cld <- as.data.frame.list(tukey.cld$`Glass:Temp_Factor`)
summarizedData$Tukey <- cld$Letters
print(summarizedData)