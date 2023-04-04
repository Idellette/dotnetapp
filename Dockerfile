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