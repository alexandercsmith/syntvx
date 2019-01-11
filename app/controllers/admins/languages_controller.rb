class Admins::LanguagesController < Admins::AdminAppController
  before_action :set_language, only: %i[info edit]

  # GET /admins/langauges
  def index
    private_seo('Languages')
    @all = Language.all_active.count
    @approved = Language.all_approved.count
    @drafts = Language.all_drafts.count
    @featured = Language.all_featured.count
    @languages = Language.admin_search(params[:term], params[:filter], params[:page])
  end

  # GET /admins/languages/trash
  def trash
    private_seo('Languages Trash')
    @languages = Language.all_inactive.paginate(per_page: 25, page: params[:page])
    render template: 'admins/languages/index'
  end

  # GET /admins/language/:id
  def info
  end

  # GET /admins/languages/new
  def new
    private_seo('New Language')
    @language = Language.new
  end

  # GET /admins/languages/:id/edit
  def edit
    private_seo('Edit Language')
  end

  private

  def set_language
    @language = Language.friendly.include_assoc.find(params[:id])
  end

  def admin_languages_responder(notice)
    respond_to do |format|
      format.html { redirect_to admins_languages_path }
      format.js
    end
  end

end
