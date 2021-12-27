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
    index >= 0 && index < size
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
    puts '-------------------------------------------------'
    puts @label.to_s.center(50)
    puts '-------------------------------------------------'
    puts 'Index'.ljust(6) + '| Item'.ljust(22) + '| Deadline'.ljust(13) + '| Status'.ljust(6)
    puts '-------------------------------------------------'

    @items.each_with_index do |item, idx|
      puts idx.to_s.ljust(6) + "| #{item.title}".ljust(22) + "| #{item.deadline}".ljust(13) + "| #{item.status}".ljust(6)
    end

    puts '-------------------------------------------------'
  end

  def print_full_item(index)
    return false unless valid_index?(index)

    puts '------------------------------------------'
    puts @items[index].title.to_s.ljust(21) + @items[index].deadline.to_s.rjust(21)
    puts @items[index].description.to_s.ljust(21) + @items[index].status.rjust(21)
    puts '------------------------------------------'
    true
  end

  def print_priority
    puts '------------------------------------------'
    puts @items[0].title.to_s.ljust(21) + @items[0].deadline.to_s.rjust(21)
    puts @items[0].description.to_s.ljust(21) + 'Status:' + @items[0].status.rjust(21)
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

  def toggle_item(index)
    item = self[index]
    item&.toggle
  end

  def remove_item(index)
    return false unless valid_index?(index)

    @items.delete_at(index)
    true
  end

  def purge
    @items.delete_if(&:done)
  end
end
