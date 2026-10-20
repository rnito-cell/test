# GBF レビュー返信プロトタイプ

Goodbeer faucets 向けの **Googleレビュー返信下書き → 人が確認して送信** するブラウザアプリです。

## できること

- 未返信レビュー一覧（デモ or Google）
- 各レビューに、投稿内容と言語（日本語／英語）に合わせた丁寧な返信下書き
- 下書きの編集・再生成
- 「この内容で返信する」→ 確認 → 送信（Googleモードでは本番投稿）

## 起動（デモ）

```bash
cd C:\Users\ukish\gbf-review-reply
npm install
npm run dev
```

- Web: http://localhost:5173/
- API: http://localhost:8787/

認証情報がなくてもデモデータでそのまま使えます。

## Google 本番接続

1. [Google Cloud Console](https://console.cloud.google.com/) でプロジェクト作成
2. **Google Business Profile APIs**（Account Management / Business Information / My Business）を有効化  
   ※ My Business API は利用申請が必要な場合があります
3. OAuth クライアント（ウェブアプリ）を作成  
   - 承認済みリダイレクト URI: `http://localhost:8787/api/auth/callback`
4. `.env.example` を `.env` にコピーして値を入れる

```env
GOOGLE_CLIENT_ID=...
GOOGLE_CLIENT_SECRET=...
GOOGLE_REDIRECT_URI=http://localhost:8787/api/auth/callback
GOOGLE_ACCOUNT_ID=
GOOGLE_LOCATION_ID=
```

`.env` に `ANTHROPIC_API_KEY` もあると、日本語レビューは自然な日本語、英語レビューは自然な英語で下書きします。

5. `npm run dev` → 画面の **Googleで接続**
6. 接続後、ブラウザで次を開き ID を控えて `.env` に入れる  
   - http://localhost:8787/api/accounts  
   - http://localhost:8787/api/locations  
   - Location の `name` は `accounts/123/locations/456` 形式 → `456` が LOCATION_ID
7. API を再起動 → **Googleレビューを読む**

## 返信の流れ

1. 下書きを確認・編集
2. **この内容で返信する**
3. ダイアログで **確認して返信する**
4. Google モードのときだけ Business Profile に投稿
