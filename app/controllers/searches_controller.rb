class SearchesController < ApplicationController
  before_action :authenticate_user!

  def search
    # viewのform_tagにて選択したmodelの値を@modelに代入
    @model = params["model"]
    # 選択した検索方法の値を@modelに代入
    @method = params["method"]
    # 検索ワードを@contentに代入
    @content = params["content"]
    # @model, @method, @contentを代入した、search_forを@recordsに代入
    @records = search_for(@model, @method, @content)
  end

  private
  def search_for(model, method, content)
    # 選択したmodelがuserだったら
    if model == 'user'
      # 選択した検索方法が完全一致だったら
      if method == 'perfect'
        User.where(name: content)
      # 選択した検索方法が部分一致だったら
      else
        User.where('name LIKE ?', '%'+content+'%')
      end
    # 選択したmodelがbookだったら
    elsif model == 'book'
      if method == 'perfect'
        Book.where(title: content)
      else
        Book.where('title LIKE ?', '%'+content+'%')
      end
    end
  end

end
