require 'will_paginate/view_helpers/action_view'

module WillPaginate
  module ActionView
    def will_paginate(collection = nil, options = {})
      options, collection = collection, nil if collection.is_a? Hash
      collection ||= infer_collection_from_controller

      options = options.symbolize_keys
      options[:renderer] ||= BootstrapLinkRenderer
      options[:previous_label] = '&laquo;'
      options[:next_label] = '&raquo;'
      options[:inner_window] = 2

      super(collection, options)
    end

    class BootstrapLinkRenderer < LinkRenderer
      ELLIPSIS = '&hellip;'

      def to_html
        list_items = pagination.map do |item|
          case item
            when Fixnum
              page_number(item)
            else
              send(item)
          end
        end.join(@options[:link_separator])

        list_wrapper = tag :ul, list_items, class: 'pagination', role: 'group'
        tag :nav, list_wrapper, class: @options[:class]
      end

      def container_attributes
        super.except(*[:link_options])
      end

      protected

      def page_number(page)
        link_options = @options[:link_options] || {}

        if page == current_page
          tag :li, tag(:span, page, class: 'page-link'), class: 'page-item active'
        else
          link_options.merge! class: 'page-link', rel: rel_value(page)
          tag :li, link(page, page, link_options), class: 'page-item'
        end
      end

      def previous_or_next_page(page, text, classname)
        link_options = @options[:link_options] || {}

        if page
          link_wrapper = link(text, page, link_options.merge(class: 'page-link'))
          tag :li, link_wrapper, class: '%s page-item' % classname
        else
          span_wrapper = tag(:span, text, class: 'page-link')
          tag :li, span_wrapper, class: '%s page-item disabled' % classname
        end
      end

      def gap
        tag :li, tag(:i, ELLIPSIS, class: 'page-link'), class: 'page-item disabled'
      end

      def previous_page
        num = @collection.current_page > 1 && @collection.current_page - 1
        previous_or_next_page num, @options[:previous_label], 'previous'
      end

      def next_page
        num = @collection.current_page < @collection.total_pages && @collection.current_page + 1
        previous_or_next_page num, @options[:next_label], 'next'
      end
    end
  end
end