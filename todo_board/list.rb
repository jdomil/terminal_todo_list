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

  def print
    puts '------------------------------------------'
    puts 'GROCERIES'.center(42)
    puts '------------------------------------------'
    puts 'Index'.ljust(6) + '| Item'.ljust(23) + '| Deadline'.ljust(13)
    puts '------------------------------------------'

    @items.each_with_index do |item, idx|
      puts idx.to_s.ljust(6) + "| #{item.title}".ljust(23) + "| #{item.deadline}".ljust(13)
    end

    puts '------------------------------------------'
  end

  def print_full_item(index)
    return false unless valid_index?(index)

    puts '------------------------------------------'
    puts @items[index].title.to_s.ljust(21) + @items[index].deadline.to_s.rjust(21)
    puts @items[index].description.to_s.ljust(42)
    puts '------------------------------------------'
    true
  end

  def print_priority
    puts '------------------------------------------'
    puts @items[0].title.to_s.ljust(21) + @items[0].deadline.to_s.rjust(21)
    puts @items[0].description.to_s.ljust(42)
    puts '------------------------------------------'
  end

  def up(index, amount = 1)
    return false unless valid_index?(index)

    amount.times do
      break if (index - 1).negative?

      @items[index], @items[index - 1] = @items[index - 1], @items[index]
      index -= 1
    end
    true
  end

  def down(index, amount = 1)
    return false unless valid_index?(index)

    amount.times do
      break if (index + 1) >= @items.size

      @items[index], @items[index + 1] = @items[index + 1], @items[index]
      index += 1
    end
    true
  end

  def sort_by_date!
    @items.sort_by!(&:deadline)
  end
end
