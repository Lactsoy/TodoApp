# 1. Use the .NET 8 SDK to build
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /app

# 2. Copy everything and restore
COPY . .
RUN dotnet restore

# 3. Build the specific project
RUN dotnet publish TodoApp.csproj -c Release -o out

# 4. Use the .NET 8 Runtime to run
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# 5. Railway Port setup
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "TodoApp.dll"]