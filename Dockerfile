# 1. Use .NET 10 SDK to build
FROM mcr.microsoft.com/dotnet/sdk:10.0 AS build
WORKDIR /app

COPY . .
RUN dotnet restore

# 2. Build specific project
RUN dotnet publish TodoApp.csproj -c Release -o out

# 3. Use .NET 10 Runtime to match your PC
FROM mcr.microsoft.com/dotnet/aspnet:10.0
WORKDIR /app
COPY --from=build /app/out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "TodoApp.dll"]