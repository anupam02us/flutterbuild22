# Build Stage
FROM ubuntu:latest as builder

ENV FLUTTER_HOME=/opt/flutter
ENV PATH=$PATH:$FLUTTER_HOME/bin

RUN apt update && \
    apt install -y curl git unzip xz-utils libglu1-mesa

WORKDIR /app

COPY pubspec.yaml pubspec.lock ./
COPY . .

# Download and install Flutter
RUN git clone https://github.com/flutter/flutter.git $FLUTTER_HOME

# Re-add Flutter to the path
ENV PATH=$PATH:$FLUTTER_HOME/bin

RUN flutter pub get
RUN flutter build web -t lib/main.dart

# Final Stage
FROM nginx:latest

COPY --from=builder /app/build/web /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]

