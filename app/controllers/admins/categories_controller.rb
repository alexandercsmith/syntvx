class Admins::CategoriesController < Admins::AdminAppController
  # before_action :set_category, only: %i[]

  # GET /admins/categories
  def index
    private_seo('Categories')
    @categories = Category.admin_search(params[:term], params[:page])
  end

  private

    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def admin_categories_responder(notice)
      respond_to do |format|
        format.html { redirect_to admins_categories_path }
        format.js
      end
    end

end
