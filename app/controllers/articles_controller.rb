class ArticlesController < ApplicationController
  def index
    articles = Article.joins("LEFT JOIN likes ON articles.id = likes.article_id")
                      .select("articles.*, DATE(articles.posted_at) AS posted_date, SUM( CASE WHEN likes.liked = 't' THEN 1 ELSE 0 END) AS like_cnt")
                      .group("articles.id")
                      .order("posted_date DESC, like_cnt DESC")
    @articles = articles.group_by{ |a| a.posted_date }
  end

  def new
    @article = Article.new
  end

  def create
    @article = current_user.articles.new(article_params)
    @article.posted_at = Time.now
    if @article.save
      redirect_to root_path, notice: 'article created :)'
    else
      redirect_to new_article_path(@article), alert: "#{@article.errors.full_messages.join('\n')}"
    end
  end

  def like
    @liked_article_id = params[:liked_article_id]
    @article = Article.find(@liked_article_id)
    like_record = @article.likes.find_or_initialize_by(user_id: current_user.id)
    if like_record.new_record?
      like_record.liked = true
    else
      like_record.toggle(:liked)
    end
    like_record.save!
    @article_like_cnt = @article.likes.where(liked: true).count
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, notice: 'deleted successfully :)'
  end

  private

  def article_params
    params.require(:article).permit(:url, :title)
  end
end
