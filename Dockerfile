FROM ruby:3.0

# PostgreSQLクライアントをインストール
RUN apt-get update -qq && apt-get install -y postgresql-client

WORKDIR /myapp

# Node.js (LTS)をインストール
RUN curl -fsSL https://deb.nodesource.com/setup_lts.x | bash - && apt-get install -y nodejs

# Yarnをインストール
RUN npm install --global yarn

# Gemfileをコピーして依存関係をインストール
COPY Gemfile* /team_development/
RUN bundle install

# コンテナが起動するたびに実行されるスクリプトを追加
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

ENTRYPOINT ["entrypoint.sh"]

# コンテナが実行される際にメインプロセスとして設定されるコマンドを指定
CMD ["rails", "server", "-b", "0.0.0.0"]

EXPOSE 3000
