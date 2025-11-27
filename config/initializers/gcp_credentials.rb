# config/initializers/gcp_credentials.rb
# 環境変数から GCP のサービスアカウント JSON を読み込む
#
# 使い方:
# - 簡易 (ファイルパスを直接指定する場合):
#   環境変数 `GOOGLE_APPLICATION_CREDENTIALS` に鍵ファイルへのパスを設定する
# - セキュア (ファイルをリポジトリに置きたくない場合):
#   鍵JSONを Base64 エンコードして `GCP_CREDENTIALS_JSON_BASE64` に設定すると
#   起動時に `tmp/gcp-key.json` を作成して `GOOGLE_APPLICATION_CREDENTIALS` に設定します。

if ENV['GCP_CREDENTIALS_JSON_BASE64'].to_s.strip != ''
  require 'base64'
  tmp_dir = Rails.root.join('tmp')
  tmp_dir.mkpath unless tmp_dir.exist?
  tmp_path = tmp_dir.join('gcp-key.json')
  begin
    File.write(tmp_path, Base64.decode64(ENV['GCP_CREDENTIALS_JSON_BASE64']))
    ENV['GOOGLE_APPLICATION_CREDENTIALS'] ||= tmp_path.to_s
  rescue => e
    Rails.logger.error("Failed to write decoded GCP credentials: ") if defined?(Rails)
    raise e
  end
end
