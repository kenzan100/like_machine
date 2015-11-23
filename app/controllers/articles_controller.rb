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

  def like
    @liked_article_id = params[:liked_article_id]
    article = Article.find(@liked_article_id)
    article.likes.find_or_create_by!(user_id: current_user.id)
    @liked_count = article.likes.count
  end

  private

  def article_params
    params.require(:article).permit(:url, :title)
  end
end
