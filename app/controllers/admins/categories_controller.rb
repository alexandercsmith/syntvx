class Admins::CategoriesController < Admins::AdminAppController
  before_action :set_category, only: %i[info edit]

  # GET /admins/categories
  def index
    private_seo('Categories')
    @categories = Category.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/categories/:id
  def info
    respond_to do |format|
      format.js
    end
  end

  # GET /admins/categories/new
  def new
    @category = Category.new
  end

  # GET /admins/categories/:id/edit
  def edit
  end

  private

  def set_category
    @category = Category.friendly.include_assoc.find(params[:id])
  end

  def admin_categories_responder(notice)
    respond_to do |format|
      format.html { redirect_to admins_categories_path }
      format.js
    end
  end

end
