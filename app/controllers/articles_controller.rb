class ArticlesController < ApplicationController
  def index
    @articles = Article.order(posted_at: :desc)
                       .sort_by{ |a| -1 * a.likes.where(liked: true).count }
                       .group_by{ |a| a.posted_at.beginning_of_day }
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
    @article = Article.find(@liked_article_id)
    like_record = @article.likes.find_or_initialize_by(user_id: current_user.id)
    if like_record.new_record?
      like_record.liked = true
    else
      like_record.toggle(:liked)
    end
    like_record.save!
  end

  private

  def article_params
    params.require(:article).permit(:url, :title)
  end
end
