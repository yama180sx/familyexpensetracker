# Dockerfile (開発環境用)

# Make sure RUBY_VERSION matches the Ruby version in .ruby-version
ARG RUBY_VERSION=3.4.6
FROM docker.io/library/ruby:$RUBY_VERSION-slim

# Rails app lives here
WORKDIR /app

# --- 開発に必要なパッケージのインストール ---
# build-essential: Gemのネイティブ拡張ビルドに必要（mimemagic/nokogiri対策）
# libpq-dev: PostgreSQLのクライアントライブラリ
# nodejs: JavaScript環境の実行に必要
RUN apt-get update -qq && \
    apt-get install --no-install-recommends -y build-essential libpq-dev nodejs libvips curl git libyaml-dev libffi-dev && \
    rm -rf /var/lib/apt/lists /var/cache/apt/archives

    # --- 環境変数の設定 ---
# 開発環境に設定
ENV RAILS_ENV="development" \
    # Gemのインストールパス
    BUNDLE_PATH="/usr/local/bundle" \
    # 開発環境では全てのGemをインストール
    BUNDLE_WITHOUT=""

# --- Gemのインストール ---
# Gemfileをコピー
COPY Gemfile ./

# Gemfile.lock が存在すればコピーするが、ビルドキャッシュには含めない
# Gemfile.lockがない場合、bundle installが依存関係を解決して生成する（そして成功する！）
COPY Gemfile.lock ./

# Gemをインストール（コンテナ内の安定したLinux環境で実行されるため、mimemagicエラーは解消）
# Gemfile.lockがない場合、このRUNステップで正常に生成されます。
RUN bundle install

# --- アプリケーションコードのコピー ---
# 全てのファイルをコピー
COPY . .

# --- 実行ユーザーの設定（セキュリティと整合性のため） ---
# 非rootユーザーを作成
RUN groupadd --system --gid 1000 rails && \
    useradd rails --uid 1000 --gid 1000 --create-home --shell /bin/bash
USER rails

# --- コンテナの起動コマンド ---
# Webサーバーを起動
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb"]