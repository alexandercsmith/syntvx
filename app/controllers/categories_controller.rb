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

    respond_to do |format|
      if @category.save
        format.html { redirect_to admins_categories_path, notice: 'Category was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /categories/:id
  def update
    respond_to do |format|
      if @category.update(category_params)
        format.html { redirect_to admins_categories_path, notice: 'Category was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # PATCH/PUT /languages/:id/approve
  def approve
    @category.approval_toggle
    respond_to do |format|
      format.html { redirect_to admins_categories_path }
      format.js
    end
  end

  # PATCH/PUT /languages/:id/feature
  def feature
    @category.feature_toggle
    respond_to do |format|
      format.html { redirect_to admins_categories_path }
      format.js
    end
  end

  # PATCH/PUT /languages/:id/delete
  def delete
    @category.delete_toggle
    respond_to do |format|
      format.html { redirect_to admins_categories_path }
      format.js
    end
  end

  # DESTROY /categories/:id
  def destroy
    @category.destroy
    respond_to do |format|
      format.html { redirect_to admins_categories_path, notice: 'Category was successfully destroyed.' }
    end
  end

  private

    def set_category
      @category = Category.friendly.find(params[:id])
    end

    def category_params
      params.require(:category).permit(:name, :slug, :description,
                                       :approved, :featured, :deleted,
                                       :style)
    end

    def admin_categories_responder(notice)
    end

end
