#Author: Andrew N Holding
#Based on rocker/rstudio
FROM rocker/rstudio

# Set the working directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
ADD . /app

#Install missing packages
#For R packages
RUN apt-get update -y
RUN apt-get install -y zlib1g-dev
RUN apt-get install -y libxml2-dev
#For macs
RUN apt-get install -y python-pip
RUN apt-get install -y python-numpy
#For bowtie
RUN apt-get -y install libtbb-dev

#Get Rmd from GitHub
RUN wget  https://github.com/andrewholding/Brundle_Example/archive/master.zip
RUN unzip master.zip
#The Rmd in the git makes a pdf, but TexLive is huge so we edit the files to output HTML
RUN cd Brundle_Example-master && sed -i 's/pdf_document/html_document/g' *.Rmd
RUN cd Brundle_Example-master && cp ctcfExample.Rmd /home/rstudio/ctcfExample.Rmd
RUN cd Brundle_Example-master && cp dmExample.Rmd /home/rstudio/dmExample.Rmd

#Install missing R scripts 
RUN Rscript RInstallPackages.R 

#Install MACS2
RUN pip install MACS2

#Bowtie2
RUN wget --output-document=bowtie2-2.3.2-linux-x86_64.zip https://downloads.sourceforge.net/project/bowtie-bio/bowtie2/2.3.2/bowtie2-2.3.2-linux-x86_64.zip?r=https%3A%2F%2Fsourceforge.net%2Fprojects%2Fbowtie-bio%2Ffiles%2Fbowtie2%2F2.3.2%2F
RUN ls
RUN unzip bowtie2-2.3.2-linux-x86_64.zip
RUN cd bowtie2-2.3.2 && cp  bowtie2 bowtie2-align-s bowtie2-align-l bowtie2-build bowtie2-build-s bowtie2-build-l bowtie2-inspect bowtie2-inspect-s bowtie2-inspect-l /usr/bin
RUN rm -rf bowtie2-2.3.2

#Bedtools
RUN wget https://github.com/arq5x/bedtools2/releases/download/v2.26.0/bedtools-2.26.0.tar.gz
RUN tar -xzf bedtools-2.26.0.tar.gz
RUN cd bedtools2 && make && make install
RUN rm -rf bedtools2

#Install preprocessing scripts
RUN cd Brundle_Example-master && mv preprocessing /home/rstudio/

#Copy the sligned merged genome into image. Results in very big file.
#RUN mv genomes /home/rstudio/preprocessing/dmExample

#Clean up
RUN apt-get clean
RUN chown -R rstudio /home/rstudio/*

#Set up container for Rstudio.
EXPOSE 8787
CMD ["/init"]
