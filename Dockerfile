# Rubyのバージョンを指定してベースイメージを取得
FROM ruby:3.1

# aptパッケージマネージャーを使ってPostgreSQLクライアントをインストール
RUN apt update -qq && apt install -y postgresql-client

# /team_developmentディレクトリを作成し、作業ディレクトリを設定
RUN mkdir /team_development
WORKDIR /team_development

# GemfileとGemfile.lockをコピーして、bundle installを実行
COPY Gemfile /team_development/Gemfile
COPY Gemfile.lock /team_development/Gemfile.lock
RUN bundle install

# カレントディレクトリのファイルを全てコピー
COPY . /team_development

# entrypoint.shスクリプトを/usr/bin/ディレクトリにコピーし、実行権限を付与
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh

# コンテナのエントリーポイントを設定
ENTRYPOINT ["entrypoint.sh"]

# ポート3000をコンテナの外部に公開
EXPOSE 3000

# デフォルトのコマンドとしてrails serverを実行し、IPアドレス0.0.0.0にバインドする
CMD ["rails", "server", "-b", "0.0.0.0"]
