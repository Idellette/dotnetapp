# dotnetapp
Etape 1 Logiciels requis

S'assurer si VS Code et git soient installer sur votre poste de travail

Etape 2: Copier les fichiers de App.zip et créer un environnement de travail vs code

Créer un répertoire et copier les fichiers de l'App.zip
Dans un terminal se rassurer d'etre au répertoire
Entrer la commande   git init
Entrer la commande   code .
Une fénetre visual studio code s'ouvre sur votre répertoire de travail

Etape 3: Créer une image et créer un containeur
Créer un fichier Dockerfile et copier ces lignes:
    FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build
    WORKDIR /source
   # copier csproj et restorer en différentes couches
   COPY DotNet.Docker.csproj .
   RUN dotnet restore 
   # copier et publier app et les dépendances
  COPY . .
  RUN dotnet publish -o /app/build -c Release
  # final stage/image
  FROM  mcr.microsoft.com/dotnet/aspnet:7.0
  WORKDIR /app
  COPY --from=build /app/build .
  ENTRYPOINT ["dotnet", "DotNet.Docker.dll"]
  
  Entrer dans le terminal, se positionner sur le répertoire de travail
  Entrer la commande docker build -t nom_image .
  En sortie sur la dernière ligne du terminal, le nom_image s'affiche
  Entrer la commande docker run --name nom_container -d -p 5050:80 nom_image
  Aller sur le net et entrer localhost:5050//weatherforecast
  En sortie, une page s'affiche avec le contenu
[{"date":"2023-04-05","temperatureC":7,"temperatureF":44,"summary":"Mild"},{"date":"2023-04-06","temperatureC":-8,"temperatureF":18,"summary":"Hot"},{"date":"2023-04-07","temperatureC":54,"temperatureF":129,"summary":"Bracing"},{"date":"2023-04-08","temperatureC":23,"temperatureF":73,"summary":"Cool"},{"date":"2023-04-09","temperatureC":-4,"temperatureF":25,"summary":"Cool"}]
