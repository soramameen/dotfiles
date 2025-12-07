# ~/ask_ai.py
import sys
import os
from openai import OpenAI

# Neovimから「引数」として質問を受け取る
if len(sys.argv) < 2:
    print("質問を入力してください")
    sys.exit()

question = sys.argv[1]

# クライアント設定 (Gemini APIを使う場合)
client = OpenAI(
    api_key=os.environ.get("GEMINI_API_KEY"), # 環境変数から取得
    base_url="https://generativelanguage.googleapis.com/v1beta/openai/"
)

try:
    response = client.chat.completions.create(
        model="gemini-2.0-flash", # 最新モデル推奨
        messages=[
            {"role": "system", "content": "あなたは優秀なエンジニアです。簡潔に、日本語で回答して。"},
            {"role": "user", "content": question}
        ]
    )
    # 結果をprintする（これがNeovimに表示される）
    print(response.choices[0].message.content)

except Exception as e:
    print(f"Error: {e}")
