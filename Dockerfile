# 1. Use the .NET 9 SDK to build (it can compile .NET 8 or 9 code)
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

COPY . .
RUN dotnet restore

# 2. Build the project
RUN dotnet publish TodoApp.csproj -c Release -o out

# 3. CRITICAL: Use the .NET 8 Runtime because your app is asking for 8.0.0
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "TodoApp.dll"]