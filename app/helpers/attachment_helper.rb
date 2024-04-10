# frozen_string_literal: true

module AttachmentHelper
  def attached_logo(attachment, resource_name)
    if attachment.attached?
      link_to("#{resource_name}'s logo", url_for(attachment), target: '_blank', rel: 'noopener')
    else
      'No logo attached'
    end
  end

  def attachment_attributes(object)
    fields = { as: :file, input_html: { accept: 'image/*' } }
    return fields unless  object.service_provider_logo.attached?

    fields.merge(hint: image_tag(object.service_provider_logo, width: 100, height: 100))
  end
end
