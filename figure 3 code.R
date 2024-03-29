#Te cuento: primero cargo este paquete para gr�ficos que es de lo m�s c�modo:
install.packages("ggplot2")
library(ggplot2)

#cargo los datos...
data <- read.csv("Validation.txt", header=T, sep="\t")

#lo que t� ten�as es un poco como esto:
ggplot(
  subset(data, drug=="celecoxib"| drug=="mastinib" | drug== "leflunomide"))+
  geom_point(aes(x=conc, y=count, color=drug))+
  scale_y_continuous(trans="log10")+
  scale_x_continuous(trans="log10")

#...pero entiendo que lo que pides es m�s bien representar las medias:
#Para eso, primero calculo las medias de count por cada nivel de droga, expt y concentraci�n:
means<-aggregate(count~conc*drug*expt, 
                 subset(data, drug=="celecoxib"| drug=="mastinib" | drug== "leflunomide"), 
                 mean)

#y saco el gr�fico con ellas:
ggplot(means,aes(x=conc, y=count, color=drug, group=drug))+
  geom_point()+
  geom_line()+
  facet_wrap(~expt)+
  scale_y_continuous(trans="log10")+
  scale_x_continuous(trans="log10")


#Un poco m�s bonito:
ggplot(means,aes(x=conc, y=count, color=drug, group=drug))+
  geom_line(size=1.5)+
  geom_point(size=3, fill="white", stroke=2.5, shape=21)+
  facet_wrap(~expt)+
  scale_y_continuous(trans="log10", name="count")+
  scale_x_continuous(trans="log10", name="concentration")+
  geom_hline(yintercept=400, linetype="dashed", size=1.5, color="grey70")+
  scale_color_manual(values=c("steelblue", "forestgreen", "tomato3"))+
  theme_bw()


