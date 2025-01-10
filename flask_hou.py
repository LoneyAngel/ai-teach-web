from flask_cors import CORS
from openai import OpenAI
from flask import Flask, jsonify, request

app = Flask(__name__)
xinxi=[]


#数据传输的临时规范{status:    ,data:[]}
#请求方的参数要求  {'message': []}



#进行跨域的请求
CORS(app)

#进行api的调用
def work(data):
    client = OpenAI(
        api_key="sk-2kNVd5SD4IeDFeiysiVjTQYoCp0uPbxbtS2hBadHKxAWdbOU",
        # 在这里将 MOONSHOT_API_KEY 替换为你从 Kimi 开放平台申请的 API Key
        base_url="https://api.moonshot.cn/v1",
    )
    completion = client.chat.completions.create(

        messages=[
            {
                "role": "system",
                "content": "你是 Kimi，由 Moonshot AI 提供的人工智能助手，你更擅长中文和英文的对话。你会为用户提供有帮助，准确,有趣的回答。同时，你会拒绝一切涉及恐怖主义，种族歧视，黄色暴力等问题的回答，你面对的是一个学生，请耐心的像一个邻家姐姐一样回答问题。Moonshot AI 为专有名词，不可翻译成其他语言。"
            },
            # 用户的请求
            {
                "role": "user",
                "content": data
            }
        ],
        temperature=0.3,
        model="moonshot-v1-8k",
    )
    text = completion.choices[0].message.content
    print(text)
    return text

#正常的获取数据
@app.route('/hello', methods=['GET'])
def hello():
    return jsonify({'data': 'Hello, World!'})

# 响应对应的网络请求
#/api   获取对应的ai应答

@app.route('/api', methods=['GET'])
def api():
    # 获取JSON数据
    message = request.args.get('message')


    data=work(message)
    xinxi.append(data)
    result=jsonify({'data': data})
    print(result)
    return result


@app.route('/get_list', methods=['GET'])
def get_list():
    result = jsonify({'data': xinxi})
    return xinxi


# 定义一个启动服务器的入口点
if __name__ == '__main__':
    app.run(debug=True)



