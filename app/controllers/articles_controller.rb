class ArticlesController < ApplicationController
  def index
    @articles = Article.order(posted_at: :desc).group_by{ |a| a.posted_at.beginning_of_day }
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.posted_at = Time.now
    @article.save!
    redirect_to root_path, notice: 'article created :)'
  end
  private

  def article_params
    params.require(:article).permit(:url, :title)
  end
end
