class GeminiOcrService
  def initialize(image_file_path)
    # 引数なしでクライアントを作成（認証は環境変数が自動処理）
    @client = Google::Cloud::Vision.image_annotator
    @image_file_path = image_file_path
  end

  def extract_receipt_data
    # 画像をバイナリとして読み込む
    content = File.binread(@image_file_path)
    
    # リクエストの作成
    image = { content: content }
    feature = { type: :DOCUMENT_TEXT_DETECTION }
    request = { image: image, features: [feature] }

    # ★ここを修正: batch_annotate_images を使用する
    response = @client.batch_annotate_images(requests: [request])

    # 結果の取得
    return response.responses.first&.full_text_annotation&.text
  rescue => e
    puts "エラー発生: #{e.message}"
    return nil
  end
end