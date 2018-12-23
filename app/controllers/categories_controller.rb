class CategoriesController < ApplicationController
  before_action :set_category, except: %i[index new create show]
  before_action :authenticate_admin!, except: %i[index show]

  # GET /categories
  def index
    @categories = Category.all_approved
    public_seo('Categories', categories_url)
  end

  # GET /categories/:id
  def show
    @category = Category.slugged(params[:id])
    redirect_to directory_path unless @category.approved || current_admin
  end

  # GET /categories/new
  def new
    @category = Category.new
  end

  # GET /categories/:id/edit
  def edit
  end

  # POST /categories
  def create
    @category = Category.new(category_params)
    if @category.save
      admins_categories_responder('created')
    else
      render :new
    end
  end

  # PATCH/PUT /categories/:id
  def update
    if @category.update(category_params)
      admins_categories_responder('updated')
    else
      render :edit
    end
  end

  # PATCH/PUT /categories/:id/approve
  def approve
    @category.approval_toggle
    admins_categories_responder(@category.approval_check.capitalize)
  end

  # PATCH/PUT /categories/:id/feature
  def feature
    @category.feature_toggle
    admins_categories_responder(@category.featured_check.capitalize)
  end

  # PATCH/PUT /categories/:id/delete
  def delete
    @category.delete_toggle
    admins_categories_responder(@category.deletion_check.capitalize)
  end

  # DESTROY /categories/:id
  def destroy
    @category.destroy
    admins_categories_responder('destroyed')
  end

  private

    def set_category
      @category = Category.friendly.include_assoc.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :slug, :description,
                                       :approved, :featured, :deleted,
                                       :style)
    end

    def admins_categories_responder(notice)
      respond_to do |format|
        format.html do
          redirect_to admins_categories_path,
          notice: "Category #{notice}."
        end
        format.js
      end
    end

end
