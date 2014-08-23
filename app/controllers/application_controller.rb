class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action do
    set_meta_tags(
      title: t('meta.title'),
      description: t('meta.description'),
      keywords: t('meta.keywords'),
      og: {
        title: t('meta.title'),
        type: 'website',
        url: root_url,
        description: t('meta.description')
      },
      twitter: {
        card: 'summary',
        title: t('meta.title'),
        creator: '@masarakki',
        description: t('meta.description')
      })
  end
end
