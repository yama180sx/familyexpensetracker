# frozen_string_literal: true

source "https://rubygems.org"

# Railsのバージョン
gem "rails", "~> 8.0.3"

# --- MIMEMAGIC ビルドエラー回避策（Windows環境向け） ---
# 1. Active Storageが使用する代替MIMEタイプ検出ライブラリとして marcel を導入。
gem 'marcel', '~> 1.0'

# --- 基本機能 ---
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.5"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma", ">= 5.0"
# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Build JSON APIs with ease [https://github.com/rails/jbuilder]
gem "jbuilder"
# Active Model has_secure_password
# gem "bcrypt", "~> 3.1.7"


# --- 依存関係・環境対応 ---
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ windows jruby ]
# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false
# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing"
gem 'fiddle' # 一部のGemの依存関係として残しておきます

# 画像認識・OCRサービスの代替Gem (安定性が高い)
gem 'google-cloud-vision', '~> 2.0'
# google-genaiがZeitwerk::NameErrorを引き起こすため、自動ロードを無効にする
# gem "google-genai", require: false
# Google Cloud AI Platform (使用しない場合はコメントアウトを推奨)
# gem "google-cloud-ai_platform", "~> 2.0" 

# --- バックグラウンド処理/キャッシング (Solid*シリーズ) ---
# Use the database-backed adapters for Rails.cache, Active Job, and Action Cable
gem "solid_cache"
gem "solid_queue"
gem "solid_cable"

# --- デプロイメント ---
# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false
# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false


# ----------------------------------------------------------------------
# --- 開発・テスト環境 (development, test) ---
# ----------------------------------------------------------------------

group :development, :test do
    # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
    gem "debug", platforms: %i[ mri windows ], require: "debug/prelude"
    # テストフレームワーク
    gem 'rspec-rails', '~> 6.0'
    # ファクトリ（テストデータ生成）
    gem 'factory_bot_rails'
    # 環境変数管理
    gem 'dotenv-rails'
    # デバッグ
    gem 'pry-rails'

    # Static analysis for security vulnerabilities [https://brakemanscanne
    gem "brakeman", require: false
    # Omakase Ruby styling [https://github.com/rails/rubocop-rails-omakase/]
    gem "rubocop-rails-omakase", require: false
end

group :development do
    # Use console on exceptions pages [https://github.com/rails/web-console]
    gem "web-console"
end

group :test do
    # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
    gem "capybara"
    gem "selenium-webdriver"
end