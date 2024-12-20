# Usa la última imagen de Ruby
FROM ruby:latest

# Instala dependencias necesarias
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client

# Configura Git (opcional)
RUN git config --global user.name "TevisEv"
RUN git config --global user.email "tevis.espiritu@unas.edu.pe"

# Establece el directorio de trabajo en el contenedor
WORKDIR /usr/src/app

# Instala Rails
RUN gem install rails -v 7.0

# Expone el puerto que usará Rails
EXPOSE 4000