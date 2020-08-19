FROM algonauti/ruby

RUN apk add --update --no-cache \
      imagemagick \
      poppler \
      poppler-utils


RUN gem install foreman

WORKDIR /app

EXPOSE 3000
