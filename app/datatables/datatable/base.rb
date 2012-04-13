module Datatable
  class Base

    delegate :params, :to => :@view

    class << self

      attr_accessor :table_class, :sort_columns, :search_columns, :row_block

      def table_for(obj)
        @table_class = obj.to_s.camelcase.constantize
      end

      def sort_by(columns=[])
        @sort_columns = columns
      end

      def search_by(columns=[])
        @search_columns = columns
      end

      def row(block=nil)
        @row_block = block
      end
    end


    def initialize(view)
      @view = view
    end

    def as_json(options={})
      { sEcho: params[:sEcho].to_i,
        iTotalRecords: self.class.table_class.count,
        iTotalDisplayRecords: objects.total_entries,
        aaData: data }
    end

    def data
      objects.map do |object|
        self.class.row_block.call(object, @view)
      end
    end

    def objects
      @objects ||= fetch
    end

    def page
      params[:iDisplayStart].to_i/per_page + 1
    end

    def per_page
      params[:iDisplayLength].to_i > 0 ? params[:iDisplayLength].to_i : 10
    end

    def sort_column
      self.class.sort_columns[params[:iSortCol_0].to_i]
    end

    def sort_direction
      params[:sSortDir_0] == "desc" ? "desc" : "asc"
    end

    def fetch
      objects = self.class.table_class.order("#{sort_column} #{sort_direction}")
      objects = objects.page(page).per_page(per_page)
      if params[:sSearch].present?
        search_string = self.class.search_columns.collect { |c| c + " like :search" }.join(' or ')
        objects = objects.where(search_string, :search => "%#{params[:sSearch]}%")
      end
      objects
    end

  end
end
