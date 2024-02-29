module AttachmentHelper

  def attached_logo(attachment, resource_name)
    if attachment.attached?
      link_to("#{resource_name}'s logo", url_for(attachment), target: '_blank')
    else
      'No logo attached'
    end
  end
end
