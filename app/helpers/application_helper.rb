# frozen_string_literal: true

module ApplicationHelper
  def quill_data
    {
      options: {
        modules: {
          toolbar: [
            %w[bold italic underline strike],
            %w[blockquote],
            [{ 'list': 'ordered' }, { 'list': 'bullet' }, { 'list': 'check' }],
            %w[link image],
            [{ 'color': [] }, { 'background': [] }],
            [{ 'font': %w[sans-serif serif monospace manrope inter] }],
            [{ 'align': [] }],
            [{ 'script': 'sub' }, { 'script': 'super' }],
            [{ 'direction': 'rtl' }],
            [{ 'header': [1, 2, 3, 4, 5, 6, false] }]
          ]
        },
        placeholder: 'Type something...',
        theme: 'snow'
      }
    }
  end
end
