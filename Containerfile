FROM mcr.microsoft.com/dotnet/sdk:10.0-alpine AS build
WORKDIR /source

RUN mkdir -p ./FSharpBot
COPY *.slnx .
COPY FSharpBot/*.fsproj ./FSharpBot
RUN dotnet restore

# Copy source code and publish app
COPY ./FSharpBot/*.fs ./FSharpBot/
RUN dotnet publish --no-restore -o /app

# Runtime stage
FROM mcr.microsoft.com/dotnet/runtime:10.0-alpine
WORKDIR /app
COPY --from=build /app .
ENTRYPOINT ["./FSharpBot"]