# 1. Use the .NET 9 SDK to build the project
FROM mcr.microsoft.com/dotnet/sdk:9.0 AS build
WORKDIR /app

# 2. Copy and restore dependencies
COPY . .
RUN dotnet restore

# 3. Build the specific project file
RUN dotnet publish TodoApp.csproj -c Release -o out

# 4. Use the .NET 8 Runtime to match your TargetFramework
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .

# 5. Set the port and start the app
ENV ASPNETCORE_URLS=http://+:8080
EXPOSE 8080
ENTRYPOINT ["dotnet", "TodoApp.dll"]