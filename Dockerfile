FROM ruby:3.1.2

# ライブラリのインストール
RUN apt update -qq &&  apt install -y git imagemagick libmagick++-dev sqlite3

# nodejs 16のインストール
RUN curl -sL https://deb.nodesource.com/setup_16.x | bash - && apt install -y nodejs

# yarnのインストール
RUN npm install n -g && npm install -g yarn
RUN gem install rails -v 6.1.7

# ワーキングディレクトリの設定
RUN mkdir /app
WORKDIR /app

# COPY
COPY Gemfile Gemfile.lock /app

# Gemfileのコピーとインストール
RUN bundle install

ENTRYPOINT ["/app/entrypoint.sh"]

# サーバの起動
CMD ["rails", "server", "-b", "0.0.0.0"]