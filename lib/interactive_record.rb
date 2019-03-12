require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord

  def self.table_name
    self.to_s.downcase.pluralize
  end

  def self.column_names
    column_names = []
    sql = "PRAGMA table_info('#{table_name}')"
    table_info = DB[:conn].execute(sql)
    table_info.each do |col|
      column_names << col["name"]
    end
    column_names.compact
  end 

  def initialize(options = {})
    options.each do |key,value|
      self.send(("#{key}="),value)
    end
  end

end
