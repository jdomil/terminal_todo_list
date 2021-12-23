# frozen_string_literal: true

require './item.rb'
# Class for the list of items
class List
  attr_accessor :label

  def initialize(label)
    @label = label
    @items = []
  end

  def add_item(title, deadline, description = ' ')
    return false unless Item.valid_date?(deadline)

    @items << Item.new(title, deadline, description)
    true
  end

  def size
    @items.size
  end

  def valid_index?(index)
    return false if index.negative? || index > @items.size

    true
  end

  def swap(index1, index2)
    return false unless valid_index?(index1) && valid_index?(index2)

    @items[index1], @items[index2] = @items[index2], @items[index1]
    true
  end

  def [](index)
    @items[index]
  end

  def priority
    @items[0]
  end
end
