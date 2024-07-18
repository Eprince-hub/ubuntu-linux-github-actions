# Use offocial ubuntu image as base image
FROM ubuntu:latest

# Set environment variables to avoid interactive prompts
ENV DEBIAN_FRONTEND=noninteractive

# Set timezone to Europe/Vienna (Austria)
ENV TZ=Europe/Vienna

# Install prerequisites and PostgreSQL
RUN apt-get update && \
    apt-get install -y wget gnupg2 lsb-release tzdata sudo && \
    sh -c 'echo "deb http://apt.postgresql.org/pub/repos/apt $(lsb_release -cs)-pgdg main" > /etc/apt/sources.list.d/pgdg.list' && \
    wget --quiet -O - https://www.postgresql.org/media/keys/ACCC4CF8.asc | apt-key add - && \
    apt-get update && \
    apt-get install -y --no-install-recommends postgresql-16 && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN usermod -aG sudo postgres && \
    echo "postgres ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/postgres


# Set environment variables and configurations for both bash and zsh
RUN echo "export PSQL_PAGER=\"less --chop-long-lines --header 1\"" >> ~/.bashrc && \
    echo "export PSQL_PAGER=\"less --chop-long-lines --header 1\"" >> ~/.zshrc

    # Expose PostgreSQL port
EXPOSE 5432

# Start PostgreSQL service on container startup
CMD service postgresql start && tail -f /dev/null
