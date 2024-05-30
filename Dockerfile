FROM ruby:3.3.1

# Node.jsとYarnをインストール
RUN apt-get update -qq && apt-get install -y nodejs npm && npm install -g yarn

# 作業ディレクトリを設定
WORKDIR /my_mongo_app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY . .

EXPOSE 3000

CMD ["rails", "server", "-b", "0.0.0.0"]
