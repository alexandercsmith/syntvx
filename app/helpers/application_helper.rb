module ApplicationHelper

  def public_seo(title, path)
    set_meta_tags title: title.to_s,
                  description: 'SYNTVX | A Developer Resource Directory',
                  keywords: 'developer,development,web,mobile,apps,applications,websites,programming,program,code,coding,resource,tool,library,design,ui,ux',
                  index: true,
                  follow: true,
                  image_src: '/default-logo.png',
                  og: { title: :title,
                        description: :description,
                        image: :image_src,
                        type: 'website',
                        url: path.to_s }
  end

  def private_seo(title)
    set_meta_tags title: title.to_s,
                  description: 'SYNTVX | A Developer Resource Directory',
                  keywords: 'developer,development,web,mobile,apps,applications,websites,programming,program,code,coding,resource,tool,library,design,ui,ux',
                  index: false,
                  follow: false,
                  reverse: true,
                  og: { title: :title,
                        description: :description,
                        type: 'website' }
  end

  def info_seo(title, path, description)
    set_meta_tags title: title.to_s,
                  description: description.to_s,
                  keywords: 'developer,development,web,mobile,apps,applications,websites,programming,program,code,coding,resource,tool,library,design,ui,ux',
                  index: true,
                  follow: true,
                  image_src: '/default-logo.png',
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
