# frozen_string_literal: true

require 'date'

# Class for each Item on the list
class Item
  attr_accessor :title, :description
  attr_reader :deadline, :done

  def self.valid_date?(date)
    !!(date.match(/\d{4}-\d{2}-\d{2}/) && Date.strptime(date, '%Y-%m-%d'))
  rescue ArgumentError
    false
  end

  def initialize(title, deadline, description, done = false)
    raise 'Wrong deadline date format' unless Item.valid_date?(deadline)

    @title = title
    @deadline = deadline
    @description = description
    @done = done
  end

  def deadline=(new_deadline)
    raise 'Wrong deadline date format' unless Item.valid_date?(new_deadline)

    @deadline = new_deadline
  end

  def toggle
    @done = !@done
  end

  def status
    if @done
      '[✓]'
    else
      '[ ]'
    end
  end
end
