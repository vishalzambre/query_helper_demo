FROM public.ecr.aws/y5p3i7c6/parent-image/ruby:2.7.2

ENV BUNDLER_VERSION=2.2.29

WORKDIR /app
ADD Gemfile* /app/

RUN gem install bundler:$BUNDLER_VERSION

RUN bundle install

EXPOSE 3000

COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]

# Configure the main process to run when running the image
CMD ["rails", "server", "-b", "0.0.0.0"]
