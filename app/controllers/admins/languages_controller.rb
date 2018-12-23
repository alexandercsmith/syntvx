class Admins::LanguagesController < Admins::AdminAppController
  before_action :set_language, only: %i[info]

  # GET /admins/langauges
  def index
    private_seo('Languages')
    @languages = Language.admin_search(params[:term], params[:page])
  end

  # GET /admins/languages/:id
  def info
    respond_to :js
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
