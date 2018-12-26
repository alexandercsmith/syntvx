module ApplicationHelper

  @seo_description = 'SYNTVX | A Developer Resource Directory'

  @seo_keywords = 'developer,development,web,mobile,apps,applications,websites,programming,program,code,coding,resource,tool,library,design,ui,ux'

  def public_seo(title, path)
    set_meta_tags title: title.to_s,
                  description: @seo_desciption,
                  keywords: @seo_keywords,
                  index: true,
                  follow: true,
                  og: { title: :title,
                        description: :description,
                        type: 'website',
                        url: path.to_s }
  end

  def private_seo(title)
    set_meta_tags title: title.to_s,
                  description: @seo_desc,
                  keywords: @seo_keys,
                  index: false,
                  follow: false,
                  reverse: true,
                  og: { title: :title,
                        description: :description,
                        type: 'website' }
  end

  def info_seo(title, path, description, image)
    set_meta_tags title: title.to_s,
                  description: description.to_s,
                  image_src: image,
                  keywords: @seo_keywords,
                  index: true,
                  follow: true,
                  og: { title: :title,
                        description: :description,
                        image: :image_src,
                        type: 'website',
                        url: path.to_s }
  end

  def filter_check(filter, param)
    if param.nil?
      return filter == 'all' ? true : false
    else
      return filter == param ? true : false
    end
  end

end
