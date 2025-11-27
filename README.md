# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

## GCP サービスアカウント鍵の設定 (ローカル開発)

このプロジェクトでは GCP のサービスアカウント JSON を使って Cloud API にアクセスします。鍵ファイルをリポジトリにコミットしないでください。

推奨方法:

- 鍵ファイルをリポジトリ外の安全な場所に置く（例: `C:\Users\<you>\\.config\\family_expense_tracker\\gcp-key.json`）。
- PowerShell で一時的に環境変数を設定して起動する:

```powershell
$env:GOOGLE_APPLICATION_CREDENTIALS = 'C:\Users\you\\.config\\family_expense_tracker\\gcp-key.json'
rails server
```

代替: 鍵 JSON を Base64 にエンコードして環境変数 `GCP_CREDENTIALS_JSON_BASE64` に入れる方法をサポートしています。
この場合、起動時に `tmp/gcp-key.json` を作成して `GOOGLE_APPLICATION_CREDENTIALS` を設定します。例 (PowerShell):

```powershell
# $json = Get-Content -Raw 'C:\path\to\gcp-key.json'
# $b64 = [Convert]::ToBase64String([Text.Encoding]::UTF8.GetBytes($json))
# setx GCP_CREDENTIALS_JSON_BASE64 $b64
```

注意:

- 既にリポジトリに鍵をコミットしてしまった場合は、まず `.gitignore` に追加したうえで `git rm --cached <path/to/gcp-key.json>` を実行してインデックスから削除してください。履歴から完全に除去するには `BFG` や `git filter-repo` を使用します（公開済みリポジトリでは履歴改変の影響に注意）。

