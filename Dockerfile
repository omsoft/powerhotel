FROM ruby:2.3.2

# throw errors if Gemfile has been modified since Gemfile.lock
# RUN bundle config --global frozen 1

# Install apt based dependencies required to run Rails as 
# well as RubyGems. As the Ruby image itself is based on a 
# Debian image, we use apt-get to install those.
RUN apt-get update -yqq \
	&& apt-get install -yqq --no-install-recommends \
	build-essential \
	libpq-dev \
	postgresql-client \
	nodejs \
	&& apt-get -q clean \
	&& rm -rf /var/lib/apt/lists/*

# Configure the main working directory. This is the base 
# directory used in any further RUN, COPY, and ENTRYPOINT 
# commands.
RUN mkdir -p /app 
WORKDIR /app

# Configure an entry point, so we don't need to specify 
# "bundle exec" for each of our commands.
ENTRYPOINT ["bundle", "exec"]

# Copy the Gemfile as well as the Gemfile.lock and install 
# the RubyGems. This is a separate step so the dependencies 
# will be cached unless changes to one of those two files 
# are made.
COPY Gemfile* ./
RUN bundle install

# Copy the main application.
COPY . .

# Expose port 3000 to the Docker host, so we can access it 
# from the outside.
EXPOSE 3000

# The main command to run when the container starts.
CMD ["rails", "server", "-b", "0.0.0.0"]

# Start delayed_jobs
#CMD ["bin/delayed_job", "start"]
